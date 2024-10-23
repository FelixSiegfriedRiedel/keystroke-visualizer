PImage canvas;
int isShadow = 0;



void setup() {
  size(800, 800);
  background(255);
  textMode(SHAPE);
  fontList = PFont.list();
  textFont = createFont("Unifont", textSize);
  textFont(textFont);
  canvas = get(0,0, width, height);
}


void draw() {
  background(255);
  fill(0);
  recordText();
  displayText();
}
