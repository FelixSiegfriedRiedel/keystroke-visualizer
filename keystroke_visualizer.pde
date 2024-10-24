int isShadow = 0;
int randomSeed;
boolean isRecording = true;
boolean wordsPrinted = true;
int i;
String[] words;

import controlP5.*;

ControlP5 cp5;
Button recordButton;
Button stopButton;

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
                    .setPosition(width - 100, 0)
                    .setSize(100, 50);

  stopButton = cp5.addButton("stop")
                   .setValue(0)
                   .setPosition(width - 100, 0)
                   .setSize(100, 50)
                   .hide(); // Hide stop button initially
}

void draw() {
background(255);
noStroke();

toilet(86, 340);

speechBubble(170, 40, 390, 100, true);
speechBubble(160, 30, 390, 100, true);

if(isRecording) {
speechBubble(170, 265, 480, 200, false);
speechBubble(160, 255, 480, 200, false);
}


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
rect(611, 500, 160, 50);
fill(242, 201, 239);
rect(602, 490, 160, 50);
fill(3);
textFont = createFont("Unifont", 40);
textFont(textFont);
text("(ಥ﹏ಥ)", 599, 528);

textFont = createFont("Unifont", 30);
textFont(textFont);
text("WHICH THOUGHTS\nBOTHER YOU TODAY?", 198, 78);

  if (isRecording) {
    recordButton.hide();
    stopButton.show();
    fill(0);
    textFont = createFont("Unifont", 30);
    textFont(textFont);
    recordText(width - 355);
    displayText(300, 366);
    wordsPrinted = false;
    i = 0;
  } else if (!wordsPrinted) {
    stopButton.hide();
    recordButton.show();
    word = words[i].replace("\n", "");
    if (word.length() > 0) {
      getStyle();
      getVoice(word);
      drawBox();
      drawShadow();
      drawOutline();
      fill(textColor);
      text(word, textX, textY); 
    } 
    i++;
    delay(200);
    if(i == words.length) {
      wordsPrinted = true; 
    }
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
  rect(120, 680, 350, 120);  // Base
  rect(140, 590, 310, 90);   // Tank
  rect(120, 360, 350, 300);  // Back
  rect(130, 350, 330, 50);   // Rim
  rect(140, 340, 310, 50);   // Rim

  // Outer color (porcelain)
  fill(253);
  rect(130, 690, 330, 100);  // Base fill
  rect(150, 350, 290, 330);   // Tank fill
  rect(130, 370, 330, 280);   // Back fill
  rect(140, 360, 310, 50);    // Rim fill

  // Inner outline (bowl)
  fill(0);
  rect(170, 370, 250, 260);   // Bowl outline
  rect(160, 380, 270, 241);    // Inner bowl outline

  // Water in bowl
  fill(141, 181, 255);
  rect(170, 380, 250, 240);    // Water fill

  // Hole in bowl (under water)
  fill(0, 0, 0, 53);
  rect(260, 480, 70, 110);      // Hole

  // Outline toilet button
  fill(0);
  rect(150, 710, 170, 50);      // Button outline

  // Filling toilet button
  fill(252);
  rect(160, 720, 150, 30);      // Button fill

  popMatrix();
}
