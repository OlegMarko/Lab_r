.386
.model flat,stdcall
option casemap:none

WinMain proto :DWORD,:DWORD,:DWORD,:DWORD

include \masm32\include\windows.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc
include \masm32\include\gdi32.inc
includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\gdi32.lib

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


.data
ClassName 		db "SimpleWinClass",0
AppName  		db "Моє вікно (без шибки)",0
char WPARAM 	20h
szDisplayName 	db "Моє вікно (без шибки)",0
szFormat1 		db "clc: %d  ",0
szFormat2 		db "x: %d y: %d ",0
szFormat 		db "timer: %d  ",0
szBuffer 		db 256 dup (0)
CommandLine  	dd 0
hWND          	dd 0
hInstance     	dd 0
clc01		  	dd 0
clcTimer		dd 0
szTimerStart	dd 0
MouseClick 		db 0     
 EditClassName db "edit",0
hwndEdit		dd 0 

hitpoint POINT <>


.code
start:
let hInstance, GetModuleHandle, NULL 
    let CommandLine, GetCommandLine 

    invoke WinMain, hInstance, NULL, CommandLine, SW_SHOWDEFAULT
    
    invoke ExitProcess,eax       
; --------------------------------------------------

WinMain proc hInst:DWORD, hPrevInst:DWORD, CmdLine:DWORD, CmdShow:DWORD

        LOCAL wc   :WNDCLASSEX
        LOCAL msg  :MSG
	
        szText szClassName, "My_Class"

        mov wc.cbSize,         sizeof WNDCLASSEX
        mov wc.style,          CS_HREDRAW or CS_VREDRAW or CS_BYTEALIGNWINDOW or CS_DBLCLKS
        mov wc.lpfnWndProc,    offset WndProc      
        mov wc.cbClsExtra,     NULL
        mov wc.cbWndExtra,     NULL
        m2m wc.hInstance,      hInst               
        mov wc.hbrBackground,  COLOR_BTNSHADOW
        mov wc.lpszMenuName,   NULL
        mov wc.lpszClassName,  offset szClassName  
          invoke LoadIcon, hInst, 500    
        mov wc.hIcon,          eax
          invoke LoadCursor, NULL, IDC_ARROW         
        mov wc.hCursor,        eax
        mov wc.hIconSm,        0

        invoke RegisterClassEx, ADDR wc     ; register the window class

        let hWND, CreateWindowEx, WS_EX_OVERLAPPEDWINDOW, 			\
ADDR szClassName, ADDR szDisplayName, 	\
                              WS_OVERLAPPEDWINDOW, 				\
                              10, 10, 300, 200, 				\
                              NULL, NULL, hInst, NULL
        invoke LoadMenu, hInst, 600          
  invoke SetMenu, hWND, eax
        invoke ShowWindow, hWND, SW_SHOWNORMAL      
        invoke UpdateWindow, hWND
  
    Cycle:
      invoke GetMessage, ADDR msg, NULL, 0, 0         
      cmp eax, 0                                  
      je Exit                                 
      invoke TranslateMessage, ADDR msg           
      invoke DispatchMessage,  ADDR msg           
      jmp Cycle
    Exit:
      return msg.wParam
WinMain endp


WndProc proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
	LOCAL hdc:HDC
	LOCAL ps:PAINTSTRUCT

	.if    uMsg == WM_COMMAND
        .if wParam == 6002 		; вихід
            invoke SendMessage, hWnd, WM_SYSCOMMAND, SC_CLOSE, NULL
        .elseif wParam == 6003	; створити дочірне вікно
            invoke CreateWindowEx,WS_EX_CLIENTEDGE, ADDR EditClassName,NULL,\
                           WS_CHILD or WS_VISIBLE or WS_BORDER or ES_LEFT or\
                           ES_AUTOHSCROLL,\
                           50,35,200,25,hWnd,8,hInstance,NULL
           mov  hwndEdit,eax
        .endif

    .elseif uMsg == WM_CREATE
		; .........

    .elseif uMsg == WM_DESTROY
        invoke PostQuitMessage,NULL
        return 0 		
		
	.ELSEIF uMsg==WM_CHAR
		push wParam
		pop  char
		inc clc01
		.if char < 59
			.if char > 41
				szText Text6, "shift"
				INVOKE TextOut, hdc, 25, 20, OFFSET Text6, 5
			.endif
		.elseif  char < 31
			szText Text5, "ctrl"
			INVOKE TextOut, hdc, 25, 20, OFFSET Text5, 4
		.endif
		invoke InvalidateRect, hWnd,NULL,TRUE
	.ELSEIF uMsg==WM_PAINT
		invoke BeginPaint,hWnd, ADDR ps
		mov    hdc,eax
		invoke TextOut,hdc,0,0,ADDR char,1
		invoke EndPaint,hWnd, ADDR ps
	
	.elseif uMsg == WM_SYSCHAR
		.if wParam == VK_SHIFT
			szText Text1, "shift"
			INVOKE TextOut, hdc, 25, 20, OFFSET Text1, 5
		.elseif  wParam == VK_CONTROL
			szText Text2, "ctrl"
			INVOKE TextOut, hdc, 25, 20, OFFSET Text2, 4
		.endif
	.elseif uMsg == WM_SYSKEYDOWN 
		.if wParam == MK_SHIFT
			szText Text3, "shift"
			INVOKE TextOut, hdc, 25, 20, OFFSET Text1, 5
		.elseif  wParam == MK_CONTROL
			szText Text4, "ctrl"
			INVOKE TextOut, hdc, 25, 20, OFFSET Text2, 4
		.endif
	
	.elseif	uMsg == WM_RBUTTONDOWN
		INVOKE SetTimer,hWnd,1,1000,NULL
        INVOKE MessageBox, hWnd, OFFSET szTimerStart, OFFSET AppName, MB_OK
			MOV clcTimer, 0

	.elseif	uMsg == WM_TIMER
		MOV EAX, clcTimer
        ADD EAX,1
        MOV clcTimer,EAX
        invoke InvalidateRect, hWnd,NULL,TRUE
		
	.elseif uMsg == WM_LBUTTONDBLCLK
		INVOKE wsprintf,addr szBuffer,addr szFormat1, clc01
		INVOKE MessageBox, hWnd, addr szBuffer, addr AppName, MB_OK
	
	;.ELSEIF uMsg==WM_LBUTTONDOWN
		INVOKE MessageBox, hWnd, addr char, addr AppName, MB_OK
		INVOKE wsprintf,addr szBuffer,addr szFormat, clcTimer
		INVOKE MessageBox, hWnd, addr szBuffer, addr AppName, MB_OK
		;INVOKE wsprintf,addr szBuffer,addr szFormat1, clc01
		;INVOKE MessageBox, hWnd, addr szBuffer, addr AppName, MB_OK
		
	.elseif uMsg == WM_MOUSEMOVE
           mov eax,lParam
           and eax,0FFFFh
           mov hitpoint.x,eax
           mov eax,lParam
           shr eax,16
           mov hitpoint.y,eax
           mov MouseClick,TRUE
           invoke InvalidateRect,hWnd,NULL,TRUE
    ;.ELSEIF uMsg==WM_PAINT
			invoke BeginPaint,hWnd, ADDR ps
			mov    hdc,eax
            invoke lstrlen,ADDR AppName
			invoke wsprintf,OFFSET szBuffer,OFFSET szFormat2, hitpoint.x, hitpoint.y
			INVOKE TextOut, hdc, 195, 0, OFFSET szBuffer, EAX
			invoke EndPaint,hWnd, ADDR ps
		
	.elseif uMsg == WM_CLOSE
        szText TheText, "Чи дійсно ви бажаєте покинути програму?"
        invoke MessageBox, hWnd, ADDR TheText, ADDR szDisplayName, MB_YESNO
        .if eax == IDNO
            invoke EndDialog, hWnd,0
        .endif	
	.endif

invoke DefWindowProc,hWnd,uMsg,wParam,lParam
    ret

WndProc endp
end start
