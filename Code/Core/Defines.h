/*****************************************************************************
**																			**
**					   	  Neversoft Entertainment							**
**																		   	**
**				   Copyright (C) 1999 - All Rights Reserved				   	**
**																			**
******************************************************************************
**																			**
**	Project:		Core Library											**
**																			**
**	Module:			Standard Header											**
**																			**
**	File name:		core/defines.h											**
**																			**
**	Created:		05/27/99	-	mjb										**
**																			**
**	All code depends on the definitions in this files						**
**	It should be included in every file										**
**																			**
*****************************************************************************/

#pragma once
#ifndef __CORE_DEFINES_H
#define __CORE_DEFINES_H

/*****************************************************************************
**								   Includes									**
*****************************************************************************/


#ifdef __PLAT_WN32__

// LWSS Add special epic Xbox XDK functions
// found in XBox SDK\Samples\Xbox\Misc\FastCPU
#include "Xbox_SSE.h"
//#include <strstream>
//#include <fstream.h>
#ifdef __USE_OLD_STREAMS__
#include <iostream.h>
#else
#include <iostream>
//using namespace std;
#endif
#include <stdio.h>
#include <string.h>

#pragma warning( disable : 4800 ) 
#pragma warning( disable : 4355 ) // 'this' : used in base member initializer list
#pragma warning( disable : 4291 ) // no matching operator delete found

#define D3D_DEBUG_INFO 1

// lwss: added Dx8
//#include <d3d8.h>
//#include <d3dx8math.h>
// lwss: actually Dx9
#include <d3d9.h>
#include <d3dx9shader.h>
//#include <d3dxmath.h>
#define DIRECTINPUT_VERSION 0x0800
#include <dinput.h>

extern bool g_isWindowInFocus;
extern bool g_windowJustWentOutOfFocus;
extern bool g_windowHasBeenDisplayedEver;
extern bool gbQuit;
extern bool g_hasJustEnteredNetworkGame;

// LWSS: Seems to be used to Navmesh
#define TESTING_GUNSLINGER 1

// MSVC Error-fix
#define stricmp _stricmp

//#define Direct3D_CreateDevice(a,b,c,d,e,f) IDirect3D8_CreateDevice(NxXbox::EngineGlobals.p_d3d, a, b, c, d, e, f)
#define Direct3D_CreateDevice(a,b,c,d,e,f) IDirect3D9_CreateDevice(NxXbox::EngineGlobals.p_d3d, a, b, c, d, e, f)

//#define D3DDevice_CreateVertexShader(a,b,c,d) IDirect3DDevice8_CreateVertexShader(NxXbox::EngineGlobals.p_Device, a,b,c,d)
//#define D3DDevice_SetRenderState(a,b,c) IDirect3DDevice8_SetRenderState(NxXbox::EngineGlobals.p_Device, a, b, c)
//#define D3DDevice_GetTextureStageState(a,b,c) IDirect3DDevice8_GetTextureStageState(NxXbox::EngineGlobals.p_Device, a, b, c)
//#define D3DDevice_SetTextureStageState(a,b,c) IDirect3DDevice8_SetTextureStageState(NxXbox::EngineGlobals.p_Device, a, b, c)
//#define D3DDevice_SetMaterial(a) IDirect3DDevice8_SetMaterial(NxXbox::EngineGlobals.p_Device, a)
//#define D3DDevice_SetVertexShaderConstantFast(a,b,c) IDirect3DDevice8_SetVertexShaderConstantF(NxXbox::EngineGlobals.p_Device, a, b, c) // lwss todo: double check that F is the right prefix here. Dx8 got rid of the generic version.
////#define D3DDevice_CreateRenderTarget(a,b,c,d,e,f) IDirect3DDevice8_SetTextureStageState(NxXbox::EngineGlobals.p_Device, a, b, c, d, e, f)
//#define D3DDevice_SetLight(a,b) IDirect3DDevice8_SetLight(NxXbox::EngineGlobals.p_Device, a, b)
//#define D3DDevice_SetTransform(a,b) IDirect3DDevice8_SetTransform(NxXbox::EngineGlobals.p_Device, a, b)
//#define D3DDevice_SetRenderTarget(a,b) IDirect3DDevice8_SetRenderTarget(NxXbox::EngineGlobals.p_Device, a, b)
//#define D3DDevice_SetStencilSurface(a) IDirect3DDevice8_SetRenderTarget(NxXbox::EngineGlobals.p_Device, a)


//#define IDirect3DDevice8_QueryInterface(p,a,b) (NxXbox::EngineGlobals.p_Device)->QueryInterface(a,b)
//#define IDirect3DDevice8_AddRef(p) (NxXbox::EngineGlobals.p_Device)->AddRef()
//#define IDirect3DDevice8_Release(p) (NxXbox::EngineGlobals.p_Device)->Release()
//#define IDirect3DDevice8_TestCooperativeLevel(p) (NxXbox::EngineGlobals.p_Device)->TestCooperativeLevel()
//#define IDirect3DDevice8_GetAvailableTextureMem(p) (NxXbox::EngineGlobals.p_Device)->GetAvailableTextureMem()
//#define IDirect3DDevice8_ResourceManagerDiscardBytes(p,a) (NxXbox::EngineGlobals.p_Device)->ResourceManagerDiscardBytes(a)
//#define D3DDevice_GetDirect3D(a) (NxXbox::EngineGlobals.p_Device)->GetDirect3D(a)
//#define D3DDevice_GetDeviceCaps(a) (NxXbox::EngineGlobals.p_Device)->GetDeviceCaps(a)
//#define D3DDevice_GetDisplayMode(a) (NxXbox::EngineGlobals.p_Device)->GetDisplayMode(a)
//#define D3DDevice_GetCreationParameters(a) (NxXbox::EngineGlobals.p_Device)->GetCreationParameters(a)
//#define D3DDevice_SetCursorProperties(a,b,c) (NxXbox::EngineGlobals.p_Device)->SetCursorProperties(a,b,c)
//#define D3DDevice_SetCursorPosition(a,b,c) (NxXbox::EngineGlobals.p_Device)->SetCursorPosition(a,b,c)
//#define D3DDevice_ShowCursor(a) (NxXbox::EngineGlobals.p_Device)->ShowCursor(a)
//#define D3DDevice_CreateAdditionalSwapChain(a,b) (NxXbox::EngineGlobals.p_Device)->CreateAdditionalSwapChain(a,b)
//#define D3DDevice_Reset(a) (NxXbox::EngineGlobals.p_Device)->Reset(a)
//#define D3DDevice_Present(a,b,c,d) (NxXbox::EngineGlobals.p_Device)->Present(a,b,c,d)
//#define D3DDevice_GetBackBuffer(a,b,c) (NxXbox::EngineGlobals.p_Device)->GetBackBuffer(a,b,c)
//#define D3DDevice_GetRasterStatus(a) (NxXbox::EngineGlobals.p_Device)->GetRasterStatus(a)
//#define D3DDevice_SetGammaRamp(a,b) (NxXbox::EngineGlobals.p_Device)->SetGammaRamp(a,b)
//#define D3DDevice_GetGammaRamp(a) (NxXbox::EngineGlobals.p_Device)->GetGammaRamp(a)
//#define D3DDevice_CreateTexture(a,b,c,d,e,f,g) (NxXbox::EngineGlobals.p_Device)->CreateTexture(a,b,c,d,e,f,g)
//#define D3DDevice_CreateVolumeTexture(a,b,c,d,e,f,g,h) (NxXbox::EngineGlobals.p_Device)->CreateVolumeTexture(a,b,c,d,e,f,g,h)
//#define D3DDevice_CreateCubeTexture(a,b,c,d,e,f) (NxXbox::EngineGlobals.p_Device)->CreateCubeTexture(a,b,c,d,e,f)
//#define D3DDevice_CreateVertexBuffer(a,b,c,d,e) (NxXbox::EngineGlobals.p_Device)->CreateVertexBuffer(a,b,c,d,e)
//#define D3DDevice_CreateIndexBuffer(a,b,c,d,e) (NxXbox::EngineGlobals.p_Device)->CreateIndexBuffer(a,b,c,d,e)
//#define D3DDevice_CreateRenderTarget(a,b,c,d,e,f) (NxXbox::EngineGlobals.p_Device)->CreateRenderTarget(a,b,c,d,e,f)
//#define D3DDevice_CreateDepthStencilSurface(a,b,c,d,e) (NxXbox::EngineGlobals.p_Device)->CreateDepthStencilSurface(a,b,c,d,e)
//#define D3DDevice_CreateImageSurface(a,b,c,d) (NxXbox::EngineGlobals.p_Device)->CreateImageSurface(a,b,c,d)
//#define D3DDevice_CopyRects(a,b,c,d,e) (NxXbox::EngineGlobals.p_Device)->CopyRects(a,b,c,d,e)
//#define D3DDevice_UpdateTexture(a,b) (NxXbox::EngineGlobals.p_Device)->UpdateTexture(a,b)
//#define D3DDevice_GetFrontBuffer(a) (NxXbox::EngineGlobals.p_Device)->GetFrontBuffer(a)
//#define D3DDevice_SetRenderTarget(a,b) (NxXbox::EngineGlobals.p_Device)->SetRenderTarget(a,b)
//#define D3DDevice_GetRenderTarget(a) (NxXbox::EngineGlobals.p_Device)->GetRenderTarget(a)
//#define D3DDevice_GetDepthStencilSurface(a) (NxXbox::EngineGlobals.p_Device)->GetDepthStencilSurface(a)
//#define D3DDevice_BeginScene() (NxXbox::EngineGlobals.p_Device)->BeginScene()
//#define D3DDevice_EndScene() (NxXbox::EngineGlobals.p_Device)->EndScene()
//#define D3DDevice_Clear(a,b,c,d,e,f) (NxXbox::EngineGlobals.p_Device)->Clear(a,b,c,d,e,f)
//#define D3DDevice_SetTransform(a,b) (NxXbox::EngineGlobals.p_Device)->SetTransform(a,b)
//#define D3DDevice_GetTransform(a,b) (NxXbox::EngineGlobals.p_Device)->GetTransform(a,b)
//#define D3DDevice_MultiplyTransform(a,b) (NxXbox::EngineGlobals.p_Device)->MultiplyTransform(a,b)
//#define D3DDevice_SetViewport(a) (NxXbox::EngineGlobals.p_Device)->SetViewport(a)
//#define D3DDevice_GetViewport(a) (NxXbox::EngineGlobals.p_Device)->GetViewport(a)
//#define D3DDevice_SetMaterial(a) (NxXbox::EngineGlobals.p_Device)->SetMaterial(a)
//#define D3DDevice_GetMaterial(a) (NxXbox::EngineGlobals.p_Device)->GetMaterial(a)
//#define D3DDevice_SetLight(a,b) (NxXbox::EngineGlobals.p_Device)->SetLight(a,b)
//#define D3DDevice_GetLight(a,b) (NxXbox::EngineGlobals.p_Device)->GetLight(a,b)
//#define D3DDevice_LightEnable(a,b) (NxXbox::EngineGlobals.p_Device)->LightEnable(a,b)
//#define D3DDevice_GetLightEnable(a,b) (NxXbox::EngineGlobals.p_Device)->GetLightEnable(a,b)
//#define D3DDevice_SetClipPlane(a,b) (NxXbox::EngineGlobals.p_Device)->SetClipPlane(a,b)
//#define D3DDevice_GetClipPlane(a,b) (NxXbox::EngineGlobals.p_Device)->GetClipPlane(a,b)
//#define D3DDevice_SetRenderState(a,b) (NxXbox::EngineGlobals.p_Device)->SetRenderState(a,b)
//#define D3DDevice_GetRenderState(a,b) (NxXbox::EngineGlobals.p_Device)->GetRenderState(a,b)
//#define D3DDevice_BeginStateBlock() (NxXbox::EngineGlobals.p_Device)->BeginStateBlock()
//#define D3DDevice_EndStateBlock(a) (NxXbox::EngineGlobals.p_Device)->EndStateBlock(a)
//#define D3DDevice_ApplyStateBlock(a) (NxXbox::EngineGlobals.p_Device)->ApplyStateBlock(a)
//#define D3DDevice_CaptureStateBlock(a) (NxXbox::EngineGlobals.p_Device)->CaptureStateBlock(a)
//#define D3DDevice_DeleteStateBlock(a) (NxXbox::EngineGlobals.p_Device)->DeleteStateBlock(a)
//#define D3DDevice_CreateStateBlock(a,b) (NxXbox::EngineGlobals.p_Device)->CreateStateBlock(a,b)
//#define D3DDevice_SetClipStatus(a) (NxXbox::EngineGlobals.p_Device)->SetClipStatus(a)
//#define D3DDevice_GetClipStatus(a) (NxXbox::EngineGlobals.p_Device)->GetClipStatus(a)
//#define D3DDevice_GetTexture(a,b) (NxXbox::EngineGlobals.p_Device)->GetTexture(a,b)
//#define D3DDevice_SetTexture(a,b) (NxXbox::EngineGlobals.p_Device)->SetTexture(a,b)
//#define D3DDevice_GetTextureStageState(a,b,c) (NxXbox::EngineGlobals.p_Device)->GetTextureStageState(a,b,c)
//#define D3DDevice_SetTextureStageState(a,b,c) (NxXbox::EngineGlobals.p_Device)->SetTextureStageState(a,b,c)
//#define D3DDevice_ValidateDevice(a) (NxXbox::EngineGlobals.p_Device)->ValidateDevice(a)
//#define D3DDevice_GetInfo(a,b,c) (NxXbox::EngineGlobals.p_Device)->GetInfo(a,b,c)
//#define D3DDevice_SetPaletteEntries(a,b) (NxXbox::EngineGlobals.p_Device)->SetPaletteEntries(a,b)
//#define D3DDevice_GetPaletteEntries(a,b) (NxXbox::EngineGlobals.p_Device)->GetPaletteEntries(a,b)
//#define D3DDevice_SetCurrentTexturePalette(a) (NxXbox::EngineGlobals.p_Device)->SetCurrentTexturePalette(a)
//#define D3DDevice_GetCurrentTexturePalette(a) (NxXbox::EngineGlobals.p_Device)->GetCurrentTexturePalette(a)
//#define D3DDevice_DrawPrimitive(a,b,c) (NxXbox::EngineGlobals.p_Device)->DrawPrimitive(a,b,c)
//#define D3DDevice_DrawIndexedPrimitive(a,b,c,d,e) (NxXbox::EngineGlobals.p_Device)->DrawIndexedPrimitive(a,b,c,d,e)
//#define D3DDevice_DrawPrimitiveUP(a,b,c,d) (NxXbox::EngineGlobals.p_Device)->DrawPrimitiveUP(a,b,c,d)
//#define D3DDevice_DrawIndexedPrimitiveUP(a,b,c,d,e,f,g,h) (NxXbox::EngineGlobals.p_Device)->DrawIndexedPrimitiveUP(a,b,c,d,e,f,g,h)
//#define D3DDevice_ProcessVertices(a,b,c,d,e) (NxXbox::EngineGlobals.p_Device)->ProcessVertices(a,b,c,d,e)
//#define D3DDevice_CreateVertexShader(a,b,c,d) (NxXbox::EngineGlobals.p_Device)->CreateVertexShader(a,b,c,d)
//#define D3DDevice_SetVertexShader(a) (NxXbox::EngineGlobals.p_Device)->SetVertexShader(a)
//#define D3DDevice_GetVertexShader(a) (NxXbox::EngineGlobals.p_Device)->GetVertexShader(a)
//#define D3DDevice_DeleteVertexShader(a) (NxXbox::EngineGlobals.p_Device)->DeleteVertexShader(a)
//#define D3DDevice_SetVertexShaderConstant(a,b,c) (NxXbox::EngineGlobals.p_Device)->SetVertexShaderConstant(a,b,c)
//#define D3DDevice_GetVertexShaderConstant(a,b,c) (NxXbox::EngineGlobals.p_Device)->GetVertexShaderConstant(a,b,c)
//#define D3DDevice_GetVertexShaderDeclaration(a,b,c) (NxXbox::EngineGlobals.p_Device)->GetVertexShaderDeclaration(a,b,c)
//#define D3DDevice_GetVertexShaderFunction(a,b,c) (NxXbox::EngineGlobals.p_Device)->GetVertexShaderFunction(a,b,c)
//#define D3DDevice_SetStreamSource(a,b,c) (NxXbox::EngineGlobals.p_Device)->SetStreamSource(a,b,c)
//#define D3DDevice_GetStreamSource(a,b,c) (NxXbox::EngineGlobals.p_Device)->GetStreamSource(a,b,c)
//#define D3DDevice_SetIndices(a,b) (NxXbox::EngineGlobals.p_Device)->SetIndices(a,b)
//#define D3DDevice_GetIndices(a,b) (NxXbox::EngineGlobals.p_Device)->GetIndices(a,b)
//#define D3DDevice_CreatePixelShader(a,b) (NxXbox::EngineGlobals.p_Device)->CreatePixelShader(a,b)
//#define D3DDevice_SetPixelShader(a) (NxXbox::EngineGlobals.p_Device)->SetPixelShader(a)
//#define D3DDevice_GetPixelShader(a) (NxXbox::EngineGlobals.p_Device)->GetPixelShader(a)
//#define D3DDevice_DeletePixelShader(a) (NxXbox::EngineGlobals.p_Device)->DeletePixelShader(a)
//#define D3DDevice_SetPixelShaderConstant(a,b,c) (NxXbox::EngineGlobals.p_Device)->SetPixelShaderConstant(a,b,c)
//#define D3DDevice_GetPixelShaderConstant(a,b,c) (NxXbox::EngineGlobals.p_Device)->GetPixelShaderConstant(a,b,c)
//#define D3DDevice_GetPixelShaderFunction(a,b,c) (NxXbox::EngineGlobals.p_Device)->GetPixelShaderFunction(a,b,c)
//#define D3DDevice_DrawRectPatch(a,b,c) (NxXbox::EngineGlobals.p_Device)->DrawRectPatch(a,b,c)
//#define D3DDevice_DrawTriPatch(a,b,c) (NxXbox::EngineGlobals.p_Device)->DrawTriPatch(a,b,c)
//#define D3DDevice_DeletePatch(a) (NxXbox::EngineGlobals.p_Device)->DeletePatch(a)
//DrawIndexedVertices(D3DPRIMITIVETYPE PrimitiveType, UINT VertexCount,CONST WORD* pIndexData);
//DrawIndexedPrimitive)(THIS_ D3DPRIMITIVETYPE, UINT minIndex, UINT NumVertices, UINT startIndex, UINT primCount) PURE;
//#define D3DDevice_DrawIndexedVertices(a,b,c,d,e) (NxXbox::EngineGlobals.p_Device)->DrawIndexedPrimitive(a, b, c, d, e)




// lwss: These are DX9 MACROs, the game uses DX9, but I think I will go back to DX8...
#define D3DDevice_QueryInterface(p,a,b) (NxXbox::EngineGlobals.p_Device)->QueryInterface(a,b) 
#define D3DDevice_AddRef() (NxXbox::EngineGlobals.p_Device)->AddRef() 
#define D3DDevice_Release() (NxXbox::EngineGlobals.p_Device)->Release() 
#define D3DDevice_TestCooperativeLevel() (NxXbox::EngineGlobals.p_Device)->TestCooperativeLevel()
#define D3DDevice_GetAvailableTextureMem() (NxXbox::EngineGlobals.p_Device)->GetAvailableTextureMem()
#define D3DDevice_EvictManagedResources() (NxXbox::EngineGlobals.p_Device)->EvictManagedResources()
#define D3DDevice_GetDirect3D(a) (NxXbox::EngineGlobals.p_Device)->GetDirect3D(a)
#define D3DDevice_GetDeviceCaps(a) (NxXbox::EngineGlobals.p_Device)->GetDeviceCaps(a)
#define D3DDevice_GetDisplayMode(a,b) (NxXbox::EngineGlobals.p_Device)->GetDisplayMode(a,b)
#define D3DDevice_GetCreationParameters(a) (NxXbox::EngineGlobals.p_Device)->GetCreationParameters(a)
#define D3DDevice_SetCursorProperties(a,b,c) (NxXbox::EngineGlobals.p_Device)->SetCursorProperties(a,b,c)
#define D3DDevice_SetCursorPosition(a,b,c) (NxXbox::EngineGlobals.p_Device)->SetCursorPosition(a,b,c)
#define D3DDevice_ShowCursor(a) (NxXbox::EngineGlobals.p_Device)->ShowCursor(a)
#define D3DDevice_CreateAdditionalSwapChain(a,b) (NxXbox::EngineGlobals.p_Device)->CreateAdditionalSwapChain(a,b)
#define D3DDevice_GetSwapChain(a,b) (NxXbox::EngineGlobals.p_Device)->GetSwapChain(a,b)
#define D3DDevice_GetNumberOfSwapChains() (NxXbox::EngineGlobals.p_Device)->GetNumberOfSwapChains()
#define D3DDevice_Reset(a) (NxXbox::EngineGlobals.p_Device)->Reset(a)
#define D3DDevice_Present(a,b,c,d) (NxXbox::EngineGlobals.p_Device)->Present(a,b,c,d)
#define D3DDevice_GetBackBuffer(a,b,c,d) (NxXbox::EngineGlobals.p_Device)->GetBackBuffer(a,b,c,d)
#define D3DDevice_GetRasterStatus(a,b) (NxXbox::EngineGlobals.p_Device)->GetRasterStatus(a,b)
#define D3DDevice_SetDialogBoxMode(a) (NxXbox::EngineGlobals.p_Device)->SetDialogBoxMode(a)
#define D3DDevice_SetGammaRamp(a,b,c) (NxXbox::EngineGlobals.p_Device)->SetGammaRamp(a,b,c)
#define D3DDevice_GetGammaRamp(a,b) (NxXbox::EngineGlobals.p_Device)->GetGammaRamp(a,b)
#define D3DDevice_CreateTexture(a,b,c,d,e,f,g,h) (NxXbox::EngineGlobals.p_Device)->CreateTexture(a,b,c,d,e,f,g,h)
#define D3DDevice_CreateVolumeTexture(a,b,c,d,e,f,g,h,i) (NxXbox::EngineGlobals.p_Device)->CreateVolumeTexture(a,b,c,d,e,f,g,h,i)
#define D3DDevice_CreateCubeTexture(a,b,c,d,e,f,g) (NxXbox::EngineGlobals.p_Device)->CreateCubeTexture(a,b,c,d,e,f,g)
#define D3DDevice_CreateVertexBuffer(a,b,c,d,e,f) (NxXbox::EngineGlobals.p_Device)->CreateVertexBuffer(a,b,c,d,e,f)
#define D3DDevice_CreateIndexBuffer(a,b,c,d,e,f) (NxXbox::EngineGlobals.p_Device)->CreateIndexBuffer(a,b,c,d,e,f)
#define D3DDevice_CreateRenderTarget(a,b,c,d,e,f,g,h) (NxXbox::EngineGlobals.p_Device)->CreateRenderTarget(a,b,c,d,e,f,g,h)
#define D3DDevice_CreateDepthStencilSurface(a,b,c,d,e,f,g,h) (NxXbox::EngineGlobals.p_Device)->CreateDepthStencilSurface(a,b,c,d,e,f,g,h)
#define D3DDevice_UpdateSurface(a,b,c,d) (NxXbox::EngineGlobals.p_Device)->UpdateSurface(a,b,c,d)
#define D3DDevice_UpdateTexture(a,b) (NxXbox::EngineGlobals.p_Device)->UpdateTexture(a,b)
#define D3DDevice_GetRenderTargetData(a,b) (NxXbox::EngineGlobals.p_Device)->GetRenderTargetData(a,b)
#define D3DDevice_GetFrontBufferData(a,b) (NxXbox::EngineGlobals.p_Device)->GetFrontBufferData(a,b)
#define D3DDevice_StretchRect(a,b,c,d,e) (NxXbox::EngineGlobals.p_Device)->StretchRect(a,b,c,d,e)
#define D3DDevice_ColorFill(a,b,c) (NxXbox::EngineGlobals.p_Device)->ColorFill(a,b,c)
#define D3DDevice_CreateOffscreenPlainSurface(a,b,c,d,e,f) (NxXbox::EngineGlobals.p_Device)->CreateOffscreenPlainSurface(a,b,c,d,e,f)
#define D3DDevice_SetRenderTarget(a,b) (NxXbox::EngineGlobals.p_Device)->SetRenderTarget(a,b)
#define D3DDevice_GetRenderTarget(a,b) (NxXbox::EngineGlobals.p_Device)->GetRenderTarget(a,b)
#define D3DDevice_SetDepthStencilSurface(a) (NxXbox::EngineGlobals.p_Device)->SetDepthStencilSurface(a)
#define D3DDevice_GetDepthStencilSurface(a) (NxXbox::EngineGlobals.p_Device)->GetDepthStencilSurface(a)
#define D3DDevice_BeginScene() (NxXbox::EngineGlobals.p_Device)->BeginScene()
#define D3DDevice_EndScene() (NxXbox::EngineGlobals.p_Device)->EndScene()
#define D3DDevice_Clear(a,b,c,d,e,f) (NxXbox::EngineGlobals.p_Device)->Clear(a,b,c,d,e,f)
#define D3DDevice_SetTransform(a,b) (NxXbox::EngineGlobals.p_Device)->SetTransform(a,b)
#define D3DDevice_GetTransform(a,b) (NxXbox::EngineGlobals.p_Device)->GetTransform(a,b)
#define D3DDevice_MultiplyTransform(a,b) (NxXbox::EngineGlobals.p_Device)->MultiplyTransform(a,b)
#define D3DDevice_SetViewport(a) (NxXbox::EngineGlobals.p_Device)->SetViewport(a)
#define D3DDevice_GetViewport(a) (NxXbox::EngineGlobals.p_Device)->GetViewport(a)
#define D3DDevice_SetMaterial(a) (NxXbox::EngineGlobals.p_Device)->SetMaterial(a)
#define D3DDevice_GetMaterial(a) (NxXbox::EngineGlobals.p_Device)->GetMaterial(a)
#define D3DDevice_SetLight(a,b) (NxXbox::EngineGlobals.p_Device)->SetLight(a,b)
#define D3DDevice_GetLight(a,b) (NxXbox::EngineGlobals.p_Device)->GetLight(a,b)
#define D3DDevice_LightEnable(a,b) (NxXbox::EngineGlobals.p_Device)->LightEnable(a,b)
#define D3DDevice_GetLightEnable(a,b) (NxXbox::EngineGlobals.p_Device)->GetLightEnable(a,b)
#define D3DDevice_SetClipPlane(a,b) (NxXbox::EngineGlobals.p_Device)->SetClipPlane(a,b)
#define D3DDevice_GetClipPlane(a,b) (NxXbox::EngineGlobals.p_Device)->GetClipPlane(a,b)
#define D3DDevice_SetRenderState(a,b) (NxXbox::EngineGlobals.p_Device)->SetRenderState(a,b)
#define D3DDevice_GetRenderState(a,b) (NxXbox::EngineGlobals.p_Device)->GetRenderState(a,b)
#define D3DDevice_CreateStateBlock(a,b) (NxXbox::EngineGlobals.p_Device)->CreateStateBlock(a,b)
#define D3DDevice_BeginStateBlock() (NxXbox::EngineGlobals.p_Device)->BeginStateBlock()
#define D3DDevice_EndStateBlock(a) (NxXbox::EngineGlobals.p_Device)->EndStateBlock(a)
#define D3DDevice_SetClipStatus(a) (NxXbox::EngineGlobals.p_Device)->SetClipStatus(a)
#define D3DDevice_GetClipStatus(a) (NxXbox::EngineGlobals.p_Device)->GetClipStatus(a)
#define D3DDevice_GetTexture(a,b) (NxXbox::EngineGlobals.p_Device)->GetTexture(a,b)
#define D3DDevice_SetTexture(a,b) (NxXbox::EngineGlobals.p_Device)->SetTexture(a,b)
#define D3DDevice_GetTextureStageState(a,b,c) (NxXbox::EngineGlobals.p_Device)->GetTextureStageState(a,b,c)
#define D3DDevice_SetTextureStageState(a,b,c) (NxXbox::EngineGlobals.p_Device)->SetTextureStageState(a,b,c)
#define D3DDevice_GetSamplerState(a,b,c) (NxXbox::EngineGlobals.p_Device)->GetSamplerState(a,b,c)
#define D3DDevice_SetSamplerState(a,b,c) (NxXbox::EngineGlobals.p_Device)->SetSamplerState(a,b,c)
#define D3DDevice_ValidateDevice(a) (NxXbox::EngineGlobals.p_Device)->ValidateDevice(a)
#define D3DDevice_SetPaletteEntries(a,b) (NxXbox::EngineGlobals.p_Device)->SetPaletteEntries(a,b)
#define D3DDevice_GetPaletteEntries(a,b) (NxXbox::EngineGlobals.p_Device)->GetPaletteEntries(a,b)
#define D3DDevice_SetCurrentTexturePalette(a) (NxXbox::EngineGlobals.p_Device)->SetCurrentTexturePalette(a)
#define D3DDevice_GetCurrentTexturePalette(a) (NxXbox::EngineGlobals.p_Device)->GetCurrentTexturePalette(a)
#define D3DDevice_SetScissorRect(a) (NxXbox::EngineGlobals.p_Device)->SetScissorRect(a)
#define D3DDevice_GetScissorRect(a) (NxXbox::EngineGlobals.p_Device)->GetScissorRect(a)
#define D3DDevice_SetSoftwareVertexProcessing(a) (NxXbox::EngineGlobals.p_Device)->SetSoftwareVertexProcessing(a)
#define D3DDevice_GetSoftwareVertexProcessing() (NxXbox::EngineGlobals.p_Device)->GetSoftwareVertexProcessing()
#define D3DDevice_SetNPatchMode(a) (NxXbox::EngineGlobals.p_Device)->SetNPatchMode(a)
#define D3DDevice_GetNPatchMode() (NxXbox::EngineGlobals.p_Device)->GetNPatchMode()
#define D3DDevice_DrawPrimitive(a,b,c) (NxXbox::EngineGlobals.p_Device)->DrawPrimitive(a,b,c)
#define D3DDevice_DrawIndexedPrimitive(a,b,c,d,e,f) (NxXbox::EngineGlobals.p_Device)->DrawIndexedPrimitive(a,b,c,d,e,f)
#define D3DDevice_DrawPrimitiveUP(a,b,c,d) (NxXbox::EngineGlobals.p_Device)->DrawPrimitiveUP(a,b,c,d)
#define D3DDevice_DrawIndexedPrimitiveUP(a,b,c,d,e,f,g,h) (NxXbox::EngineGlobals.p_Device)->DrawIndexedPrimitiveUP(a,b,c,d,e,f,g,h)
#define D3DDevice_ProcessVertices(a,b,c,d,e,f) (NxXbox::EngineGlobals.p_Device)->ProcessVertices(a,b,c,d,e,f)
#define D3DDevice_CreateVertexDeclaration(a,b) (NxXbox::EngineGlobals.p_Device)->CreateVertexDeclaration(a,b)
#define D3DDevice_SetVertexDeclaration(a) (NxXbox::EngineGlobals.p_Device)->SetVertexDeclaration(a)
#define D3DDevice_GetVertexDeclaration(a) (NxXbox::EngineGlobals.p_Device)->GetVertexDeclaration(a)
#define D3DDevice_SetFVF(a) (NxXbox::EngineGlobals.p_Device)->SetFVF(a)
#define D3DDevice_GetFVF(a) (NxXbox::EngineGlobals.p_Device)->GetFVF(a)
#define D3DDevice_CreateVertexShader(a,b) (NxXbox::EngineGlobals.p_Device)->CreateVertexShader(a,b)
#define D3DDevice_SetVertexShader(a) (NxXbox::EngineGlobals.p_Device)->SetVertexShader(a)
#define D3DDevice_GetVertexShader(a) (NxXbox::EngineGlobals.p_Device)->GetVertexShader(a)
#define D3DDevice_SetVertexShaderConstantF(a,b,c) (NxXbox::EngineGlobals.p_Device)->SetVertexShaderConstantF(a,b,c)
#define D3DDevice_GetVertexShaderConstantF(a,b,c) (NxXbox::EngineGlobals.p_Device)->GetVertexShaderConstantF(a,b,c)
#define D3DDevice_SetVertexShaderConstantI(a,b,c) (NxXbox::EngineGlobals.p_Device)->SetVertexShaderConstantI(a,b,c)
#define D3DDevice_GetVertexShaderConstantI(a,b,c) (NxXbox::EngineGlobals.p_Device)->GetVertexShaderConstantI(a,b,c)
#define D3DDevice_SetVertexShaderConstantB(a,b,c) (NxXbox::EngineGlobals.p_Device)->SetVertexShaderConstantB(a,b,c)
#define D3DDevice_GetVertexShaderConstantB(a,b,c) (NxXbox::EngineGlobals.p_Device)->GetVertexShaderConstantB(a,b,c)
#define D3DDevice_SetStreamSource(a,b,c,d) (NxXbox::EngineGlobals.p_Device)->SetStreamSource(a,b,c,d)
#define D3DDevice_GetStreamSource(a,b,c,d) (NxXbox::EngineGlobals.p_Device)->GetStreamSource(a,b,c,d)
#define D3DDevice_SetStreamSourceFreq(a,b) (NxXbox::EngineGlobals.p_Device)->SetStreamSourceFreq(a,b)
#define D3DDevice_GetStreamSourceFreq(a,b) (NxXbox::EngineGlobals.p_Device)->GetStreamSourceFreq(a,b)
#define D3DDevice_SetIndices(a) (NxXbox::EngineGlobals.p_Device)->SetIndices(a)
#define D3DDevice_GetIndices(a) (NxXbox::EngineGlobals.p_Device)->GetIndices(a)
#define D3DDevice_CreatePixelShader(a,b) (NxXbox::EngineGlobals.p_Device)->CreatePixelShader(a,b)
#define D3DDevice_SetPixelShader(a) (NxXbox::EngineGlobals.p_Device)->SetPixelShader(a)
#define D3DDevice_GetPixelShader(a) (NxXbox::EngineGlobals.p_Device)->GetPixelShader(a)
#define D3DDevice_SetPixelShaderConstantF(a,b,c) (NxXbox::EngineGlobals.p_Device)->SetPixelShaderConstantF(a,b,c)
#define D3DDevice_GetPixelShaderConstantF(a,b,c) (NxXbox::EngineGlobals.p_Device)->GetPixelShaderConstantF(a,b,c)
#define D3DDevice_SetPixelShaderConstantI(a,b,c) (NxXbox::EngineGlobals.p_Device)->SetPixelShaderConstantI(a,b,c)
#define D3DDevice_GetPixelShaderConstantI(a,b,c) (NxXbox::EngineGlobals.p_Device)->GetPixelShaderConstantI(a,b,c)
#define D3DDevice_SetPixelShaderConstantB(a,b,c) (NxXbox::EngineGlobals.p_Device)->SetPixelShaderConstantB(a,b,c)
#define D3DDevice_GetPixelShaderConstantB(a,b,c) (NxXbox::EngineGlobals.p_Device)->GetPixelShaderConstantB(a,b,c)
#define D3DDevice_DrawRectPatch(a,b,c) (NxXbox::EngineGlobals.p_Device)->DrawRectPatch(a,b,c)
#define D3DDevice_DrawTriPatch(a,b,c) (NxXbox::EngineGlobals.p_Device)->DrawTriPatch(a,b,c)
#define D3DDevice_DeletePatch(a) (NxXbox::EngineGlobals.p_Device)->DeletePatch(a)
#define D3DDevice_CreateQuery(a,b) (NxXbox::EngineGlobals.p_Device)->CreateQuery(a,b)


#define D3DDevice_SetVertexShaderConstantFast D3DDevice_SetVertexShaderConstant

//lwss add: XGMATRIX is xbox-only. However it's basically just a D3DMATRIX with operator overloading
#define XGMATRIX D3DXMATRIX
#define XGVECTOR3 D3DXVECTOR3
#define XGVECTOR4 D3DXVECTOR4

// along with its helper functions
#define	XGMatrixTranspose D3DXMatrixTranspose 
#define	XGMatrixIdentity D3DXMatrixIdentity 
#define	XGMatrixMultiply D3DXMatrixMultiply 
#define	XGVec3TransformNormal D3DXVec3TransformNormal 
#define	XGVec3Transform D3DXVec3Transform 
#define	XGVec3Normalize D3DXVec3Normalize 
#define	XGVec3Scale D3DXVec3Scale
#define XGVec3TransformCoord D3DXVec3TransformCoord
#define XGMatrixLookAtRH D3DXMatrixLookAtRH
#define XGMatrixOrthoRH D3DXMatrixOrthoRH

#else // __PLAT_WN32__
#ifdef __PLAT_NGPS__
#include <stdio.h>
#include <eetypes.h>
//#include <iostream.h>
#include <string.h>
#include <stdlib.h>
#else
#ifdef __PLAT_NGC__
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <typeinfo>  
#else
#ifdef __PLAT_XBOX__
#include <stdio.h>
//#include <iostream.h>
#include <string.h>
#include <stdlib.h>

#pragma warning( disable : 4800 ) 
#pragma warning( disable : 4291 ) // no matching operator delete found
#pragma warning( disable : 4355 ) // 'this' : used in base member initializer list
#pragma warning( disable : 4995 ) // name was marked as #pragma deprecated

#endif
#endif
#endif
#endif

//#ifndef __PLAT_WN32__ // lwss: uncomment
//#ifdef __NOPT_ASSERT__
#ifdef __PLAT_NGC__
#ifdef __NOPT_FINAL__
	#define printf(A...)
#else
	int OurPrintf(const char *fmt, ...);
	#define printf OurPrintf
#endif
#else
	int OurPrintf(const char *fmt, ...);
	#define printf OurPrintf
#endif	

//#else
//	inline void NullPrintf(const char *fmt, ...){}
//	#define printf NullPrintf	
//#endif
//#endif


/*****************************************************************************
**								   Defines									**
*****************************************************************************/

#define vINT8_MAX   		0x7F
#define vINT8_MIN   		0x81
#define vINT16_MAX   		0x7FFF
#define vINT16_MIN   		0x8001
#define vINT32_MAX   		0x7FFFFFFF
#define vINT32_MIN   		0x80000001
#define vINT64_MAX   		0x7FFFFFFFFFFFFFFF
#define vINT64_MIN   		0x8000000000000001

#define vUINT8_MAX   		0xFF
#define vUINT16_MAX   		0xFFFF
#define vUINT32_MAX   		0xFFFFFFFF
#define vUINT64_MAX   		0xFFFFFFFFFFFFFFFF

#ifndef TRUE
#define FALSE				0
#define TRUE				(!FALSE)
#endif

#ifndef NULL
#define NULL				0
#endif

/*****************************************************************************
**							     Type Defines								**
*****************************************************************************/

typedef char				int8;
typedef short				int16;

typedef unsigned int		uint;
typedef unsigned char		uint8;
typedef unsigned short		uint16;

typedef signed int			sint;
typedef signed char			sint8;
typedef signed short		sint16;

#define vINT_MAX			vINT32_MAX
#define vINT_MIN			vINT32_MIN
#define vUINT_MAX			vUINT32_MAX

#ifdef __PLAT_WN32__
typedef long				int32;
typedef unsigned long		uint32;
typedef signed long			sint32;
typedef __int64				int64;
typedef unsigned __int64	uint64;
typedef signed __int64		sint64;

#endif

#ifdef __PLAT_NGPS__
typedef int					int32;
typedef unsigned int		uint32;
typedef signed int			sint32;
typedef long				int64;
typedef unsigned long		uint64;
typedef signed long			sint64;
typedef long128				int128;
typedef u_long128			uint128;
typedef long128				sint128;

#endif

#ifdef __PLAT_XBOX__
typedef long				int32;
typedef unsigned long		uint32;
typedef signed long			sint32;
typedef __int64				int64;
typedef unsigned __int64	uint64;
typedef signed __int64		sint64;

#endif

#ifdef __PLAT_NGC__
typedef int					int32;
typedef unsigned int		uint32;
typedef signed int			sint32;
typedef long long			int64;
typedef unsigned long long	uint64;
typedef signed long long	sint64;
// Paul: No GameCube 128-bit types.
//typedef long128				int128;
//typedef u_long128			uint128;
//typedef long128				sint128;
typedef long long			int128;
typedef unsigned long long	uint128;
typedef signed long long	sint128;

#endif

#if defined(__PLAT_NGPS__) || defined(__PLAT_XBOX__) || defined(__PLAT_NGC__)

class ostream
{
public:
	ostream& operator<< ( char* str ) 		{ printf ( str ); return *this; }
	ostream& operator<< ( const char* str ) { printf ( str ); return *this; }
	ostream& operator<< ( sint i ) 			{ printf ( "%d", i ); return *this; }
	ostream& operator<< ( uint i ) 			{ printf ( "%u", i ); return *this; }
	ostream& operator<< ( float f ) 		{ printf ( "%f", f ); return *this; }
	ostream& operator<< ( void* p ) 		{ printf ( "%p", p ); return *this; }
	ostream& operator<< ( const void* p )	{ printf ( "%p", p ); return *this; }
};

#endif 

#define	vINT_BITS			32
#define	vPTR_BITS			32

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

// Alignment macros


#ifdef __PLAT_NGPS__
#define nAlign(bits)	__attribute__((aligned((bits>>3))))
#else
#define nAlign(bits)
#endif

#define	nPad64(X)	uint64		_pad##X;
#define	nPad32(X)	uint32		_pad##X;
#define	nPad16(X)	uint16		_pad##X;
#define	nPad8(X)	uint8		_pad##X;

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

// version stamping

#define __nTIME__		__TIME__
#define __nDATE__		__DATE__

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

#define nBit(b)				( 1 << (b) )

typedef	sint				nID;
typedef	sint8				nID8;
typedef	sint16				nID16;
typedef	sint32				nID32;
typedef	sint64				nID64;

#define	nMakeID(a,b,c,d)		( (nID) ( ( (nID) (a) ) << 24 | ( (nID) (b) ) << 16 |	\
								( (nID) (c) ) << 8 | ( (nID) (d) ) ) )


//	nMakeStructID() differs from nMakeID in that struct IDs are always
//	readable from a memory dump, where as IDs would be reversed on little
//	endian machines

#if		__CPU_BIG_ENDIAN__
#define	nMakeStructID(a,b,c,d) ( (nID) ( ((nID)(a))<<24 | ((nID)(b))<<16 | \
										  ((nID)(c))<<8  | ((nID)(d)) ))
#else
#define	nMakeStructID(a,b,c,d) ( (ID) ( ((nID)(d))<<24 | ((nID)(c))<<16 | \
										  ((nID)(b))<<8  | ((nID)(a)) ))
#endif

/*****************************************************************************
**									Macros									**
*****************************************************************************/

#define	nReverse32(L)	( (( (L)>>24 ) & 0xff) | (((L)>>8) &0xff00) | (((L)<<8)&0xff0000) | (((L)<<24)&0xff000000))
#define	nReverse16(L)	( (( (L)>>8 ) & 0xff) | (((L)<<8)&0xff00) )

#if	__CPU_BIG_ENDIAN__

#define	nBgEn32(L) 	(L)
#define	nBgEn16(L) 	(L)

#define	nLtEn32(L)	nReverse32(L)
#define	nLtEn16(L)	nReverse16(L)

#else

#define	nBgEn32(L) 	nReverse32(L)
#define	nBgEn16(L) 	nReverse16(L)

#define	nLtEn32(L)	(L)
#define	nLtEn16(L)	(L)

#endif

#if defined(__PLAT_XBOX__) || defined(__PLAT_WN32__) // lwss add win32
#define __PRETTY_FUNCTION__ "?"

#define isnanf	_isnan
#define isinff	_isnan

#endif

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

#define __CPU_WORD_BALIGN__    4		// Memory word byte alignment

#define PTR_ALIGNMASK	 ( vUINT_MAX << __CPU_WORD_BALIGN__)

// The alignment macros align elements for fastest access

#define nAligned(p) 		( !( (uint) (p) & (~PTR_ALIGNMASK) ) )
#define nAlignDown(p) 		(void*)( (uint) (p) & PTR_ALIGNMASK )
#define nAlignUp(p)			(void*)( ( (uint) (p) + ( 1 << __CPU_WORD_BALIGN__ ) - 1 ) & PTR_ALIGNMASK )
#define nAlignedBy(P,A) 	( !( (uint) (P) & ( ~(vUINT_MAX << (A) ) ) ) )
#define nAlignDownBy(P,A) 	(void*)( (uint) (P) & (vUINT_MAX << (A) ) )
#define nAlignUpBy(P,A)		(void*)( ( (uint) (P) + ( 1 << (A) ) - 1 ) & ( vUINT_MAX <<( A ) ) )
#define nStorage(X)			nAlignUp ( (X) + 1 )

/****************************************************************************/

#define	nAddPointer(P,X)		(void*) ( (uint) (p) + (uint) (X) )
#define	nSubPointer(P,X)		(void*) ( (uint) (p) - (uint) (X) )

/****************************************************************************/

// Converts a string into a checksum. This macro can be used for readability.
// Later, for speed, some application can scan all .cpp and .h files, and
// replace all instances of CRCX(...) with corresponding CRCD(...) instances
//
// Example: CRCX("object_id")
#define CRCX(_s)			Script::GenerateCRC(_s)
// This macro exists simply for readability. Whenever you see a CRCD(...) instance,
// you will know what string the checksum maps to. CRCD(...) instances in the code
// can be generated from CRCX(...), and can be reverse mapped if desired.
//
// Example: CRCD(0xdcd2a9d4, "object_id")

#include <core/debug.h>




/*****************************************************************************
**								   Includes									**
*****************************************************************************/




#include <core/support.h>
#include <sys/mem/memman.h>

#include <core/crc.h>

#ifdef	__PLAT_NGPS__
#include <gfx/ngps/p_memview.h>
#include "libsn.h"
#elif defined( __PLAT_NGC__ )
#include <gfx/ngc/p_memview.h>
//#include "libsn.h"
#elif defined( __PLAT_XBOX__ )
#include <gfx/DX8/p_memview.h>
#endif

// lwss: this custom allocator is annoying.
//#define KISAK_ORIGINAL_ALLOCATOR 1

// Lwss: Used to unfk the cursor in early init code debugging.
//#define KISAK_EARLY_CURSOR_FIX 1

// Mick:  This check slows the game down quite a bit
#if  1 && 	defined( __NOPT_ASSERT__ )

extern  uint32	check_checksum(uint32 _i, const char *_s, const char *f, int line);

#define CRCD(_i, _s)		check_checksum(_i, _s, __FILE__, __LINE__)
#else
#define CRCD(_i, _s)		_i
#endif

// CRC-C, for use only in switch statements, where you want to use the same syntax as CRCD
#define CRCC(_i, _s)		_i



//#ifdef __PLAT_NGC__
//class TCPPInit
//{
//public:
//  static bool IsHeapInitialized ;
//} ;
//
//// these definitions override the new and delete operators.
//
#ifdef __PLAT_NGC__
static inline void* operator new       ( size_t blocksize ) ;

static inline void* operator new[]     ( size_t blocksize ) ;

static inline void operator delete     ( void* block ) ;

static inline void operator delete[]   ( void* block ) ;
#endif		// __PLAT_NGC__
//
//#else

//#ifdef __PLAT_WN32__
//inline void* 	operator new( size_t size, bool assert_on_fail )
//{
//	return new char[size];
//}
//
//
//#else
#ifndef __PLAT_NGC__
/******************************************************************/
/* Global new/delete operators                                    */
/*                                                                */
/******************************************************************/
inline void* 	operator new( size_t size )
{
#ifdef KISAK_THUG_ALLOC
	return Mem::Manager::sHandle().New(size, true);
#else
	void* mem = malloc(size);
	memset(mem, 0x00, size);
	return mem;
#endif
}
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline void* 	operator new[] ( size_t size )
{
#ifdef KISAK_ORIGINAL_ALLOCATOR
	return Mem::Manager::sHandle().New(size, true);
#else
	void* mem = malloc(size);
	memset(mem, 0x00, size);
	return mem;
#endif
}
#endif		// __PLAT_NGC__

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline void* 	operator new( size_t size, bool assert_on_fail )
{
#ifdef KISAK_ORIGINAL_ALLOCATOR
	return Mem::Manager::sHandle().New(size, assert_on_fail);
#else
	void* mem = malloc(size);
	memset(mem, 0x00, size);
	return mem;
#endif
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline void* 	operator new[] ( size_t size, bool assert_on_fail )
{
#ifdef KISAK_ORIGINAL_ALLOCATOR
	return Mem::Manager::sHandle().New(size, assert_on_fail);
#else
	void* mem = malloc(size);
	memset(mem, 0x00, size);
	return mem;
#endif
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline void*	operator new( size_t size, Mem::Allocator* pAlloc, bool assert_on_fail = true )
{
#ifdef KISAK_ORIGINAL_ALLOCATOR
	return Mem::Manager::sHandle().New(size, assert_on_fail, pAlloc);
#else
	void* mem = malloc(size);
	memset(mem, 0x00, size);
	return mem;
#endif
}
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline void*	operator new[]( size_t size, Mem::Allocator* pAlloc, bool assert_on_fail = true )
{
#ifdef KISAK_ORIGINAL_ALLOCATOR
	return Mem::Manager::sHandle().New(size, assert_on_fail, pAlloc);
#else
	void* mem = malloc(size);
	memset(mem, 0x00, size);
	return mem;
#endif
}

#ifndef __PLAT_WN32__
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline void* 	operator new( size_t size, void* pLocation )
{
	return pLocation;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline void* 	operator new[]( size_t size, void* pLocation )
{
	return pLocation;
}
#endif

#ifndef __PLAT_NGC__
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline void 	operator delete( void* pAddr )
{
#ifdef KISAK_ORIGINAL_ALLOCATOR
	Mem::Manager::sHandle().Delete(pAddr);
#else
	free(pAddr);
#endif
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline void 	operator delete[]( void* pAddr )
{
#ifdef KISAK_ORIGINAL_ALLOCATOR
	Mem::Manager::sHandle().Delete(pAddr);
#else
	free(pAddr);
#endif
}
#endif		// __PLAT_NGC__

// LWSS: AFX garbage MSVC shit allocators
inline void* __cdecl operator new(size_t nSize, LPCSTR lpszFileName, int nLine)
{
#ifdef KISAK_ORIGINAL_ALLOCATOR
	return Mem::Manager::sHandle().New(nSize, true);
#else
	void* mem = malloc(nSize);
	memset(mem, 0x00, nSize);
	return mem;
#endif
}
inline void __cdecl operator delete(void* p, LPCSTR lpszFileName, int nLine)
{
#ifdef KISAK_ORIGINAL_ALLOCATOR
	Mem::Manager::sHandle().Delete(p);
#else
	free(p);
#endif
}

inline void* __cdecl operator new[](size_t nSize, LPCSTR lpszFileName, int nLine)
{
#ifdef KISAK_ORIGINAL_ALLOCATOR
	return Mem::Manager::sHandle().New(nSize, true);
#else
	void* mem = malloc(nSize);
	memset(mem, 0x00, nSize);
	return mem;
#endif
}
inline void __cdecl operator delete[](void* p, LPCSTR lpszFileName, int nLine)
{
#ifdef KISAK_ORIGINAL_ALLOCATOR
	Mem::Manager::sHandle().Delete(p);
#else
	free(p);
#endif
}
// LWSS end

//#ifdef __PLAT_NGC__
/******************************************************************/
/* only used when exception is thrown in constructor              */
/*                                                                */
/******************************************************************

inline void	operator delete( void* pAddr, Mem::Allocator* pAlloc )
{
	Mem::Manager * mem_man = Mem::Manager::Instance();
	Mem::Manager::sHandle().Delete( pAddr );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************

inline void	operator delete[]( void* pAddr, Mem::Allocator* pAlloc )
{
	Mem::Manager * mem_man = Mem::Manager::Instance();
	Mem::Manager::sHandle().Delete( pAddr );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************

inline void 	operator delete( void*, void* pLocation )
{
	return;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

//#endif		// __PLAT_NGC__
//#endif	// __PLAT_WN32__
#endif	//	__CORE_DEFINES_H




