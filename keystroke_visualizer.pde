char keyChar;
char lastKeyChar;
boolean isNewKey;

boolean isShadow = true;

float textSize = random(50, 100);
float textX = random(10, width);
float textY = random(10, height);
color textColor = color(random(255), random(255), color(255));

String[] fontList;
PFont textFont;

void setup() {
  size(800, 800);
  fontList = PFont.list();
  textFont = createFont(fontList[int(random(fontList.length))], textSize);
  textAlign(CENTER, CENTER);
}

void draw() {
  if (isNewKey) {
    if (keyChar != ' ') {
      textX += textWidth(lastKeyChar);
    } else {
      textX = random(10, width);
      textY = random(10, height);
      textSize = random(50, 100);
      textColor = color(random(255), random(255), color(255));
      textFont = createFont(fontList[int(random(fontList.length))], textSize);
      textFont(textFont);
      print(textFont);
    }
    fill(textColor);
    if(isShadow) {
      textSize(textSize * 1.5);
      fill(color(0,0,0));
      text(keyChar, textX, textY);
      textSize(textSize);
    }
    fill(textColor);
    text(keyChar, textX, textY); 
    lastKeyChar = keyChar;
    isNewKey = false;
  }
}

void getWord() {
  
}

void keyReleased() {
  if (key != CODED && key != '\n') { 
    keyChar = key;
    isNewKey = true;
  }
}
