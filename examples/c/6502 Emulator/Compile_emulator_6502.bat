ECHO ***** NOTE: Must have MinGW installed to compile this example!!! ****

PATH=C:\MinGW\bin;C:\Sweet32\examples;C:\Sweet32\bin;C:\Sweet32\include;
gcc -E emulator_6502.c -o temp.c
smlrc -flat32 temp.c z.asm
del temp.c
XLAsm z.asm -o z.swe
XLAsm z.asm -o z.bin
pause


