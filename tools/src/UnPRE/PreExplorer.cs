//****************************************************************************
//* MODULE:         Tools/UnPRE
//* FILENAME:       PreExplorer.cs
//* DESCRIPTION:    A 7-Zip-style GUI browser for Neversoft .PRE / .PRX
//*                 archives (THUG / THPS engine). Folder tree on the left,
//*                 file list on the right; extract all / selected, and
//*                 double-click to open a contained file with its default app.
//*
//* Self-contained: parses the container and decodes the LZSS payload in pure
//* C#. Built with the in-box .NET Framework compiler, so the resulting .exe
//* runs on any Windows 10/11 machine with no runtime install.
//****************************************************************************

using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Windows.Forms;

namespace PreExplorer
{
    //========================================================================
    // Archive model
    //========================================================================
    class PreFileEntry
    {
        public string Name;          // internal name, '\' separated
        public int    DataSize;      // uncompressed size
        public int    CompressedSize;// 0 == stored
        public long   DataOffset;    // payload offset within the file bytes
        public uint   Checksum;
        public bool   Packed { get { return CompressedSize != 0; } }
    }

    class PreArchive
    {
        const uint Version = 0xabcd0003u;

        public string Path;
        public bool   BigEndian;
        public List<PreFileEntry> Entries = new List<PreFileEntry>();
        byte[] _bytes;

        static uint Swap32(uint v)
        {
            return ((v & 0x000000ffu) << 24) | ((v & 0x0000ff00u) << 8) |
                   ((v & 0x00ff0000u) >> 8)  | ((v & 0xff000000u) >> 24);
        }
        uint U32(long off)
        {
            uint v = (uint)(_bytes[off] | (_bytes[off + 1] << 8) |
                            (_bytes[off + 2] << 16) | (_bytes[off + 3] << 24));
            return BigEndian ? Swap32(v) : v;
        }

        public void Load(string path)
        {
            _bytes = File.ReadAllBytes(path);
            Path = path;
            Entries.Clear();
            if (_bytes.Length < 12) throw new Exception("File too small to be a PRE.");

            BigEndian = false;
            uint ver = U32(4);
            if (ver != Version)
            {
                BigEndian = true;
                ver = U32(4);
                if (ver != Version)
                    throw new Exception(string.Format(
                        "Not a recognized PRE (version 0x{0:x8}).", U32(4)));
            }

            uint numFiles = U32(8);
            long off = 12;
            for (uint i = 0; i < numFiles; i++)
            {
                if (off + 16 > _bytes.Length) break;
                int dataSize = (int)U32(off + 0);
                int compSize = (int)U32(off + 4);
                int nameSize = (int)(U32(off + 8) & 0xffff);
                uint crc     = U32(off + 12);

                long nameOff = off + 16;
                long dataOff = nameOff + nameSize;
                int  actual  = compSize != 0 ? compSize : dataSize;
                if (dataOff + actual > _bytes.Length) break;

                // null-terminated name inside its padded buffer
                int len = 0;
                while (len < nameSize && _bytes[nameOff + len] != 0) len++;
                string name = System.Text.Encoding.ASCII.GetString(_bytes, (int)nameOff, len);

                PreFileEntry e = new PreFileEntry();
                e.Name = name;
                e.DataSize = dataSize;
                e.CompressedSize = compSize;
                e.DataOffset = dataOff;
                e.Checksum = crc;
                Entries.Add(e);

                off = dataOff + ((actual + 3) & ~3);
            }
        }

        public byte[] Extract(PreFileEntry e)
        {
            byte[] outBuf = new byte[e.DataSize];
            if (e.Packed)
                DecodeLZSS(_bytes, e.DataOffset, e.CompressedSize, outBuf);
            else
                Array.Copy(_bytes, e.DataOffset, outBuf, 0, e.DataSize);
            return outBuf;
        }

        // Port of File::DecodeLZSS() (USE_BUFFER path) from the engine.
        const int N = 4096, F = 18, THRESHOLD = 2;
        static void DecodeLZSS(byte[] src, long inOff, int inLen, byte[] outBuf)
        {
            byte[] tb = new byte[N + F - 1];
            for (int i = 0; i < N - F; i++) tb[i] = (byte)' ';
            int r = N - F;
            uint flags = 0;
            long ip = inOff, end = inOff + inLen;
            int op = 0, cap = outBuf.Length;

            for (;;)
            {
                if (((flags >>= 1) & 256) == 0)
                {
                    if (ip >= end) break;
                    uint c = src[ip++];
                    flags = c | 0xff00u;
                }
                if ((flags & 1) != 0)
                {
                    if (ip >= end) break;
                    byte c = src[ip++];
                    if (op < cap) outBuf[op++] = c;
                    tb[r++] = c; r &= (N - 1);
                }
                else
                {
                    if (ip >= end) break;
                    int i = src[ip++];
                    if (ip >= end) break;
                    int j = src[ip++];
                    i |= ((j & 0xf0) << 4);
                    j  = (j & 0x0f) + THRESHOLD;
                    for (int k = 0; k <= j; k++)
                    {
                        byte c = tb[(i + k) & (N - 1)];
                        if (op < cap) outBuf[op++] = c;
                        tb[r++] = c; r &= (N - 1);
                    }
                }
            }
        }
    }

    //========================================================================
    // UI
    //========================================================================
    class MainForm : Form
    {
        PreArchive _archive;
        string     _currentFolder = "";   // '\' path, "" == root

        TreeView   _tree;
        ListView   _list;
        ToolStrip  _toolbar;
        StatusStrip _status;
        ToolStripStatusLabel _statusLabel;
        ImageList  _icons;

        public MainForm(string openPath)
        {
            Text = "PRE Explorer";
            Width = 980; Height = 640;
            StartPosition = FormStartPosition.CenterScreen;
            AllowDrop = true;
            DragEnter += OnDragEnter;
            DragDrop  += OnDragDrop;

            _icons = new ImageList();
            _icons.ColorDepth = ColorDepth.Depth32Bit;
            _icons.Images.Add("folder", MakeIcon(Color.FromArgb(230, 190, 90)));
            _icons.Images.Add("file",   MakeIcon(Color.FromArgb(170, 200, 230)));
            _icons.Images.Add("up",     MakeIcon(Color.FromArgb(180, 180, 180)));

            BuildToolbar();

            SplitContainer split = new SplitContainer();
            split.Dock = DockStyle.Fill;
            split.SplitterDistance = 280;

            _tree = new TreeView();
            _tree.Dock = DockStyle.Fill;
            _tree.HideSelection = false;
            _tree.ImageList = _icons;
            _tree.AfterSelect += OnTreeSelect;
            split.Panel1.Controls.Add(_tree);

            _list = new ListView();
            _list.Dock = DockStyle.Fill;
            _list.View = View.Details;
            _list.FullRowSelect = true;
            _list.MultiSelect = true;
            _list.SmallImageList = _icons;
            _list.Columns.Add("Name", 320);
            _list.Columns.Add("Size", 90, HorizontalAlignment.Right);
            _list.Columns.Add("Packed", 90, HorizontalAlignment.Right);
            _list.Columns.Add("Ratio", 70, HorizontalAlignment.Right);
            _list.Columns.Add("Type", 80);
            _list.DoubleClick += OnListDoubleClick;
            BuildListContextMenu();
            split.Panel2.Controls.Add(_list);

            Controls.Add(split);

            _status = new StatusStrip();
            _statusLabel = new ToolStripStatusLabel("Open a .pre or .prx file...");
            _status.Items.Add(_statusLabel);
            Controls.Add(_status);

            // ordering so Fill docks below the toolbar and above the status bar
            _toolbar.SendToBack();
            split.BringToFront();

            if (!string.IsNullOrEmpty(openPath) && File.Exists(openPath))
                OpenArchive(openPath);
        }

        static Bitmap MakeIcon(Color c)
        {
            Bitmap bmp = new Bitmap(16, 16);
            using (Graphics g = Graphics.FromImage(bmp))
            {
                g.Clear(Color.Transparent);
                using (SolidBrush b = new SolidBrush(c))
                    g.FillRectangle(b, 2, 3, 12, 10);
                g.DrawRectangle(Pens.Gray, 2, 3, 12, 10);
            }
            return bmp;
        }

        void BuildToolbar()
        {
            _toolbar = new ToolStrip();
            _toolbar.Dock = DockStyle.Top;
            _toolbar.GripStyle = ToolStripGripStyle.Hidden;

            ToolStripButton open = new ToolStripButton("Open...");
            open.Click += delegate { DoOpen(); };
            ToolStripButton up = new ToolStripButton("Up");
            up.Click += delegate { GoUp(); };
            ToolStripButton exAll = new ToolStripButton("Extract All...");
            exAll.Click += delegate { ExtractAll(); };
            ToolStripButton exSel = new ToolStripButton("Extract Selected...");
            exSel.Click += delegate { ExtractSelected(); };

            _toolbar.Items.Add(open);
            _toolbar.Items.Add(new ToolStripSeparator());
            _toolbar.Items.Add(up);
            _toolbar.Items.Add(new ToolStripSeparator());
            _toolbar.Items.Add(exAll);
            _toolbar.Items.Add(exSel);
            Controls.Add(_toolbar);
        }

        void BuildListContextMenu()
        {
            ContextMenuStrip menu = new ContextMenuStrip();
            ToolStripMenuItem open = new ToolStripMenuItem("Open");
            open.Click += delegate { OpenSelectedFile(); };
            ToolStripMenuItem ex = new ToolStripMenuItem("Extract...");
            ex.Click += delegate { ExtractSelected(); };
            menu.Items.Add(open);
            menu.Items.Add(ex);
            _list.ContextMenuStrip = menu;
        }

        //--------------------------------------------------------------------
        // Opening
        //--------------------------------------------------------------------
        void DoOpen()
        {
            OpenFileDialog dlg = new OpenFileDialog();
            dlg.Filter = "PRE archives (*.pre;*.prx)|*.pre;*.prx|All files (*.*)|*.*";
            if (dlg.ShowDialog(this) == DialogResult.OK)
                OpenArchive(dlg.FileName);
        }

        void OpenArchive(string path)
        {
            try
            {
                PreArchive a = new PreArchive();
                a.Load(path);
                _archive = a;
                Text = "PRE Explorer - " + Path.GetFileName(path);
                BuildTree();
                _currentFolder = "";
                SelectTreeFolder("");
            }
            catch (Exception ex)
            {
                MessageBox.Show(this, ex.Message, "Cannot open",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        //--------------------------------------------------------------------
        // Tree / list population
        //--------------------------------------------------------------------
        Dictionary<string, TreeNode> _folderNodes;

        void BuildTree()
        {
            _tree.BeginUpdate();
            _tree.Nodes.Clear();
            _folderNodes = new Dictionary<string, TreeNode>();

            TreeNode root = new TreeNode(Path.GetFileName(_archive.Path));
            root.Tag = ""; root.ImageKey = "folder"; root.SelectedImageKey = "folder";
            _tree.Nodes.Add(root);
            _folderNodes[""] = root;

            foreach (PreFileEntry e in _archive.Entries)
            {
                string[] parts = e.Name.Split('\\');
                string accum = "";
                TreeNode parent = root;
                for (int i = 0; i < parts.Length - 1; i++)  // folders only
                {
                    accum = (accum.Length == 0) ? parts[i] : accum + "\\" + parts[i];
                    TreeNode node;
                    if (!_folderNodes.TryGetValue(accum, out node))
                    {
                        node = new TreeNode(parts[i]);
                        node.Tag = accum; node.ImageKey = "folder"; node.SelectedImageKey = "folder";
                        parent.Nodes.Add(node);
                        _folderNodes[accum] = node;
                    }
                    parent = node;
                }
            }
            root.Expand();
            _tree.EndUpdate();
        }

        void SelectTreeFolder(string folder)
        {
            TreeNode node;
            if (_folderNodes != null && _folderNodes.TryGetValue(folder, out node))
                _tree.SelectedNode = node;   // triggers OnTreeSelect -> PopulateList
            else
                PopulateList(folder);
        }

        void OnTreeSelect(object sender, TreeViewEventArgs e)
        {
            _currentFolder = (string)e.Node.Tag;
            PopulateList(_currentFolder);
        }

        void PopulateList(string folder)
        {
            if (_archive == null) return;
            _currentFolder = folder;
            _list.BeginUpdate();
            _list.Items.Clear();

            string prefix = folder.Length == 0 ? "" : folder + "\\";

            // immediate subfolders
            SortedDictionary<string, bool> subfolders = new SortedDictionary<string, bool>(StringComparer.OrdinalIgnoreCase);
            List<PreFileEntry> files = new List<PreFileEntry>();
            foreach (PreFileEntry e in _archive.Entries)
            {
                if (!e.Name.StartsWith(prefix, StringComparison.OrdinalIgnoreCase)) continue;
                string rest = e.Name.Substring(prefix.Length);
                int slash = rest.IndexOf('\\');
                if (slash >= 0)
                    subfolders[rest.Substring(0, slash)] = true;
                else
                    files.Add(e);
            }

            foreach (string sub in subfolders.Keys)
            {
                ListViewItem it = new ListViewItem(sub);
                it.ImageKey = "folder";
                it.SubItems.Add(""); it.SubItems.Add(""); it.SubItems.Add("");
                it.SubItems.Add("Folder");
                it.Tag = (prefix + sub);   // string Tag => folder
                _list.Items.Add(it);
            }
            files.Sort(delegate (PreFileEntry a, PreFileEntry b)
            { return string.Compare(a.Name, b.Name, StringComparison.OrdinalIgnoreCase); });
            long total = 0;
            foreach (PreFileEntry e in files)
            {
                string leaf = e.Name;
                int s = leaf.LastIndexOf('\\'); if (s >= 0) leaf = leaf.Substring(s + 1);
                ListViewItem it = new ListViewItem(leaf);
                it.ImageKey = "file";
                it.SubItems.Add(e.DataSize.ToString("N0"));
                it.SubItems.Add(e.Packed ? e.CompressedSize.ToString("N0") : "");
                it.SubItems.Add(e.Packed ? ((double)e.CompressedSize / Math.Max(1, e.DataSize)).ToString("0.00") : "");
                string ext = Path.GetExtension(leaf); if (ext.StartsWith(".")) ext = ext.Substring(1);
                it.SubItems.Add(ext.ToUpperInvariant());
                it.Tag = e;                // PreFileEntry Tag => file
                _list.Items.Add(it);
                total += e.DataSize;
            }
            _list.EndUpdate();

            _statusLabel.Text = string.Format("{0} folder(s), {1} file(s), {2:N0} bytes  |  {3}",
                subfolders.Count, files.Count, total,
                folder.Length == 0 ? "(root)" : folder);
        }

        //--------------------------------------------------------------------
        // Navigation / open
        //--------------------------------------------------------------------
        void GoUp()
        {
            if (_currentFolder.Length == 0) return;
            int s = _currentFolder.LastIndexOf('\\');
            SelectTreeFolder(s >= 0 ? _currentFolder.Substring(0, s) : "");
        }

        void OnListDoubleClick(object sender, EventArgs e)
        {
            if (_list.SelectedItems.Count == 0) return;
            object tag = _list.SelectedItems[0].Tag;
            if (tag is string)
                SelectTreeFolder((string)tag);          // folder -> navigate
            else
                OpenSelectedFile();                       // file -> open
        }

        void OpenSelectedFile()
        {
            if (_list.SelectedItems.Count == 0) return;
            PreFileEntry e = _list.SelectedItems[0].Tag as PreFileEntry;
            if (e == null) return;
            try
            {
                string leaf = e.Name; int s = leaf.LastIndexOf('\\');
                if (s >= 0) leaf = leaf.Substring(s + 1);
                string tmp = Path.Combine(Path.GetTempPath(), "PreExplorer");
                Directory.CreateDirectory(tmp);
                string outPath = Path.Combine(tmp, leaf);
                File.WriteAllBytes(outPath, _archive.Extract(e));
                System.Diagnostics.Process.Start(outPath);
            }
            catch (Exception ex)
            {
                MessageBox.Show(this, ex.Message, "Open failed",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        //--------------------------------------------------------------------
        // Extraction
        //--------------------------------------------------------------------
        string PickFolder(string title)
        {
            FolderBrowserDialog dlg = new FolderBrowserDialog();
            dlg.Description = title;
            if (_archive != null)
                dlg.SelectedPath = Path.GetDirectoryName(_archive.Path);
            return dlg.ShowDialog(this) == DialogResult.OK ? dlg.SelectedPath : null;
        }

        void ExtractAll()
        {
            if (_archive == null) return;
            string dest = PickFolder("Extract all files to:");
            if (dest == null) return;
            ExtractEntries(_archive.Entries, dest);
        }

        void ExtractSelected()
        {
            if (_archive == null || _list.SelectedItems.Count == 0) return;
            List<PreFileEntry> set = new List<PreFileEntry>();
            foreach (ListViewItem it in _list.SelectedItems)
            {
                PreFileEntry fe = it.Tag as PreFileEntry;
                if (fe != null) { set.Add(fe); continue; }
                string folder = (string)it.Tag;            // a folder: include its subtree
                string fp = folder + "\\";
                foreach (PreFileEntry e in _archive.Entries)
                    if (e.Name.StartsWith(fp, StringComparison.OrdinalIgnoreCase))
                        set.Add(e);
            }
            if (set.Count == 0) return;
            string dest = PickFolder("Extract selected to:");
            if (dest == null) return;
            ExtractEntries(set, dest);
        }

        void ExtractEntries(List<PreFileEntry> entries, string dest)
        {
            int ok = 0, fail = 0;
            Cursor = Cursors.WaitCursor;
            try
            {
                foreach (PreFileEntry e in entries)
                {
                    try
                    {
                        string rel = e.Name.Replace('\\', Path.DirectorySeparatorChar);
                        string outPath = Path.Combine(dest, rel);
                        Directory.CreateDirectory(Path.GetDirectoryName(outPath));
                        File.WriteAllBytes(outPath, _archive.Extract(e));
                        ok++;
                    }
                    catch { fail++; }
                }
            }
            finally { Cursor = Cursors.Default; }

            _statusLabel.Text = string.Format("Extracted {0} file(s){1} to {2}",
                ok, fail > 0 ? (" (" + fail + " failed)") : "", dest);
            if (fail == 0)
                MessageBox.Show(this, string.Format("Extracted {0} file(s) to:\n{1}", ok, dest),
                    "Done", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        //--------------------------------------------------------------------
        // Drag & drop a .pre onto the window
        //--------------------------------------------------------------------
        void OnDragEnter(object sender, DragEventArgs e)
        {
            if (e.Data.GetDataPresent(DataFormats.FileDrop))
                e.Effect = DragDropEffects.Copy;
        }
        void OnDragDrop(object sender, DragEventArgs e)
        {
            string[] files = (string[])e.Data.GetData(DataFormats.FileDrop);
            if (files != null && files.Length > 0)
                OpenArchive(files[0]);
        }

        [STAThread]
        static void Main(string[] args)
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new MainForm(args.Length > 0 ? args[0] : null));
        }
    }
}
