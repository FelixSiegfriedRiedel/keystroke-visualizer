int isShadow = 0;
int randomSeed;
boolean isRecording = true;

import controlP5.*;

ControlP5 cp5;

void setup() {
  size(800, 800);
  background(255);
  textMode(SHAPE);
  fontList = PFont.list();
  textFont = createFont("Unifont", textSize);
  textFont(textFont);

  cp5 = new ControlP5(this);
  
  cp5.addButton("record")
     .setValue(0)
     .setPosition(width-50,0)
     .setSize(50,50)
     ;
  
  cp5.addButton("stop")
     .setValue(0)
     .setPosition(width-50,50)
     .setSize(50,50)
     ;
}

void draw() {
  background(255);
  fill(0);
  if(isRecording) {
    recordText();
    drawCurvedText();
    displayText();
  }
}

void record() {
  isRecording = true;
  output = createWriter("text.txt"); 
}

void stop() {
  isRecording = false;
  output.println(int(random(1000)));
  output.println(text);
  output.flush(); 
  output.close();  
}
