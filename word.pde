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
