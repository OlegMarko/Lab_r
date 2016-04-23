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


WinMain  	PROTO 	:DWORD,	:DWORD,	:DWORD,	:DWORD    
DlgProc 	PROTO 	:DWORD,	 :DWORD,	:DWORD,	:DWORD  
DlgProc2 	PROTO 	:DWORD,	 :DWORD,	:DWORD,	:DWORD  
BUF_LEN 	equ 10000	
BUFF_LEN 	equ 10000	

.data
 
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
		.if   uMsg   == WM_INITDIALOG
			let hIcon, LoadIcon, hInstance, 500
			invoke SendMessage, hWnd, WM_SETICON, ICON_BIG, hIcon 
			let hEdit1, GetDlgItem, hWnd, 7001
			let hEdit2, GetDlgItem, hWnd, 7003
		.elseif uMsg == WM_COMMAND
			.if wParam == 6000
				invoke SetWindowText, hEdit2, addr Buffer1
				let hFile, CreateFile, addr MyFile, GENERIC_READ, FILE_SHARE_READ, 0, OPEN_EXISTING, 0,0
				let n, SetFilePointer, hFile, 0, NULL, FILE_END
				invoke SetFilePointer, hFile, 0, NULL, FILE_BEGIN
				.if n>BUF_LEN
					mov n, BUF_LEN -1
				.endif
				invoke ReadFile, hFile, addr Buffer, n, addr n2, 0
				invoke CloseHandle, hFile
				invoke SetWindowText, hEdit1, addr MyFile
				invoke SetWindowText, hEdit2, addr Buffer
			.elseif	wParam == 6001
				invoke SetWindowText, hEdit2, addr Buffer1
				memset ofn, 0, sizeof OPENFILENAME   
				mov ofn.lStructSize, 	sizeof OPENFILENAME
				m2m ofn.hwndOwner, 	hWnd
				m2m ofn.hInstance, 	hInstance
				mov ofn.lpstrFile, 	offset FileName
				mov ofn.nMaxFile, 	2560
				mov ofn.lpstrFilter, 	offset filter1
				mov ofn.nFilterIndex, 	2 
				mov ofn.lpstrTitle, 	offset szOpen
				invoke GetOpenFileName, addr ofn
				let hFile, CreateFile, addr FileName, GENERIC_READ, FILE_SHARE_READ, 0, OPEN_EXISTING, 0,0
				let n, SetFilePointer, hFile, 0, NULL, FILE_END
				invoke SetFilePointer, hFile, 0, NULL, FILE_BEGIN
				.if n>BUF_LEN
					mov n, BUF_LEN -1
				.endif
				invoke ReadFile, hFile, addr Buffer, n, addr n2, 0
				invoke CloseHandle, hFile
				invoke SetWindowText, hEdit1, addr FileName
				invoke SetWindowText, hEdit2, addr Buffer
			.elseif wParam == 6002
				invoke GetWindowText, hEdit1, addr FileName, BUFF_LEN
				let hFile, CreateFile, addr FileName, GENERIC_READ + GENERIC_WRITE,  FILE_SHARE_READ, 0, CREATE_ALWAYS, 0,0
				invoke GetWindowText, hEdit2, addr Buffer, BUFF_LEN
				invoke WriteFile, hFile, addr Buffer, eax, addr n2, 0
				invoke CloseHandle, hFile
			.elseif	wParam == 6003
				memset ofn, 0, sizeof OPENFILENAME   
				mov ofn.lStructSize, 	sizeof OPENFILENAME
				m2m ofn.hwndOwner, 	hWnd
				m2m ofn.hInstance, 	hInstance
				mov ofn.lpstrFile, 	offset FileName
				mov ofn.nMaxFile, 	2560
				mov ofn.lpstrFilter, 	offset filter1
				mov ofn.nFilterIndex, 	2
				invoke GetSaveFileName, addr ofn
				let hFile, CreateFile, addr FileName, GENERIC_READ + GENERIC_WRITE, FILE_SHARE_READ, 0, CREATE_ALWAYS, 0,0
				invoke GetWindowText, hEdit2, addr Buffer, BUFF_LEN
				invoke WriteFile, hFile, addr Buffer, eax, addr n2, 0
				invoke CloseHandle, hFile
			.elseif wParam == 6004
				invoke EndDialog, hWnd,0
			.elseif wParam == 6200
				invoke DialogBoxParam,  hInstance, 701, 0, addr DlgProc2, 0
			.endif
		.elseif uMsg == WM_CLOSE
      		invoke EndDialog, hWnd, 0
   		.endif
		return 0
DlgProc endp

DlgProc2 proc  hWnd:DWORD, uMsg:DWORD, wParam:DWORD, lParam :DWORD
		.if uMsg == WM_CLOSE
      			invoke EndDialog, hWnd, 0
		.elseif uMsg == WM_INITDIALOG
			let hIcon, LoadIcon, hInstance, 500    
			invoke SendMessage, hWnd, WM_SETICON, ICON_BIG, hIcon 
			let hStatic, GetDlgItem, hWnd, 800
			invoke  SendMessage, hStatic, STM_SETIMAGE, IMAGE_BITMAP, hBmp1	
		.elseif uMsg == WM_COMMAND 
			.if wParam == 305
				invoke EndDialog, hWnd,0
			.endif
		.endif
		return 0
DlgProc2 endp

end start 