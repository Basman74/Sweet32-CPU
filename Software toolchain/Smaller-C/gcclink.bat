gcc -E fake6502.c -o temp.c
smlrc -flat32 temp.c out.asm
XLAsm out.asm -o a.swe
XLAsm out.asm -o z.bin
REM sweet32asm -q out.asm a.swe
pause


