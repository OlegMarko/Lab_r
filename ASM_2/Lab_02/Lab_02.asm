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


WinMain  PROTO :DWORD,:DWORD,:DWORD,:DWORD    
DlgProc  PROTO :DWORD,:DWORD,:DWORD,:DWORD 
DlgProc2 PROTO :DWORD,:DWORD,:DWORD,:DWORD 
 
.data 
hInstance  dd 0 
CommandLine  dd 0 
hFont	dd 0
hIcon	dd 0
hLabel	dd 0
hBmp1	dd 0
hBmp2	dd 0
hBmp3	dd 0
hBmp4	dd 0
hStatic	dd 0
hStatic1	dd 0
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
		.if uMsg == WM_CLOSE
				invoke DeleteObject, hFont
      			invoke EndDialog, hWnd, 0
				
		.elseif uMsg == WM_INITDIALOG
		
			let hIcon, LoadIcon, hInstance, 500    
			invoke SendMessage, hWnd, WM_SETICON, ICON_BIG, hIcon 

			szText szFontFace,"Times New Roman Cyr"	
			let hFont,  CreateFont,24,18,0,0,900,0,0,0,0,0,0,0,0,addr szFontFace
			let hLabel, GetDlgItem, hWnd, 101      
			invoke SendMessage, hLabel, WM_SETFONT, hFont, 1
			
			let hBmp1, LoadBitmap, hInstance, 601
			let hBmp2, LoadBitmap, hInstance, 602
			let hBmp3, LoadBitmap, hInstance, 603
			let hStatic, GetDlgItem, hWnd, 801           
			invoke SendMessage, hStatic, STM_SETIMAGE, IMAGE_BITMAP, hBmp1
			
		.elseif uMsg == WM_COMMAND 
		
			.if wParam == 301
				invoke  SendMessage, hStatic, STM_SETIMAGE, IMAGE_BITMAP, hBmp1
			.elseif wParam == 302
				invoke  SendMessage, hStatic, STM_SETIMAGE, IMAGE_BITMAP, hBmp2
			.elseif wParam == 303
				invoke  SendMessage, hStatic, STM_SETIMAGE, IMAGE_BITMAP, hBmp3
			.elseif wParam == 304
				invoke DialogBoxParam,  hInstance, 701, 0, addr DlgProc2, 0 
			.endif

   		.endif
		return 0
DlgProc endp

DlgProc2 proc  hWnd:DWORD, uMsg:DWORD, wParam:DWORD, lParam :DWORD
		.if uMsg == WM_CLOSE
      		invoke EndDialog, hWnd, 0
		.elseif uMsg == WM_INITDIALOG
			let hIcon, LoadIcon, hInstance, 501   
			invoke SendMessage, hWnd, WM_SETICON, ICON_BIG, hIcon 
			let hBmp4, LoadBitmap, hInstance, 604
			let hStatic1, GetDlgItem, hWnd, 800
			invoke  SendMessage, hStatic1, STM_SETIMAGE, IMAGE_BITMAP, hBmp4	
		.elseif uMsg == WM_COMMAND 
		
			.if wParam == 305
				invoke EndDialog, hWnd,0
			.endif
		.endif  
		return 0
DlgProc2 endp

end start 