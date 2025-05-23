String text = "";
int cursorBlinkRate = 500;  // milliseconds
long lastBlinkTime = 0;
boolean showCursor = true;
boolean isBackspace = false;
PrintWriter output;
int millis;

void recordText() {
  if (isNewKey && text.length() < 144) {
    text += key;
    text = text.toUpperCase();
    isNewKey = false;
  }

  if (isBackspace && text.length() > 0) {
    text = text.substring(0, text.length() - 1);
    isBackspace = false;
  }

  if (textWidth(text) > width - 355 && text.length() < 144) {
    String breakChar = text.substring(text.length()-1, text.length());
    text = text.substring(0, text.length() - 1);
    text+="\n" + breakChar;
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
    keySound();
    millis = millis();
  } else {
    isNewKey = false;
  }
  if (keyCode == 8) {
    isNewKey = false;
    isBackspace = true;
  }
}
