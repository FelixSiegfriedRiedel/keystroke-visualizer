int isShadow = 0;
int randomSeed;
boolean isRecording = true;
boolean wordsPrinted = true;
boolean isFlush = false;
float i;
String[] words;

import controlP5.*;

ControlP5 cp5;
Button recordButton;
Button stopButton;
Button flushButton;

void setup() {
  size(800, 800);
  background(255);
  textMode(SHAPE);
  fontList = PFont.list();
  textFont = createFont("Unifont", 90);
  textFont(textFont);

  cp5 = new ControlP5(this);

recordButton = cp5.addButton("record")
                    .setValue(0)
                    .setPosition(600, 490)
                    .setSize(160, 50)
                  .setColorBackground(color(0, 0, 0, 1)) // Background color
                    .setColorForeground(color(0, 0, 0, 1)) // Hover color
                    .setColorActive(color(0, 0, 0, 1)) // Active color
                    .setColorValue(color(0, 0, 0, 1)) // Text color
                    .setCaptionLabel("")
                    .setColorLabel(color(0, 0, 0, 1)); // Label color

  stopButton = cp5.addButton("stop")
                   .setValue(0)
                   .setPosition(600, 490)
                   .setSize(160, 50)
                   .setColorBackground(color(0,0,0 , 1))
                    .setColorForeground(color(0, 0, 0, 1)) // Hover color
                    .setColorActive(color(0, 0, 0, 1)) // Active color
                    .setColorValue(color(0, 0, 0, 1)) // Text color
                    .setColorLabel(color(0, 0, 0, 1)) // Label color
                    .setCaptionLabel("")
                   .hide(); // Hide stop button initially
                   
   flushButton = cp5.addButton("flush")
                   .setValue(0)
                   .setPosition(120, 710)
                   .setSize(150, 50)
                    .setColorBackground(color(0,0,0 , 1))
                    .setColorForeground(color(0, 0, 0, 1)) // Hover color
                    .setColorActive(color(0, 0, 0, 1)) // Active color
                    .setColorValue(color(0, 0, 0, 1)) // Text color
                    .setColorLabel(color(0, 0, 0, 1)) // Label color
                    .setCaptionLabel("flush");
                   
}

void draw() {
if ((mouseX > 150 && mouseX < 150 + 120 && mouseY > 710 && mouseY < 710 + 50) ||
        (mouseX > 600 && mouseX < 600 + 160 && mouseY > 490 && mouseY < 490 + 50)) {
        cursor(HAND);
    } else {
        cursor(ARROW);
    } 
  
background(255);
noStroke();

toilet(110, 350);
toilet(100, 340);



faces();
  if (isRecording) {
    speechBubble(170, 265, 480, 200, false);
    speechBubble(160, 255, 480, 200, false);
    speechBubble(170, 40, 390, 100, true);
    speechBubble(160, 30, 390, 100, true);
    textFont = createFont("Unifont", 30);
    textFont(textFont);
    fill(0);
    text("WHICH THOUGHTS\nBOTHER YOU TODAY?", 198, 78);
    recordButton.hide();
    stopButton.show();
    fill(0);
    textFont = createFont("Unifont", 30);
    textFont(textFont);
    recordText(width - 355);
    displayText(188, 278);
    wordsPrinted = false;
    i = 0;
  } else {
    stopButton.hide();
    recordButton.show();
    speechBubble(170, 40, 390, 100, true);
    speechBubble(160, 30, 390, 100, true);
    textFont = createFont("Unifont", 30);
    textFont(textFont);
    fill(0);
    if(isFlush) {
      text("FLUSH THEM!!!!", 198, 78);
    } else {
      text("WHICH THOUGHTS\nBOTHER YOU TODAY?", 198, 78);
    }
    pushMatrix();
  
  translate(250, 505);
  rotate(radians(i));
  drawTextOnArc(text, 0,0, 90-i*1);
  i += 1;
  if(i > 90) {
    isRecording = true;
    text = "";
    i = 0;
  }
  popMatrix();
  translate(0,0);
  }
}

void record() {
  isRecording = true;
  output = createWriter("text.txt"); 
}

void stop() {
  background(255);
  isRecording = false;
  output.println(int(random(1000)));
  output.println(text);
  output.flush(); 
  output.close();  
  String[] lines = loadStrings("text.txt");
  randomSeed(int(lines[0]));
  if (lines.length >1) {
    words = lines[1].split(" ");
  }
}

void flush() {
  if(text.length() > 0) {
      isRecording = false;
    } 
  
}


void speechBubble(int x, int y, int bubbleWidth, int bubbleHeight, boolean left) {
  int tailHeight = 20;
  int tailWidth = 40;

  // Outer black bubble
  fill(0);
  rect(x+0, y+20, bubbleWidth-0, bubbleHeight-30);
  rect(x+10, y+10, bubbleWidth-20, bubbleHeight-10);
  rect(x+20, y+0, bubbleWidth-40, bubbleHeight+10);

  // Inner white bubble
  fill(230);
  rect(x+20, y+20, bubbleWidth-40, bubbleHeight-30);
  rect(x+30, y+10, bubbleWidth-60, bubbleHeight-10);
  rect(x+10, y+30, bubbleWidth-20, bubbleHeight-50);
  
  
  // Tail positioning
  int tailX;
  if (left) {
    tailX = x + (int)(0.2 * bubbleWidth); // Within 20% on the left side
    fill(0);
    rect(tailX, y + bubbleHeight, tailWidth, 30); 
    rect(tailX - 10, y + bubbleHeight + 10, tailWidth, 30); 
    rect(tailX - 20, y + bubbleHeight + 20, tailWidth + 10, 20); 

    fill(230);
    rect(tailX + 0, y + bubbleHeight - 0, 30, tailHeight);
    rect(tailX - 10, y + bubbleHeight + 20, 30, 10);
} else {
    tailX = x + bubbleWidth - (int)(0.2 * bubbleWidth) - tailWidth; // Within 20% on the right side
    fill(0);
    rect(tailX, y + bubbleHeight, tailWidth, 30); 
    rect(tailX + 10, y + bubbleHeight + 10, tailWidth, 30); 
    rect(tailX + 20, y + bubbleHeight + 20, tailWidth - 0, 20); 

    fill(230);
    rect(tailX + 10, y + bubbleHeight - 0, 30, tailHeight);
    rect(tailX + 20, y + bubbleHeight + 20, 30, 10);
}
}

void toilet(int x, int y) {
  pushMatrix();
  translate(x-120, y-340);
  
  // Outer outline
  fill(0);
  rect(120, 680, 300, 120);  
  rect(140, 590, 260, 90);   
  rect(120, 360, 300, 300);  
  rect(130, 350, 270, 50);   
  rect(140, 340, 260, 50);   

  // Outer color (porcelain)
  fill(253);
  rect(130, 690, 280, 100);  // Base fill
  rect(150, 350, 240, 330);   // Tank fill
  rect(130, 370, 280, 280);   // Back fill
  rect(140, 360, 260, 50);    // Rim fill

  // Inner outline (bowl)
  fill(0);
  rect(170, 370, 200, 260);   // Bowl outline
  rect(160, 380, 220, 241);    // Inner bowl outline

  // Water in bowl
  fill(126, 174, 247);
  rect(169, 380, 200, 240);    // Water fill

  // Hole in bowl (under water)
     fill(0, 0, 0, 77);
  rect(230, 470, 80, 130);     
  fill(0, 0, 0, 101);
  rect(245, 490, 50, 90);      
  

  // Outline toilet button
  fill(0);
  rect(150, 710, 120, 50);      // Button outline

  // Filling toilet button
  fill(252);
  rect(160, 720, 100, 30);      // Button fill

  popMatrix();
}


void faces() {
  
//Face
fill(0);
rect(45, 170, 160, 50);
fill(222, 222, 198);
rect(35, 160, 160, 50);
fill(3);
textFont = createFont("Unifont", 40);
textFont(textFont);
text("( ͡° ͜ʖ ͡°)", 34, 199);


fill(0);
rect(610, 500, 160, 50);
fill(242, 201, 239);
rect(600, 490, 160, 50);
fill(3);
textFont = createFont("Unifont", 40);
textFont(textFont);
text("(ಥ﹏ಥ)", 599, 528);
}

void drawTextOnArc(String text, float centerX, float centerY, float radius) {
  if (radius > 0) {
  float charSize = 100 * radius / 360;  // Define the size of the letters
  textSize(charSize);
  int len = text.length();
  
  // Calculate the total arc angle based on the length of the text
  float arcLength = len * charSize * 0.5;      // Approximate total text length
  float arcAngle = arcLength / radius;   // Calculate angle span for arc
  
  float startAngle = -arcAngle / 2;      // Start angle to center text on the arc

  // Loop through each character in the string
  for (int i = 0; i < len; i++) {
    float angle = startAngle + map(i, 0, len - -2, 0, arcAngle);  // Angle for each character
    
    // Calculate the x, y position on the arc for each character
    float x = centerX + cos(angle) * (radius-i*0.5);
    float y = centerY + sin(angle) * (radius-i*0.5);
    
    // Push matrix to rotate each character separately
    pushMatrix();
    translate(x, y);                     // Move to the character position
    rotate(angle + PI / 2);              // Rotate to align with arc direction
    text(text.charAt(i), 1, -9);          // Draw the character
    popMatrix();
  }
  }
}
