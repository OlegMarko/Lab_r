if exist MyDLL.obj del MyDLL.obj
if exist MyDLL.dll del MyDLL.dll
d:\masm32\bin\ml /c /coff MyDLL.asm
d:\masm32\bin\Link /SUBSYSTEM:WINDOWS /DLL /DEF:MyDLL.def MyDLL.obj
if exist MyDLL.obj del MyDLL.obj
pause