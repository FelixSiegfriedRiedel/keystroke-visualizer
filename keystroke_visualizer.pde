int isShadow = 0;
int randomSeed;
boolean isRecording = false;
boolean wordsPrinted = false;

import controlP5.*;

ControlP5 cp5;
Button recordButton;
Button stopButton;

void setup() {
  size(800, 800);
  background(255);
  textMode(SHAPE);
  fontList = PFont.list();
  textFont = createFont("Unifont", textSize);
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
  if (isRecording) {
    recordButton.hide();
    stopButton.show();
    background(255);
    fill(0);
    textFont = createFont("Unifont", 30);
    textFont(textFont);
    recordText();
    displayText();
    wordsPrinted = false;
  } else {
    stopButton.hide();
    recordButton.show();
    if (!wordsPrinted) {
      background(255);
      String[] lines = loadStrings("text.txt");
      delay(200);
      randomSeed(int(lines[0]));
      print(lines[1]);
      for (int i = 1; i < lines.length; i++) {
        for (String line : lines[i].split(" ")) {
          word = line.replace("\n", "");
          if (word.length() > 0) {
            getStyle();
            getVoice(word);
            if (0 > random(-2, 1)) {
              drawBox();
              drawShadow();
              drawOutline();
              fill(textColor);
              text(word, textX, textY); 
            } else {
              fill(textColor);
              drawCurvedText();
            }
          }
        }
      }
      wordsPrinted = true; 
    }
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
