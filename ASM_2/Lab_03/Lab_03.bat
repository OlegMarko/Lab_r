D:\masm32\bin\ml /c /coff Lab_03.asm 
 
D:\masm32\bin\rc Res.rc 
D:\masm32\bin\cvtres /MACHINE:ix86 Res.res 
 
D:\masm32\bin\link /subsystem:windows Lab_03.obj Res.obj 
 
pause 