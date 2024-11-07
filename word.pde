char keyChar;
char lastKeyChar;
boolean isNewKey = false;
boolean isWord = false;


String word = "";
int numWords;
float spring = 0.05;
float gravity = 0.1;
float friction = -0.9;
int frameCountLimit = 500;
int frameCount = 0;
Word[] words; 
String allWords = "";

void initBounce() {
  frameCount = 0;
  String[] wordsArray = split(allWords, " "); // Split the string into words
  numWords = wordsArray.length; // Get the number of words
  words = new Word[numWords]; // Initialize the class-level words array
  for (int i = 0; i < numWords; i++) { // Start from 0
    words[i] = new Word(random(width), random(height), wordsArray[i], i, words);
    print(wordsArray[i]);
  }
}

class Word {
  
  float x, y;
  float diameterX;
  float diameterY;
  float vx = 0;
  float vy = 0;
  int id;
  String text;
  Word[] others;
 
  Word(float xin, float yin, String textin, int idin, Word[] oin) {
    x = xin;
    y = yin;
    text = textin;
    diameterX = textWidth(textin);
    diameterY = textSize;
    id = idin;
    others = oin;
  } 
  
  void collide() {
    for (int j = 0; j < others.length; j++) { // Changed i to j to avoid conflicts
      if (j != id) { // Check all other words
          float dx = others[j].x - x;
          float dy = others[j].y - y;
          float distance = sqrt(dx * dx + dy * dy);
          float minDist = (others[j].diameterX + diameterX) / 2; // Using a single minimum distance check
          if (distance < minDist) { 
              float angle = atan2(dy, dx);
              float targetX = x + cos(angle) * minDist;
              float ax = (targetX - others[j].x) * spring;
              vx -= ax;
              others[j].vx += ax;

              float targetY = y + sin(angle) * minDist;
              float ay = (targetY - others[j].y) * spring;
              vy -= ay;
              others[j].vy += ay;
          }
      }
    }   
  }

  void move() {
      vy += gravity; // Gravity pulls down
      x += vx;
      y += vy;

      // Horizontal boundaries
      if (x + diameterX / 2 > width) {
          x = width - diameterX / 2;
          vx *= friction; 
      } else if (x - diameterX / 2 < 0) {
          x = diameterX / 2;
          vx *= friction;
      }

      // Vertical boundaries
      if (y + diameterY / 2 > height) {
          y = height - diameterY / 2; // Reset to just above the bottom
          vy *= friction; // Keep some bounce effect
          if (abs(vy) < 0.1) vy = 0; // Stop very slow downward movement
      } else if (y - diameterY / 2 < 0) {
          y = diameterY / 2;
          vy *= friction;
      }
  }

  void display() {
      fill(255);
      text(text, x, y); 
  }
}
