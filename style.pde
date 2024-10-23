float textSize = 30;
float textX = random(10, width);
float textY = random(10, height);
float textWidth;
color textColor;
color invertedTextColor;
boolean hasShadow;
boolean hasBox;

String[] fontList;
PFont textFont;

float x1, y1, 
  x2, y2, 
  x3, y3, 
  x4, y4;

void getStyle() {
  hasShadow = (0 > random(-1,4)); 
  hasBox = (0 > random(-1,4));
  print(hasBox);
  textColor  = color(random(150, 255), random(150, 255), random(150, 255));
  invertedTextColor = color(255 - red(textColor), 255 - green(textColor), 255 - blue(textColor));
  textSize = random(10, height/4);
  textFont = createFont(fontList[int(random(fontList.length))], textSize);
  textFont(textFont);
  textWidth = textWidth(word);
  textX = random(0, width-textWidth);
  textY = random(textSize, height);
  getCurvePoints();
}

void getCurvePoints() {
  float curveWidth = textWidth*1.5;
  x1 = textX;
  x2 = textX + 0.10 * curveWidth ;
  x3 = textX + 0.75 * curveWidth;
  x4 = textX + random(0.5,2) * curveWidth;

  y1 = textY + 200 * random(-2,2);
  y2 = textY + 0;
  y3 = textY + 75 * random(-1,1);
  y4 = textY + 150 * random(-10,10);
}


void saveStyle() {

}

void drawShadow() {
  int z = 1;
  int i = 0;
  if(hasShadow && !hasBox) {
    z = -int(random(textSize));
    fill(0);
    while(i > z){
      textSize = textSize-1;
      textSize(textSize);
      fill(invertedTextColor);
      drawOutline();
      text(word, textX, textY);
      i--;
  } 
  textSize(textSize - i);
}
}

void drawOutline(String word, float x, float y) {
  int outlinesize = int(textSize*0.03);
  for (int i=-outlinesize; i<=outlinesize; i++) {
    for (int j = -outlinesize; j<=outlinesize; j++) {
      fill(invertedTextColor);
      text(word, x-i, y-j); 
  }
}
}

void drawOutline() {
  drawOutline(word, textX, textY);
}

void drawCurvedText() {
  char[] wordAsChars = (word).toCharArray();
  int charCount = wordAsChars.length;
  for (int i = 0; i < charCount; ++i) {
    float step1 = i * 1.0 / float(charCount);
    
    float x = curvePoint(x1, x2, x3, x4, step1);
    float y = curvePoint(y1, y2, y3, y4, step1);
    
    float tanx = curveTangent(x1, x2, x3, x4, step1);
    float tany = curveTangent(y1, y2, y3, y4, step1);
    
    float angle = atan2(tany, tanx);

    pushMatrix();
    translate(x, y);
    rotate(angle);
    drawOutline(""+wordAsChars[i], 0, 0);
    fill(textColor);
    text(wordAsChars[i], 0.0, 0.0);
    popMatrix();
  }
}

void drawBox() {
  if(hasBox && !hasShadow) {
      strokeWeight(0.05*textSize);
      stroke(textColor);
      fill(invertedTextColor);
      rect(textX-textWidth*0.05, textY-textSize*0.95, textWidth*1.1, textSize*1.1);
    }
}
