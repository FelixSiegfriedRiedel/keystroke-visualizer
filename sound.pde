
SoundFile voice, toiletFlush, ambience;
Reverb  reverb;
boolean isPlaying = true;
String randomLang;
BandPass bandPass;

TriOsc triOsc;
Env env;

float attackTime = 0.001;
float sustainTime = 0.004;
float sustainLevel = 0.3;
float releaseTime = 0.4;

import processing.sound.*;

void initSound() {
  toiletFlush = new SoundFile(this, "sound/flush_short.mp3");
  toiletFlush.amp(0.1);
  ambience = new SoundFile(this, "sound/ambience.mp3");
  ambience.loop();
  ambience.amp(3);
  
  triOsc = new TriOsc(this);
  env  = new Env(this); 
    
}

void getVoice(String word) {
String[] languages = {"en", "en-US", "en-GB", "en-AU", "en-CA", "en-IN", "en-NZ", "en-ZA"}; // Add any desired language codes
randomLang = languages[int(random(languages.length))]; // Select a random language
voice = new SoundFile(this, "http://" + "translate.google.com/translate_tts?tl=" + randomLang + "&q=" + word + "%E2%80%9D&client=tw-ob");

reverb = new Reverb(this);
bandPass = new BandPass(this);

// Start playing the file
voice.play();
reverb.process(voice);
reverb.room(random(0,1));
reverb.damp(random(0,1));

  
}

void flushSound() {
  toiletFlush.play();
    toiletFlush.amp(0.5);
}


void keySound() {
  triOsc.play();
  triOsc.freq(random(100,500));
  env.play(triOsc, attackTime, sustainTime, sustainLevel, releaseTime);
}
