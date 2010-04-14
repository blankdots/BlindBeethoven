import processing.serial.*;

Serial myPort;  // Create object from Serial class
int val;      // Data received from the serial port
String keyn = "No key was pressed"; // musical note
int xpos = 10, ypos = 10; // square postion; initial x,y position
int w = 30, h = 80; //square size 

void setup() 
{
  
  size(570, 300); // window size
  
  PFont myFont = createFont(PFont.list()[2], 14);
  textFont(myFont);
  
  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[0];
  myPort = new Serial(this, "COM3", 9600);
}
void draw()
{
  if ( myPort.available() > 0) {  // If data is available,
    val = myPort.read();         // read it and store it in val
  }
  background(0);             // Set background to black
 
  fill(255);
  rect(xpos, ypos, w, h);
  rect(xpos + 35, ypos, w, h);
  rect(xpos + 70, ypos, w, h);
  rect(xpos +105, ypos, w, h);
  rect(xpos +140, ypos, w, h);
  rect(xpos +175, ypos, w, h);
  rect(xpos +210, ypos, w, h);
  rect(xpos +245, ypos, w, h);
  
  switch (val) {
        case 1: // Q -> 1 -> C
          fill(204, 102, 0);
          rect(xpos, ypos, w, h);
          keyn= "C";
          fill()
          ellipse();
          break;
        case 2: // W -> 2 -> D 
           fill(204, 102, 0);
           rect(xpos + 35, ypos, w, h); 
           keyn= "D";
          break;
        case 3: // E -> 3 -> E
          fill(204, 102, 0);
          rect(xpos + 70, ypos, w, h);
           keyn= "E";
          break;
        case 4: // R -> 4 -> F 
          fill(204, 102, 0);
          rect(xpos +105, ypos, w, h);
           keyn= "F";
          break;
        case 5: // T -> 5 -> G
          fill(204, 102, 0);
          rect(xpos +140, ypos, w, h);
           keyn= "G";
          break;
        case 6: // Y -> 6 -> A
          fill(204, 102, 0);
          rect(xpos +175, ypos, w, h);
           keyn= "A";
          break;
        case 7: // U -> 7 -> B
          fill(204, 102, 0);
          rect(xpos +210, ypos, w, h);
           keyn= "B";
          break;
        case 8: // I -> 8 -> c
          fill(204, 102, 0);
          rect(xpos +245, ypos, w, h);
           keyn= "c";
          break;
        default: 
          break;
  }
  
   // write some text
   fill(255);
   text("Music note: " + keyn, 10, 120);
}
