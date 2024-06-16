prompt xiao$G 
set ac=C:\WinAVR-20100110
path %ac%\bin;%ac%\utils\bin;%path%
cls


set CHANNEL=4ch
::set CHANNEL=1ch


::set MCU=atmega328p
::set COMPORT=COM8
::set BAUD=115200

set MCU=atmega168p
set COMPORT=COM7
set BAUD=250000

set main=twoMHz_square_wave.ino

set HEX=%main%_%MCU%_%CHANNEL%.hex
set LST=%main%_%MCU%_%CHANNEL%.lst
set ASM=%main%_%MCU%_%CHANNEL%.asm
set PCB=arduino




avr-gcc.exe -dumpversion

REM compile c source file, 
::-xc, compile only, no link
::-save-temps , will produce *.s, asm file also
::-msize, output instruction size to asm file
::-pipe, uses pipe, no intermediate files
avr-gcc.exe -pipe -msize -xc -Os -mmcu=%MCU% -Wall -g %main% -o %main%.out 
::avr-gcc.exe -msize -save-temps -xc -Os -mmcu=%MCU% -Wall -g %main% -o %main%.out 
::avr-gcc.exe -msize -save-temps -S -mmcu=%MCU% %main% -o %main%.out 

REM report firmware size
avr-size.exe %main%.out

pause

::avr-gcc.exe -O2 -Wl,-Map, %1.map -o %1.out %1.c %2 %3 -mmcu=%MCU%

REM produce listing
avr-objdump.exe -h -S %main%.out > %LST%

REM produce hex file, firmware image
avr-objcopy.exe -O ihex %main%.out %HEX%

REM produce asm file of firmware image
avr-objdump -j .sec1 -d -m avr5 %HEX% > %ASM%



del %main%.out


:end

REM burn firmware to Nano
::avrdude -v -p %MCU% -c %PCB% -P %COMPORT% -b %BAUD% -D -Uflash:w:%HEX%:a



pause

