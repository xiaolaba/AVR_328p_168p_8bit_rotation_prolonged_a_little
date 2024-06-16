@echo off

set mcu=atmega168p

::mega168p WDT ON, picoboot,  
::set efuse=0xfc
::set hfuse=0xd6
::set lfuse=0xf7

::mega168p WDT OFF, picoboot,  
::set efuse=0xfc
set hfuse=0xc6
::set lfuse=0xf7


set ac=C:\WinAVR-20100110

path %ac%\bin;%ac%\utils\bin;%path%;

@echo on

:::: for Arduino board USB-COM port with bootloader
::avrdude -v -p %mcu% -c %PCB% -P %COMPORT% -b %BAUD% -D -Uflash:w:%HEX%:a

:: for ISP programmer, usbtiny
::avrdude -c usbtiny -p %mcu% -U flash:w:"%main%":a -U lfuse:w:%lfuse%:m  -U hfuse:w:%hfuse%:m

avrdude -c usbtiny -p %mcu% -U hfuse:w:%hfuse%:m

pause