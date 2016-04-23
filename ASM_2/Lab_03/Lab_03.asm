	.586
	.model flat, stdcall
	option casemap :none
	
include 	D:\masm32\include\windows.inc
include 	D:\masm32\include\kernel32.inc
include 	D:\masm32\include\user32.inc	
include		D:\masm32\include\shlwapi.inc
include		D:\masm32\include\gdi32.inc

includelib D:\masm32\lib\shlwapi.lib
includelib D:\masm32\lib\kernel32.lib
includelib D:\masm32\lib\user32.lib
includelib D:\masm32\lib\gdi32.lib

return macro arg                  
	mov eax, arg 	
	ret 
endm 
    
let macro x, func: vararg      
	invoke func 
	mov x, eax 
endm  
   
szText macro Name, Text:VARARG     
	jmp @F 
	Name db Text,0 
	@@: 
endm 
	
m2m MACRO x, y
	push y
	pop x
ENDM



WinMain  	PROTO :DWORD,:DWORD,:DWORD,:DWORD    
DlgProc   	PROTO :DWORD,:DWORD,:DWORD,:DWORD 
PaintProc 	PROTO :DWORD, :DWORD 
 
.data 
rect RECT <>
hInstance  		dd 0 
CommandLine  	dd 0 
hIcon			dd 0
hLabel			dd 0
hBmp1			dd 0
hBmp2			dd 0
hBmp3			dd 0
hStatic			dd 0
figure  			dd 0 
borderColor	dd 000000FFh
fillColor	dd 0000FF00h
szBuffer db 256 dup (0)
 
.code                                       
start: 

let hInstance, GetModuleHandle, NULL 
let CommandLine, GetCommandLine 
invoke WinMain, hInstance, NULL, CommandLine, SW_SHOWDEFAULT 
invoke ExitProcess, eax 
 
WinMain proc hInst:DWORD, hPrevInst:DWORD, CmdLine:DWORD, CmdShow:DWORD
		invoke DialogBoxParam,  hInst, 700, 0, addr DlgProc, 0 
		return 0
WinMain endp

DlgProc proc  hWnd:DWORD, uMsg:DWORD, wParam:DWORD, lParam :DWORD
	local hDC	: DWORD
	local ps	: PAINTSTRUCT
		.if uMsg == WM_CLOSE
      			invoke EndDialog, hWnd, 0
		.elseif uMsg == WM_INITDIALOG
			mov rect.left, 200
			mov rect.top, 100
			mov rect.right, 500
			mov rect.bottom, 600
		.elseif uMsg == WM_COMMAND
			.if wParam == 301
				mov figure, 1
				invoke InvalidateRect, hWnd, addr rect, TRUE
			.elseif wParam == 302
				mov figure, 2
				invoke InvalidateRect, hWnd, addr rect, TRUE
			.elseif wParam == 300
				invoke EndDialog, hWnd,0
			.endif
			
			.if     wParam == 401
				mov borderColor, 00000000h		; чорний
				invoke InvalidateRect, hWnd, addr rect, TRUE
			.elseif wParam == 402
				mov borderColor, 000000FFh		;червоний
				invoke InvalidateRect, hWnd, addr rect, TRUE
			.elseif wParam == 403
				mov borderColor, 0000FF00h		;зелений
				invoke InvalidateRect, hWnd, addr rect, TRUE
			.elseif wParam == 404
				mov borderColor, 00FF0000h		;синій
				invoke InvalidateRect, hWnd, addr rect, TRUE
			.endif
			
			.if     wParam == 406
				mov fillColor, 00FFFFFFh		
				invoke InvalidateRect, hWnd, addr rect, TRUE
			.elseif wParam == 407
				mov fillColor, 000000FFh		;червоний
				invoke InvalidateRect, hWnd, addr rect, TRUE
			.elseif wParam == 408
				mov fillColor, 0000FFFFh
				invoke InvalidateRect, hWnd, addr rect, TRUE
			.elseif wParam == 409
				mov fillColor, 00FF0000h		;синій
				invoke InvalidateRect, hWnd, addr rect, TRUE
			.endif

			;invoke InvalidateRect, hWnd, addr rect, TRUE
		.elseif uMsg == WM_PAINT
			let hDC, BeginPaint, hWnd, addr ps
			invoke PaintProc, hWnd, hDC
			invoke EndPaint, hWnd, addr ps
   		.endif
		return 0
DlgProc endp

PaintProc proc hWnd:DWORD, hDC:DWORD
	local pen:LOGPEN
	local brush:LOGBRUSH
	local hPen, hPenOld	
	local hBrush, hBrushOld
	local hFont, hFontOld
	
	mov pen.lopnStyle, PS_SOLID	 		
	mov pen.lopnWidth.x, 2
	m2m pen.lopnColor, borderColor
	
	let hPen, CreatePenIndirect, addr pen		
	let hPenOld, SelectObject, hDC, hPen
	
	mov brush.lbStyle, BS_SOLID		
	m2m brush.lbColor, fillColor
	let hBrush, CreateBrushIndirect, addr brush	
	let hBrushOld, SelectObject, hDC, hBrush	
	
	szText szFontFace, "Monotype Corsiva"	
   	let hFont, CreateFont,24,18,0,0,600,1,0,0,0,0,0,0,0,addr szFontFace
  	let hFontOld, SelectObject, hDC, hFont
	invoke SetBkMode, hDC, TRANSPARENT		
	invoke SetTextColor, hDC, 00002244h	
	
	.if figure == 1
		invoke Rectangle, 	hDC, 300, 200, 350, 285
		szText szText1, "pryamokytnuk"
		invoke TextOut,	hDC, 215,115, addr szText1, 12
	.elseif figure == 2
		invoke Ellipse, 	hDC, 300, 200, 350, 285
		szText szText2, "elips"
		invoke TextOut,		hDC, 215, 125, addr szText2, 5
	.endif
	
	invoke SelectObject,hDC,hPenOld	
    invoke DeleteObject,hPen
    invoke SelectObject,hDC,hBrushOld
    invoke DeleteObject,hBrush
	
	invoke SelectObject, hDC, hFontOld	
	invoke DeleteObject, hFont

	return 0
PaintProc endp


end start 