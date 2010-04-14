import processing.serial.*;

Serial myPort;  // Create object from Serial class
int val;      // Data received from the serial port
String keyn = "No key was pressed"; // musical note
int xpos = 150, ypos = 10; // square postion; initial x,y position
int w = 30, h = 80; //square size

void setup() 
{
  
  size(570, 300); // window size
  
  PFont myFont = createFont(PFont.list()[2], 14);
  textFont(myFont);
  
  // The serial list on a  mac is always my  FTDI adaptor, 
  // so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  // We will be using COM3 port to communicate with Arduino
  String portName = Serial.list()[0];
  myPort = new Serial(this, "COM3", 9600);
}
void draw()
{
  if ( myPort.available() > 0) {  // If data is available,
    val = myPort.read();         // read it and store it in val
  }
  background(0);             // Set background to black
 
  fill(255); // set default fill for rectangles
  rect(xpos, ypos, w, h);
  rect(xpos + 35, ypos, w, h);
  rect(xpos + 70, ypos, w, h);
  rect(xpos +105, ypos, w, h);
  rect(xpos +140, ypos, w, h);
  rect(xpos +175, ypos, w, h);
  rect(xpos +210, ypos, w, h);
  rect(xpos +245, ypos, w, h);
  
/*
* display the piano key that is pressed on the keyboard connected to arduino
* and also an ellipse for a visual effect
*/
  switch (val) {
        case 1: // Q -> 1 -> C
          fill(204, 102, 0);
          rect(xpos, ypos, w, h);
          keyn= "C";
          fill(215,100,50); 
          ellipse(129, 180, 30, 30);
          break;
        case 2: // W -> 2 -> D 
           fill(204, 102, 0);
           rect(xpos + 35, ypos, w, h); 
           keyn= "D";
           fill(80,202,10);
           ellipse(68, 200, 80, 90);
          break;
        case 3: // E -> 3 -> E
          fill(204, 102, 0);
          rect(xpos + 70, ypos, w, h);
           keyn= "E";
          fill(0,55,180);
          ellipse(300, 211, 50, 20);
          break;
        case 4: // R -> 4 -> F 
          fill(204, 102, 0);
          rect(xpos +105, ypos, w, h);
           keyn= "F";
           fill(255,55,80);
          ellipse(280, 198, 60, 60);
          break;
        case 5: // T -> 5 -> G
          fill(204, 102, 0);
          rect(xpos +140, ypos, w, h);
           keyn= "G";
           fill(80,10,70);
          ellipse(250, 211, 40, 40);
          break;
        case 6: // Y -> 6 -> A
          fill(204, 102, 0);
          rect(xpos +175, ypos, w, h);
           keyn= "A";
           fill(20,60,0);
          ellipse(30, 251, 80, 60);
          break;
        case 7: // U -> 7 -> B
          fill(204, 102, 0);
          rect(xpos +210, ypos, w, h);
           keyn= "B";
           fill(200,100,50);
          ellipse(100, 185, 90, 100);
          break;
        case 8: // I -> 8 -> c
          fill(204, 102, 0);
          rect(xpos +245, ypos, w, h);
           keyn= "c";
           fill(80,40,280);
          ellipse(500, 211, 60, 90);
          break;
        default: 
          break;
  }
   // write musical note
   fill(255);
   text("Music note: " + keyn, 10, 120);
}
