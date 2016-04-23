    .586
    .model flat, stdcall
    option casemap :none  
; -----------------
    include D:\masm32\include\windows.inc
    include D:\masm32\include\user32.inc
    include D:\masm32\include\kernel32.inc
    includelib D:\masm32\lib\user32.lib
    includelib D:\masm32\lib\kernel32.lib

szText macro Name, Text:VARARG     
	jmp @F 
	Name db Text,0 
	@@: 
endm 

return macro arg                  
	mov eax, arg 	
	ret 
endm 
	
.code
LibMain proc hInstDLL:DWORD, reason:DWORD, unused:DWORD
        szText dllTitle,"tstdll's LibMain Function"

        .if reason == DLL_PROCESS_ATTACH
            szText ProcAttach,"PROCESS_ATTACH"
            invoke MessageBox,NULL,ADDR ProcAttach, addr dllTitle,MB_OK
            return TRUE ; якщо помилка - то буде return 0 - бібліотека не завантажиться
		
		.elseif reason == DLL_PROCESS_DETACH
            szText ProcDetach,"PROCESS_DETACH"
            invoke MessageBox,NULL,addr ProcDetach,addr dllTitle,MB_OK

        .elseif reason == DLL_THREAD_ATTACH
            szText ThreadAttach,"THREAD_ATTACH"
            invoke MessageBox,NULL,addr ThreadAttach,addr dllTitle,MB_OK

        .elseif reason == DLL_THREAD_DETACH
            szText ThreadDetach,"THREAD_DETACH"
            invoke MessageBox,NULL,addr ThreadDetach,addr dllTitle,MB_OK
        .endif
        ret
LibMain Endp
; --------------------------------------------
MyMessage proc 
	szText szMsg, "Це - функція з DLL-ки !"
	szText szTitle, "DLL MyDLL"
      invoke MessageBox,NULL, addr szMsg, addr szTitle, MB_OK
      ret
MyMessage endp
;---------------------------------------------
MyADD proc x:DWORD, y:DWORD
	mov eax, x
	add eax, y
	ret 
MyADD endp
;------------------------------------------------
End LibMain