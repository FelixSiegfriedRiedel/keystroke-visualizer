char lastKeyChar;
char keyChar;
float textSize = random(50, 100);
float textX = random(10, width);
float textY = random(10, height);
color textColor = color(random(255), random(255), color(255));

void setup() {
  size(800, 800);
  
}

void draw() {
  if (keyChar != lastKeyChar) {
    if (keyChar != ' ') {
      textX += textWidth(lastKeyChar)*1.1;
    } else {
      textX = random(10, width);
      textY = random(10, height);
      textSize = random(50, 100);
      textColor = color(random(255), random(255), color(255));
    }
    textSize(textSize);
    text(keyChar, textX, textY); 
    lastKeyChar = keyChar;
    fill(textColor);
  }
}

void keyReleased() {
  if (key != CODED && key != '\n') { 
    keyChar = key;
  }
}
