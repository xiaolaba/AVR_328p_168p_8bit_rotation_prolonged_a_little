// by xiaolaba, atmega168p /328p, IO and max frequency output testing
// for 16 MHz Arduino UNO 2 MHz Square Wave Generator code

// 2 MHz, 1 cycle = 0.5 us (microsecond)
// 2 MHz square wave, 0.25us HIGH, then 0.25us LOW signal
// Arduino UNO turns 8 cycles per microsecond so 4 cycles HIGH 4 cycles LOW

// REF: https://github.com/oakayasaroglu/uno_oneMHz_square_wave/blob/main/oneMHz_square.ino




//  HIGH    HIGH    HIGH    HIGH
// _----____----____----____----_
//      LOW     LOW     LOW



#include <avr/io.h>
#define F_CPU 16000000L

//#define ch_x1
#define ch_x4


int main(void);
void clk_2MHz_1ch(void);
void clk_2MHz_4ch(void);

void clk_2MHz_4ch(void) {		// jitter every 8bit rotation, but why ???
  __asm__ __volatile__ (          
  "cli" "\n\t"                // disable interrupts 
  "ldi r16, 0b01010101 \n\t"  // initial pattern for port B
  "ldi r17, 0b01010101 \n\t"  // initial pattern for port B  

///// REF: https://electronics.stackexchange.com/questions/411314/how-to-create-unique-label-on-macro-definition-on-avr-gnu-assembler

//"tick: "  // no uses. named label, uses ARduino IDE compile ok (avr-g++), but error with avr-gcc as symbol already defined.
"1: "         // numbered lable, works for avr-g++ and avr-gcc/assembler
  "out 0x05, r16 \n\t"  // 1 cycle, 2 byte, PORTB address is 0x05, output rotated pattern to PORTB
  "ror r16 \n\t"        // 1 cycle, 2 byte, ROR / ROL, T-flag is not affected

  "out 0x05, r17 \n\t"  // 1 cycle, 2 byte, PORTB address is 0x05, output rotated pattern to PORTB
  "ror r17 \n\t"        // 1 cycle, 2 byte, ROR / ROL, T-flag is not affected

  "rjmp 1b" "\n\t"      // 2 cycle, 2 byte, jump backward to label 1: inline asm code
//  "rjmp tick" "\n\t"    // no uses. 2 cycle, 2 byte, jump to named label 1, loop forever. g++ ok, gcc/asm NG. 
  );         
}

void clk_2MHz_1ch(void) { // 2MHz, good for one channel

  __asm__ __volatile__ (          
  "cli" "\n\t"			// disable interrupts

//"tock: "				// no uses

"2: "  
  "sbi 0x05,5" "\n\t"   // 2 cycles, PORTB(@0x05)PB5, pin13 of arduino, LED, LOW
  "nop" "\n\t" 			// 1 cycle                   
  "nop" "\n\t" 			// 1 cycle
						// total 4 cycles LOW, 4MHZ @ 16MHZ XTAL,  

  "cbi 0x05,5" "\n\t"   // 2 cycles, PORTB(@0x05), PB5, pin13 of arduino, LED, HIGH
  "rjmp 2b" "\n\t"     	// 2 cycle, jump to named label 1, loop forever
  						// total 4 cycles HIGH, 4MHZ @ 16MHZ XTAL,

  //"rjmp tock "\n\t"     // no uses. 2 cycle

  );
}

// sources: - http://ww1.microchip.com/downloads/en/devicedoc/atmel-0856-avr-instruction-set-manual.pdf
//          - https://electronics.stackexchange.com/a/84782



int main(void){
  // Arduino Nano 328p/168p, PB6/PB7 used for XTAL1/XTAL2, no IO pin exposed
  // PB5/4/3/2/1/0 used = Arduino pin 13/12/11/10/9/8
  DDRB = 0b00111111;  

#ifdef ch_x4  
  clk_2MHz_4ch();
#endif

#ifdef ch_x1
  clk_2MHz_1ch();
#endif

  return 0;
}
