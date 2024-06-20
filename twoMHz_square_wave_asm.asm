;Atmel assembler, avrasm2.exe will uses *.inc
;Gavrasm assembler, no need and do not use *.inc

.nolist
	.include "m328Pdef.inc"	;included for compability only
.list

; what follows is to be placed in program memory
.cseg

; starting at this address
.org 0x0000

	jmp Setup
	
KHz2667:
	sbi PORTB, PB5		;2 cycles
	;nop				;1 cycles
	;nop				;1 cycles
	cbi PORTB, PB5		;2 cycles
	rjmp KHz2667		;2 cycles
	
KHz2182:
	sbi PORTB, PB5		;2 cycles
	nop					;1 cycles
	;nop				;1 cycles
	cbi PORTB, PB5		;2 cycles
	rjmp KHz2182		;2 cycles
	
KHz2000:	; 50% duty cycle
	sbi PORTB, PB5		;2 cycles
	nop					;1 cycles
	nop					;1 cycles
	cbi PORTB, PB5		;2 cycles
	rjmp KHz2000		;2 cycles
	
KHz1846:	; duty cycle
	sbi PORTB, PB5		;2 cycles
	nop					;1 cycles
	nop					;1 cycles
	nop					;1 cycles
	cbi PORTB, PB5		;2 cycles
	rjmp KHz1846		;2 cycles		


KHz1600:	; 50% duty cycle
	sbi PORTB, PB5		;2 cycles
	nop					;1 cycles
	nop					;1 cycles
	nop					;1 cycles
	cbi PORTB, PB5		;2 cycles
	nop					;1 cycles	
	rjmp KHz1600		;2 cycles		

KHz1333:	; 50% duty cycle
	sbi PORTB, PB5		;2 cycles
	nop					;1 cycles
	nop					;1 cycles
	nop					;1 cycles
	nop					;1 cycles

	cbi PORTB, PB5		;2 cycles
	nop					;1 cycles	
	nop					;1 cycles
	rjmp KHz1333		;2 cycles

Setup:
	cli	;disable all interrupt

	;; set PB5~PB0 to output using DDRB
    ldi r16, 0b00111111	;arduino nano/uno, PB6/PB7 used for XTAL1/XTAL2, not IO
	out DDRB, r16
	;jmp bit_IO

	jmp rolling_IO_9bit
	;jmp eor_IO	
	;jmp rolling_IO
	
	;jmp map_IO
	;jmp reg_IO

	;jmp KHz2667
	;jmp KHz2182
	;jmp KHz2000
	;jmp KHz1846
	;jmp KHz1600
	;jmp KHz1333
	


rolling_IO_9bit:
	;; mega168/328, output mode, PB5~PB0 = arduino pin# D13 ~ D8, D13 has on broad LED
	ldi r16, 0b00111111	;	
	out DDRB, r16		; output mode, PB5~PB0
	
	;8bit pattern to rolling and output to PORTB testing only
	ldi r16, 0b00100010	;

	clc	; clear C for rolling bits
	;; PORTB    | C-flag, ror, PORTB    | C-flag, ror, PORTB    | C-flag,
	;; 10101010 | 0            01010101   0            00101010   1

	;sec	; set C for rolling bits
	;; PORTB    | C, ror ->, PORTB    | C, ror ->, PORTB    | C
	;; 10101010 | 1          11010101   0          10110101   0
	
rolling_IO_9bit_loop:
	out PORTB, r16	; output pattern to PORTB
    ror r16			; rotate pattern
    rjmp rolling_IO_9bit_loop		; repeat forever, arduino pin# D13 on board LED must be light up and seen



rolling_IO:
	;24bit pattern to rolling and output to PORTB testing only
	ldi r16, 0b10101010	;
	ldi r17, 0b10101010	;
	ldi r18, 0b10101010	;
	
	;24bit pattern to rolling and output to PORTB, SDR local osc
	ldi r16, 0b10001000	; 
	ldi r17, 0b10001000 ; 
	ldi r18, 0b10001000	;	
	
	;; mega168/328, PB5~PB0 = arduino pin# D13 ~ D8, D13 has on broad LED
	out PORTB, r16		; output pattern to PORTB

	clc	; clear C for rolling bits
rolling_IO_loop:
    ror r16			; rotate pattern
	out PORTB, r16	; output pattern to PORTB
    ror r17			; rotate pattern
	out PORTB, r17	; output pattern to PORTB
    ror r18			; rotate pattern
	out PORTB, r18	; output pattern to PORTB
    rjmp rolling_IO_loop		; repeat forever, arduino pin# D13 on board LED must be light up and seen



map_IO:

	;; mega168/328, PB5~PB0 = arduino pin# D13 ~ D8, D13 has on broad LED
	ldi r16, 0b00111111	;
	out PORTB, r16		; output pattern to PORTB

	; table of rolling bit pattern 
	ldi r16, 0b00100000	;
	ldi r17, 0b00010000	;
	ldi r18, 0b00001000	;
	ldi r19, 0b00000100	;
	ldi r20, 0b00000010	;
	ldi r21, 0b00000001	;

	; put the table on time
map_IO_loop:
	out PORTB, r16	; output pattern to PORTB
	;nop
	;nop
	out PORTB, r17	; output pattern to PORTB
	;nop
	;nop
	out PORTB, r18	; output pattern to PORTB
	;nop
	;nop
	out PORTB, r19	; output pattern to PORTB
	;nop
	;nop
	out PORTB, r20	; output pattern to PORTB
	;nop
	;nop
	out PORTB, r21	; output pattern to PORTB
    rjmp map_IO_loop		; repeat forever, arduino pin# D13 on board LED must be light up and seen




bit_IO:
	ldi r16, 0b00100000 ; preload pattern
bit_IO_loop:	
	sbi PORTB, PB5	;2 cycles
	cbi PORTB, PB5	;2 cycles

	sbi PORTB, PB4	;2 cycles
	cbi PORTB, PB4	;2 cycles

	sbi PORTB, PB3	;2 cycles
	cbi PORTB, PB3	;2 cycles

	sbi PORTB, PB2	;2 cycles
	cbi PORTB, PB2	;2 cycles
	
	sbi PORTB, PB1	;2 cycles
	cbi PORTB, PB1	;2 cycles

	;sbi PORTB, PB0	;2 cycles
	;cbi PORTB, PB0	;2 cycles

	;ldi r16, 0b00000010	; PB1	;2 cycles
	;out PORTB, r16			;2 cycles
	
	ldi r16, 0b00000001	;; set PB0	;2 cycles
	out PORTB, r16	;2 cycles
	ldi r16, 0b00000000	;; clear PB0	;2 cycles
	out PORTB, r16	;2 cycles
	
	;cbi PORTB, PB0	; clear PB0, 2 cycles

	rjmp bit_IO_loop ;2 cycles
	

reg_IO:
	ldi r16, 0b00100000 ; preload pattern
reg_IO_loop:
	sts PORTB+0x20, r16	;2 cycles, memory mapped IO, address +0x20

;	ldi r16, 0b01000000
;	sts PORTB+0x20, r16	;2 cycles

;	ldi r16, 0b00100000
;	sts PORTB+0x20, r16	;2 cycles

	ldi r16, 0b00010000
	sts PORTB+0x20, r16	;2 cycles

	ldi r16, 0b00001000
	sts PORTB+0x20, r16 ;2 cycles

	ldi r16, 0b00000100
	sts PORTB+0x20, r16 ;2 cycles

	ldi r16, 0b00000010
	sts PORTB+0x20, r16 ;2 cycles

	ldi r16, 0b00000001
	sts PORTB+0x20, r16 ;2 cycles

	ldi r16, 0b00100000
	;sts PORTB+0x20, r16 ;2 cycles

	rjmp reg_IO_loop	 ;2 cycle
	

eor_IO:	;unsymmetrical and no deal with rolling bits
    ; set PB5~PB0 to output using DDRB
    ldi r16, 0b00111111
    out DDRB, r16
    ldi r17, 0b00111111 ; mask  
    ldi r16, 0b00101010 ; output pattern to PORTB
eorMain:
    eor r16, r17        ; rotate pattern
    out PORTB, r16      ; output pattern to PORTB
    eor r16, r17        ; rotate pattern
    out PORTB, r16      ; output pattern to PORTB
    eor r16, r17        ; rotate pattern
    out PORTB, r16      ; output pattern to PORTB
    rjmp eorMain        ; repeat forever