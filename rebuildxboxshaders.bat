@echo off

cd Code\Gfx\XBox\NX

for %%f in (*.psh) do xsasm /h %%f
for %%f in (*.vsh) do xsasm /h %%f