D:\masm32\bin\ml /c /coff Lab_08_4.asm 
 
D:\masm32\bin\rc Res.rc 
D:\masm32\bin\cvtres /MACHINE:ix86 Res.res 
 
D:\masm32\bin\link /subsystem:windows Lab_08_4.obj Res.obj 
 
pause 