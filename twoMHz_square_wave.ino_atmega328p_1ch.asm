
twoMHz_square_wave.ino_atmega328p_1ch.hex:     file format ihex


Disassembly of section .sec1:

00000000 <.sec1>:
   0:	0c 94 34 00 	jmp	0x68	;  0x68
   4:	0c 94 3e 00 	jmp	0x7c	;  0x7c
   8:	0c 94 3e 00 	jmp	0x7c	;  0x7c
   c:	0c 94 3e 00 	jmp	0x7c	;  0x7c
  10:	0c 94 3e 00 	jmp	0x7c	;  0x7c
  14:	0c 94 3e 00 	jmp	0x7c	;  0x7c
  18:	0c 94 3e 00 	jmp	0x7c	;  0x7c
  1c:	0c 94 3e 00 	jmp	0x7c	;  0x7c
  20:	0c 94 3e 00 	jmp	0x7c	;  0x7c
  24:	0c 94 3e 00 	jmp	0x7c	;  0x7c
  28:	0c 94 3e 00 	jmp	0x7c	;  0x7c
  2c:	0c 94 3e 00 	jmp	0x7c	;  0x7c
  30:	0c 94 3e 00 	jmp	0x7c	;  0x7c
  34:	0c 94 3e 00 	jmp	0x7c	;  0x7c
  38:	0c 94 3e 00 	jmp	0x7c	;  0x7c
  3c:	0c 94 3e 00 	jmp	0x7c	;  0x7c
  40:	0c 94 3e 00 	jmp	0x7c	;  0x7c
  44:	0c 94 3e 00 	jmp	0x7c	;  0x7c
  48:	0c 94 3e 00 	jmp	0x7c	;  0x7c
  4c:	0c 94 3e 00 	jmp	0x7c	;  0x7c
  50:	0c 94 3e 00 	jmp	0x7c	;  0x7c
  54:	0c 94 3e 00 	jmp	0x7c	;  0x7c
  58:	0c 94 3e 00 	jmp	0x7c	;  0x7c
  5c:	0c 94 3e 00 	jmp	0x7c	;  0x7c
  60:	0c 94 3e 00 	jmp	0x7c	;  0x7c
  64:	0c 94 3e 00 	jmp	0x7c	;  0x7c
  68:	11 24       	eor	r1, r1
  6a:	1f be       	out	0x3f, r1	; 63
  6c:	cf ef       	ldi	r28, 0xFF	; 255
  6e:	d8 e0       	ldi	r29, 0x08	; 8
  70:	de bf       	out	0x3e, r29	; 62
  72:	cd bf       	out	0x3d, r28	; 61
  74:	0e 94 50 00 	call	0xa0	;  0xa0
  78:	0c 94 5b 00 	jmp	0xb6	;  0xb6
  7c:	0c 94 00 00 	jmp	0	;  0x0
  80:	f8 94       	cli
  82:	05 e5       	ldi	r16, 0x55	; 85
  84:	15 e5       	ldi	r17, 0x55	; 85
  86:	05 b9       	out	0x05, r16	; 5
  88:	07 95       	ror	r16
  8a:	15 b9       	out	0x05, r17	; 5
  8c:	17 95       	ror	r17
  8e:	fb cf       	rjmp	.-10     	;  0x86
  90:	08 95       	ret
  92:	f8 94       	cli
  94:	2d 9a       	sbi	0x05, 5	; 5
  96:	00 00       	nop
  98:	00 00       	nop
  9a:	2d 98       	cbi	0x05, 5	; 5
  9c:	fb cf       	rjmp	.-10     	;  0x94
  9e:	08 95       	ret
  a0:	8f e3       	ldi	r24, 0x3F	; 63
  a2:	84 b9       	out	0x04, r24	; 4
  a4:	f8 94       	cli
  a6:	2d 9a       	sbi	0x05, 5	; 5
  a8:	00 00       	nop
  aa:	00 00       	nop
  ac:	2d 98       	cbi	0x05, 5	; 5
  ae:	fb cf       	rjmp	.-10     	;  0xa6
  b0:	80 e0       	ldi	r24, 0x00	; 0
  b2:	90 e0       	ldi	r25, 0x00	; 0
  b4:	08 95       	ret
  b6:	f8 94       	cli
  b8:	ff cf       	rjmp	.-2      	;  0xb8
