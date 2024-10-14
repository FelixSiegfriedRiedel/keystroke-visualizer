char keyChar;
char lastKeyChar;
boolean isNewKey = false;
boolean isWord = false;

String word = "";

void getWord() {
  if(isNewKey) {
    word+= keyChar;
    isNewKey = false;
  }
  if(isWord) {
    print(word);
    print("\n");
  }
}



void keyReleased() {
  if (key != CODED && key != '\n' && key != ' ') { 
    keyChar = key;
    isNewKey = true;
  } else if ((key == ' ' || key == '\n') && word != "") {
    isNewKey = false;
    isWord = true;
  }
}
