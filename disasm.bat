prompt $P$G  

::https://ucexperiment.wordpress.com/2015/01/04/dump-and-disassemble-avr-%C2%B5c-flash-memory/

set fl="%1"

set hex="oneMHz_square.ino.hex"
set path=%PATH%;C:\avr8-gnu-toolchain-win32_x86\bin

REM produce asm file of firmware image
avr-objdump -j .sec1 -d -m avr5 %hex% > %hex%.asm



pause