	.586
	.model flat, stdcall
	option casemap :none
	
include 		D:\masm32\include\windows.inc
include 		D:\masm32\include\kernel32.inc
include 		D:\masm32\include\user32.inc	
include		D:\masm32\include\shlwapi.inc
include		D:\masm32\include\gdi32.inc
include		D:\masm32\include\comdlg32.inc

includelib 	D:\masm32\lib\shlwapi.lib
includelib 	D:\masm32\lib\kernel32.lib
includelib 	D:\masm32\lib\user32.lib
includelib 	D:\masm32\lib\gdi32.lib
includelib	D:\masm32\lib\comdlg32.lib

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
	
memset macro x, val, times
	mov ecx, times
	mov al, val
	lea edi, x
	rep stosb ; byte ptr [edi]
endm

memset32 macro x, val, times
	mov ecx, times
	mov eax, val
	lea edi, x
	rep stosd ; byte ptr [edi]
endm

m2m macro x, y
	push y
	pop x
endm

WinMain  PROTO :DWORD,:DWORD,:DWORD,:DWORD    
DlgProc  PROTO :DWORD,:DWORD,:DWORD,:DWORD 
PaintProc PROTO :DWORD, :DWORD 
 
.data 
rect RECT <>
hInstance  dd 0 
CommandLine  dd 0 
hIcon	dd 0
hLabel	dd 0
hBmp1	dd 0
hBmp2	dd 0
hBmp3	dd 0
hStatic	dd 0
figure  	dd 0 
borderColor	dd 000000FFh
fillColor			dd 0000FF00h
szBuffer 		db 256 dup (0)
 
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
	local cc	: CHOOSECOLOR
	local clr[16]	: DWORD

		.if uMsg == WM_CLOSE
      		invoke EndDialog, hWnd, 0
		.elseif uMsg == WM_INITDIALOG
			mov rect.left, 100
			mov rect.top, 100
			mov rect.right, 600
			mov rect.bottom, 600
		.elseif uMsg == WM_COMMAND
			.if wParam == 301
				mov figure, 1
				invoke InvalidateRect, hWnd, addr rect, TRUE
			.elseif wParam == 302
				mov figure, 2
				invoke InvalidateRect, hWnd, addr rect, TRUE
			.elseif wParam == 303
				mov figure, 3
				invoke InvalidateRect, hWnd, addr rect, TRUE
			.elseif wParam == 304
				mov figure, 4
				invoke InvalidateRect, hWnd, addr rect, TRUE
			.elseif wParam == 300
				invoke EndDialog, hWnd,0
			.elseif wParam == 305
				mov figure, 5
				mov	ebx, 250
					.while ebx != 300
						mov ecx, 200
						.while ecx != 285				
							mov	esi, 140
							xor	edx, edx
							mov	eax, ecx			;y
							mul	ebx					;x * y
							div	esi					;x * y / 140
							invoke SetPixel, hDC, ebx, ecx, eax
							inc	ebx
						.endw
						inc	ecx
					.endw
				invoke InvalidateRect, hWnd, addr rect, TRUE
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
				memset32 clr, 0FFFFFFh, 16
				memset cc,0,sizeof CHOOSECOLOR
				mov cc.lStructSize, sizeof CHOOSECOLOR
				m2m cc.hwndOwner, hWnd
				m2m cc.hInstance, hInstance
				mov cc.rgbResult, 33CC66h
				lea eax, clr
				mov cc.lpCustColors, eax
				mov cc.Flags, CC_FULLOPEN + CC_RGBINIT
				invoke ChooseColor, addr cc
				mov eax, cc.rgbResult   
				mov borderColor, eax 
				invoke InvalidateRect, hWnd, addr rect, TRUE
			.endif
			
			.if wParam == 406
				mov fillColor, 00FFFFFFh		
				invoke InvalidateRect, hWnd, addr rect, TRUE
			.elseif wParam == 407
				mov fillColor, 000000FFh		;червоний
				invoke InvalidateRect, hWnd, addr rect, TRUE
			.elseif wParam == 408
				mov fillColor, 0000FFFFh
				invoke InvalidateRect, hWnd, addr rect, TRUE
			.elseif wParam == 409
				memset32 clr, 0FFFFFFh, 16
				memset cc,0,sizeof CHOOSECOLOR
				mov cc.lStructSize, sizeof CHOOSECOLOR
				m2m cc.hwndOwner, hWnd
				m2m cc.hInstance, hInstance
				mov cc.rgbResult, 33CC66h
				lea eax, clr
				mov cc.lpCustColors, eax
				mov cc.Flags, CC_FULLOPEN + CC_RGBINIT
				invoke ChooseColor, addr cc
				mov eax, cc.rgbResult   
				mov fillColor, eax 
				invoke InvalidateRect, hWnd, addr rect, TRUE
			.endif

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
	local p[6]	: POINT
	
	mov pen.lopnStyle, PS_SOLID	 		
	mov pen.lopnWidth.x, 2
	m2m pen.lopnColor, borderColor
	
	let hPen, CreatePenIndirect, addr pen		
	let hPenOld, SelectObject, hDC, hPen
	
	mov brush.lbStyle, BS_SOLID		
	m2m brush.lbColor, fillColor
	let hBrush, CreateBrushIndirect, addr brush	
	let hBrushOld, SelectObject, hDC, hBrush	
	
	szText szFontFace, "Arial"	
   	let hFont, CreateFont,20,14,0,0,600,1,0,0,0,0,0,0,0,addr szFontFace
  	let hFontOld, SelectObject, hDC, hFont
	invoke SetBkMode, hDC, TRANSPARENT		
	invoke SetTextColor, hDC, 00446575h	
	
	.if figure == 1
		invoke Rectangle, 	hDC, 300, 200, 350, 285
		szText szText1, "rectangle"
		invoke TextOut,	hDC, 215,115, addr szText1, 9
	.elseif figure == 2
		invoke Ellipse, 	hDC, 300, 200, 350, 285
		szText szText2, "elipse"
		invoke TextOut,		hDC, 215, 115, addr szText2, 6
	.elseif figure == 3
		;mov p[0].x, 250
		;mov p[0].x, 250
		;mov p[0].y, 200
		;mov p[1].x, 350
		;mov p[1].y, 200
		;mov p[2].x, 400
		;mov p[2].y, 250
		;mov p[3].x, 350
		;mov p[3].y, 300
		;mov p[4].x, 250
		;mov p[4].y, 300
		;mov p[5].x, 300
		;mov p[5].y, 250
		;mov p[6].x, 250
		;mov p[6].y, 200
		;invoke MoveToEx, hDC, 250, 250, NULL
		;invoke Polygon, hDC, addr p, 6
		
		invoke MoveToEx, hDC, 250, 200, NULL
		invoke LineTo, hDC, 350, 200
		invoke MoveToEx, hDC, 350, 200, NULL
		invoke LineTo, hDC, 400, 250
		invoke MoveToEx, hDC, 400, 250, NULL
		invoke LineTo, hDC, 350, 300
		invoke MoveToEx, hDC, 350, 300, NULL
		invoke LineTo, hDC, 250, 300
		invoke MoveToEx, hDC, 250, 300, NULL
		invoke LineTo, hDC, 300, 250
		invoke MoveToEx, hDC, 300, 250, NULL
		invoke LineTo, hDC, 250, 200
		szText szText3, "figure"
		invoke TextOut,		hDC, 215, 115, addr szText3, 6
	.elseif figure == 4
		invoke MoveToEx, hDC, 200, 250, NULL
		invoke LineTo, hDC, 500, 250
		invoke LineTo, hDC, 495, 245
		invoke MoveToEx, hDC, 500, 250, NULL
		invoke LineTo, hDC, 495, 255
		szText szText6, "x"
		invoke TextOut,		hDC, 480, 250, addr szText6, 1
		invoke MoveToEx, hDC, 350, 350, NULL
		invoke LineTo, hDC, 350, 150
		invoke LineTo, hDC, 345, 155
		invoke MoveToEx, hDC, 350, 150, NULL
		invoke LineTo, hDC, 355, 155
		szText szText7, "y"
		invoke TextOut,		hDC, 325, 150, addr szText7, 1
		szText szText4, "graphik"
		invoke TextOut,		hDC, 215, 115, addr szText4, 7
		
		mov ecx, 450
		.while ecx!=550
			xor	edx, edx
			mov	esi,  2
			mov eax, ecx
			sub	eax, 450
			.if eax < 1
				neg eax
			.endif
			mov ebx, eax
			div	esi
			mov	eax, 430
			sub	eax, ebx
			sub	eax, 80
			push ecx
			sub 	ecx, 200
			invoke SetPixel, hDC, ecx, eax, 0000000h
			pop ecx
			inc ecx
		.endw
		mov ecx, 350
		.while ecx!=450
			xor	edx, edx
			mov	esi,  2
			mov eax, ecx
			sub	eax, 450
			mov ebx, eax
			div	esi
			mov	eax, 430
			add	eax, ebx
			sub 	eax, 80
			push ecx
			invoke SetPixel, hDC, ecx, eax, 0000000h
			pop ecx
			inc ecx
		.endw
		
	.elseif figure == 5
		
		szText szText5, "color rect."
		invoke TextOut,		hDC, 215, 115, addr szText5, 12
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