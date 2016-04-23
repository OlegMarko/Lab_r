if exist MyDLL.obj del MyDLL.obj
if exist MyDLL.dll del MyDLL.dll
d:\masm32\bin\ml /c /coff MyDLL.asm

D:\masm32\bin\ml /c /coff CalDLL.asm 
 
D:\masm32\bin\rc Res.rc 
D:\masm32\bin\cvtres /MACHINE:ix86 Res.res 
 
d:\masm32\bin\Link /SUBSYSTEM:WINDOWS /DLL /DEF:MyDLL.def MyDLL.obj
D:\masm32\bin\link /subsystem:windows CalDLL.obj Res.obj 
if exist MyDLL.obj del MyDLL.obj
pause