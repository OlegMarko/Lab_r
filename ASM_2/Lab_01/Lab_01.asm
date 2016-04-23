	.586
	.model flat, stdcall
	option casemap :none
	
include 	D:\masm32\include\windows.inc
include 	D:\masm32\include\kernel32.inc
include 	D:\masm32\include\user32.inc	
include		D:\masm32\include\shlwapi.inc

includelib D:\masm32\lib\shlwapi.lib
includelib D:\masm32\lib\kernel32.lib
includelib D:\masm32\lib\user32.lib


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


WinMain     PROTO :DWORD,:DWORD,:DWORD,:DWORD 
DialogProc  PROTO :DWORD,:DWORD,:DWORD,:DWORD
 
.data 
  
hInstance  dd 0 
CommandLine  dd 0 
hEdit1   dd 0 
hEdit2   dd 0 
hEdit3   dd 0 
X	dd 0
Y	dd 0
szInt1  db 50  dup (0) 
szInt2  db 50  dup (0) 
szBuffer db 256 dup (0)
 
.code                                          ;======= опис сегменту коду ========= 
start: 
let hInstance, GetModuleHandle, NULL 
let CommandLine, GetCommandLine 
invoke WinMain, hInstance, NULL, CommandLine, SW_SHOWDEFAULT 
invoke ExitProcess, eax 
 
WinMain proc hInst:DWORD, hPrew:DWORD, CmdLine:DWORD, CmdShow:DWORD 
   invoke DialogBoxParam, hInst, 700, 0, addr DialogProc, 0 
   return 0 
WinMain endp 
 
DialogProc proc hWnd:DWORD, uMsg:DWORD, wParam:DWORD, lParam:DWORD 
   .if uMsg == WM_CLOSE 
    invoke EndDialog, hWnd,0    ; 0) ----- реакція на закриття програми 
	szText szMsg, "Вже покидаєте, навіть чаю не випивши?"
		szText szMsgTitle, "Повідомлення" 
		invoke MessageBox, hWnd, addr szMsg, addr szMsgTitle, MB_OK+MB_ICONINFORMATION 
	
   .elseif uMsg == WM_INITDIALOG 
        ; 1) ----- видача MessageBox-повідомлення 
    szText szMsg1, "Стартує моя перша діалогова програма!!!" 
  szText szMsgTitle1, "Повідомлення" 
  invoke MessageBox, hWnd, addr szMsg1, addr szMsgTitle1, MB_OK+MB_ICONINFORMATION 
      ; 2) ----- зміна іконки вікна 
  invoke LoadIcon, hInstance, 500 
  invoke SendMessage, hWnd, WM_SETICON, 1, eax 
      ; 3) ----- отримання дескрипторів малих віконець  
  let hEdit1, GetDlgItem, hWnd, 201 
  let hEdit2, GetDlgItem, hWnd, 202 
  let hEdit3, GetDlgItem, hWnd, 203  
   .elseif uMsg == WM_COMMAND 
  .if wParam == 301 
        ; а) -- зчитування текстів з Edit-віконець 
    invoke GetWindowText, hEdit1, addr szInt1, 20 
	invoke StrToInt, addr szInt1
		mov X, eax
    invoke GetWindowText, hEdit2, addr szInt2, 20
	invoke StrToInt, addr szInt2
		mov Y, eax
		
		mov eax, X
		mul Y
		mov X, eax
	
        ; б) -- видача нового тексту в MessageBox-повідомлення 
		
    szText szFormat1, "X * Y = %d"  
    invoke wsprintf, addr szBuffer, addr szFormat1, X 
    invoke MessageBox, hWnd, addr szBuffer, addr szMsgTitle, MB_OK+MB_ICONSTOP 
        ; в) -- видача нового тексту в Edit-віконце 
	    szText szFormat2, "X * Y = %d" 
		invoke wsprintf, addr szBuffer, addr szFormat2, X
		invoke SetWindowText, hEdit3, addr szBuffer     
  .endif 
  .if wParam == 302
	szText szString , "sdfsdfsd  dsfsdfsdfsd             dfg dfgddsds       dfgdfsdfsdfsd sdfsdf dsfsdf  s   d   dsfdsfsdfsdf dsf sdf sd ...           sdfsdfsdf                     dsfsdfsdfs                      sdfsdf"
    invoke wsprintf, addr szBuffer, addr szString	
    invoke MessageBox, hWnd, addr szBuffer, addr szMsgTitle, MB_OK+MB_ICONSTOP 
	
    
  .endif
  
   .endif 
   return 0 
DialogProc endp 
end start 