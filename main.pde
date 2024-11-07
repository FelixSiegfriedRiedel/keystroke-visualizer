int isShadow = 0;
int randomSeed;
boolean isRecording = true;
boolean wordsPrinted = true;
boolean isFlush = false;
boolean isRefill = false;

float textSize = 30;
float textX = random(10, width);
float textY = random(10, height);
float textWidth;
color textColor;

String[] fontList;
PFont textFont;


boolean isSewer = false;

int i;
int textLength;

int lastTime = 0;
int delayTime = 20;

PImage tiles;
PImage sewer;


import controlP5.*;

ControlP5 cp5;
Button recordButton;
Button stopButton;
Button flushButton;

void setup() {
  initBounce();
  delay(100);
  size(800, 800);
tiles = loadImage("img/tiles.jpg");
sewer = loadImage("img/sewer.jpg");
initSound();
background(tiles);
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
                    .setColorLabel(color(0, 0, 0, 1)); // Label color
                   
}

void draw() {
if(isSewer) {
  background (sewer);
  for (Word word : words) { 
    if (frameCount < frameCountLimit) {
      word.collide();
      word.move();
    } else {
      isSewer = false;
    }
    word.display();  
  }
  frameCount++;
  }
else {
  if ((mouseX > 150 && mouseX < 150 + 120 && mouseY > 710 && mouseY < 710 + 50) ||
          (mouseX > 600 && mouseX < 600 + 160 && mouseY > 490 && mouseY < 490 + 50)) {
          cursor(HAND);
  } else {
      cursor(ARROW);
  } 
    
  background(tiles);
  fill(0);
  //textSize(10);
  //text(text + "<-", 0, 20);
  textSize(textSize);
  noStroke();
  
  toilet(110, 350, 1);
  toilet(100, 340, int(map(i,0,140,0, 100)));
  
  
  
  faces();
    if (isRecording) {
      stopButton.show();
      recordButton.hide();
      speechBubble(170, 265, 480, 200, false);
      speechBubble(160, 255, 480, 200, false);
      speechBubble(170, 40, 390, 100, true);
      speechBubble(160, 30, 390, 100, true);
      textFont = createFont("Unifont", 30);
      textFont(textFont);
      fill(0);
      text("WHAT'S ON YOUR MIND?", 198, 78);
      fill(0);
      textFont = createFont("Unifont", 30);
      textFont(textFont);
      recordText(width - 355);
      displayText(188, 278);
      wordsPrinted = false;
      i = 0;
    } else  {
      stopButton.hide();
      recordButton.show();
      speechBubble(170, 40, 390, 100, true);
      speechBubble(160, 30, 390, 100, true);
      textFont = createFont("Unifont", 30);
      textFont(textFont);
      fill(0);
      if(isFlush) {
        text("DOWN THE TOILET!!!!", 198, 78);
        if(i == text.length()) {
          isRefill = true;
          isFlush = false;
        }
        translate(242, 505);
        //rotate(radians(i));
        println(text.length()-i);
        println(i);
        drawTextOnArc(text.substring(0,text.length()-i), 0,0, text.length()-i);
        translate(0,0);
        if (millis() - lastTime >= delayTime) {
          i++;
          lastTime = millis();  
        }
      } else if(isRefill) {
        text("NICE.", 198, 78);
        if (millis() - lastTime >= delayTime) {
          i--;
          lastTime = millis();  
        }
        if(i==0) {
          isSewer = true;
          isRefill = false;
          isRecording = true;
          text="";
        }
      }
      else {
        text("WHAT'S ON YOUR MIND?", 198, 78);
      }
      pushMatrix();
    
    
    popMatrix();
    translate(0,0);
    }
}
}

void record() {
  text = text.substring(0, textLength);
  isRecording = true;
  output = createWriter("text.txt"); 
  print(text.length());
}

void stop() {
  isRecording = false;
  textLength = text.length();
  if(textLength>0) {
    allWords += " "+text;
    initBounce();
    isFlush = true;
    flushSound();
    for(int i = textLength; i<=140-textLength; i++) {text+=" ";}
  }
  print(text.length());
}

void flush() {
  stop();
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

void toilet(int x, int y, int i) {
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

  //bowl
  fill(253);
  rect(169, 380, 200, 240);

  // Water in bowl
  fill(126, 174, 247);
  rect(169+i, 380+i, 200-2*i, 240-2*i);    // Water fill

  // Hole in bowl (under water)
     fill(0, 0, 0, 77);
  rect(230, 440, 80, 120);     
  fill(0, 0, 0, 101);
  rect(245, 455, 50, 90);      
  

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
  float charSize = 100 * radius / 360;
  textSize(charSize);
  int len = text.length();
  
  // Calculate the total arc angle based on the length of the text
  float arcLength = len * charSize * 0.7;      // Approximate total text length
  float arcAngle = arcLength / radius;   // Calculate angle span for arc
  
  float startAngle = -arcAngle;      // Start angle to center text on the arc

  // Loop through each character in the string
  for (int i = 0; i < len; i++) {
    float angle = startAngle + map(i, 0, len, 0, arcAngle);  // Angle for each character
    
    // Calculate the x, y position on the arc for each character
    float x = centerX + cos(angle) * (radius-i*0.6);
    float y = centerY + sin(angle) * (radius-i*0.6);
    
    // Push matrix to rotate each character separately
    pushMatrix();
    translate(x, y);                     // Move to the character position
    rotate(angle + PI / 2);     // Rotate to align with arc direction
    textSize(charSize - (charSize/len) * i);
    text(text.charAt(i), 0, 0);          // Draw the character
    popMatrix();
  }
  }
}
