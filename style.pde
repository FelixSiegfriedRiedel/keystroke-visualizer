float textSize = random(50, 100);
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
