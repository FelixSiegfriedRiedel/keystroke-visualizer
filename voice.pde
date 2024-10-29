import processing.sound.*;
SoundFile voice;
Reverb  reverb;
boolean isPlaying = true;
String randomLang;
BandPass bandPass;

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
