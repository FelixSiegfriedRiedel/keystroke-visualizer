String text = "";
int cursorBlinkRate = 500;  // milliseconds
long lastBlinkTime = 0;
boolean showCursor = true;
boolean isBackspace = false;
PrintWriter output;

void recordText() {
  if (isNewKey) {
    text += key;
    isNewKey = false;
  }

  if (isBackspace && text.length() > 0) {
    text = text.substring(0, text.length() - 1);
    isBackspace = false;
  }

  if (textWidth(text) > width - 20) {
    text = text.substring(0, text.length() - 1);
    text+="\n";
  }
  
}

void displayText() {
  if (millis() - lastBlinkTime > cursorBlinkRate) {
    showCursor = !showCursor;
    lastBlinkTime = millis();
  }
  if (showCursor) {
     fill(0);
     text(text+"✍", 10, textAscent() + textDescent());
  } else {
    fill(0);
    text(text, 10, textAscent() + textDescent());
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
