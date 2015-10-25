PATH=C:\Sweet32\examples;C:\Sweet32\bin;C:\Sweet32\include;
smlrc -flat32 HelloWorld.c z.asm
XLAsm z.asm -o z.swe
XLAsm z.asm -o z.bin
pause


