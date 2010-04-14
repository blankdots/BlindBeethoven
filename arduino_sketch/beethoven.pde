/*
 * modified source code based on - ps2 keyboard piano
 * code for Smapler_v2 by BlushingBoy
 * 
 * - PS2 library found at: 
 *   http://www.arduino.cc/playground/ComponentLib/Ps2mouse
 *   Written by Chris J. Kiick, January 2008.
 */

#include <ps2.h>

// configure the speaker pins
int leftPin = 3; 	// left speaker on digital pin 3
int rightPin = 11; 	// right speaker on digital pin 11 

// loads the keyboard (kbd) object
// Pin 4 is the ps2 data pin, pin 2 is the clock pin
PS2 kbd(2, 4);

/*
 * easy way of playing notes in both channels (stereo)
 * the duration of the note will be controlled by
 * the potentiometer on pin 5
 */
void playNote(int tone) { 

  // timer is a reference to measure
  // the note's duration
  long timer = millis();

  // the potentiometer on Arduino's analogPin 5
  // is determining how long the note will be playing
  while (millis()-timer <= analogRead(5)) {

    // in this example the right speaker will be
    // playing a tone at twice the period than the
    // left speaker
    //       _*___     _____     _____
    // left       |____|    |____|    |____
    //       _*________          __________
    // right           |_________|
    digitalWrite(leftPin, HIGH);   
    digitalWrite(rightPin, HIGH);  
    delayMicroseconds(tone);       

    //       _____     _____     _____
    // left       |_*__|    |____|    |____
    //       _______*__          __________
    // right           |_________|
    digitalWrite(leftPin, LOW);    
    delayMicroseconds(tone);       

    //       _____     __*__     _____
    // left       |____|    |____|    |____
    //       __________          __________
    // right           |_*_______|
    digitalWrite(leftPin, HIGH);   
    digitalWrite(rightPin, LOW);   
    delayMicroseconds(tone);
       
    //       _____     _____     _____
    // left       |____|    |_*__|    |____
    //       __________          __________
    // right           |______*__|
    digitalWrite(leftPin, LOW);    
    delayMicroseconds(tone);       

  }
} 

/*
 * initialize the keyboard
 */
void kbd_init()
{
  char ack;

  kbd.write(0xff);   // send reset code
  ack = kbd.read();  // byte, kbd does self test
  ack = kbd.read();  // another ack when self test is done
}

void setup()
{
  // configure the pins for the speakers as outputs
  pinMode(leftPin, OUTPUT); 	// sets the digital pin as output
  pinMode(rightPin, OUTPUT);	// sets the digital pin as output
  
  // configure the serial port to monitor what is going on
  Serial.begin(9600);
  
  // initalize the keyboard
  kbd_init();
}

/* 
 * loop ( void )
 * 
 * maps the qwertyui keys to C-D-E-F-G-A-B-c
 * when it plays the note it prints a BYTE to the serial port
 * for the processing application to use it
 * and map the key-pressed event to a note
 */
void loop()
{
  unsigned char code; 
  int count = 0;

  for (;;) { /* ever */
    code = kbd.read(); 
 
    // when pressing and releasing a key e.g. "q" we
    // get three codes from the keyboard in sequence: 0x15 0xF0 0x15
    // the "count" variable helps to take only the first
    // one of those codes and filter the rest
 
    count++;

    // the F0 keyboard's scancode is the key released
    // event, we want to play only on pressed
    
    if (code != 0xF0 && count == 1) {
      switch (code) {
        case 21: // Q -> C
          playNote(1911);
           Serial.print(1, BYTE);
          break;
        case 29: // W -> D 
          playNote(1703);
           Serial.print(2, BYTE);
          break;
        case 36: // E -> E
          playNote(1517);
           Serial.print(3, BYTE);
          break;
        case 45: // R -> F 
          playNote(1432);
           Serial.print(4, BYTE);
          break;
        case 44: // T -> G
          playNote(1276);
           Serial.print(5, BYTE);
          break;
        case 53: // Y -> A
          playNote(1136);
           Serial.print(6, BYTE);
          break;
        case 60: // U -> B
          playNote(1012);
           Serial.print(7, BYTE);
          break;
        case 67: // I -> c
          playNote(956);
           Serial.print(8, BYTE);
          break;
        default:
          break;
      }
    }
    if (count == 3) count = 0;
  }
}
 
