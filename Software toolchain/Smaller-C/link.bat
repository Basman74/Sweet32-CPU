smlrc -flat32 -sweet32app blinky.c out.asm
XLAsm out.asm -o a.swe
XLAsm out.asm -o z.bin
REM sweet32asm -q out.asm a.swe
pause


