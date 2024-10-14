PImage canvas;
int isShadow = 0;

void setup() {
  size(800, 800);
  background(255);
  textMode(SHAPE);
  fontList = PFont.list();
  textFont = createFont(fontList[int(random(fontList.length))], textSize);
  canvas = get(0,0, width, height);
  


}

void draw() {
  delay(200);
  //getWord();
  word = "yetzt";
  isWord = true;
  if(isWord) {
    getStyle();
    getVoice(word);
    if(0 > random(-2,1)) {
      drawBox();
      drawShadow();
      drawOutline();
      fill(textColor);
      text(word, textX, textY); 
    } else {
      fill(textColor);
      drawCurvedText();
    }
    word = ""; 
    isWord = false;
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
