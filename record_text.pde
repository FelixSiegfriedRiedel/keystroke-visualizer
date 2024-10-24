String text = "";
int cursorBlinkRate = 500;  // milliseconds
long lastBlinkTime = 0;
boolean showCursor = true;
boolean isBackspace = false;
PrintWriter output;

void recordText(float w) {
  if (isNewKey) {
    text += key;
    isNewKey = false;
  }

  if (isBackspace && text.length() > 0) {
    text = text.substring(0, text.length() - 1);
    isBackspace = false;
  }

  if (textWidth(text) > w - 20) {
    text = text.substring(0, text.length() - 1);
    text+="\n";
  }
  
}

void displayText(int x, int y) {
  if (millis() - lastBlinkTime > cursorBlinkRate) {
    showCursor = !showCursor;
    lastBlinkTime = millis();
  }
  if (showCursor) {
     fill(0);
     text(text+"✍", x, y+textAscent() + textDescent());
  } else {
    fill(0);
    text(text, x, y+textAscent() + textDescent());
  }
}



void keyPressed() {
  if (key != CODED) { 
    isNewKey = true;
  } else {
    isNewKey = false;
  }
  if (keyCode == 8) {
    isNewKey = false;
    isBackspace = true;
  }
  if (keyCode == ESC) {
    
  }
}
