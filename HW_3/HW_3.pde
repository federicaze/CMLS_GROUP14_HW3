import controlP5.*;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
ControlP5 cp5;

Knob amp, pan, modIndex, mod2Index;

Slider carFreq, carPart, modFreq, modPart, mod2Freq;

Textlabel ampLabel, panLabel, carFreqLabel, carPartLabel, modFreqLabel, modPartLabel, modIndexLabel, mod2FreqLabel, mod2IndexLabel;


void setup() {
  size(1650, 900);
  background(#0F655C);
  frameRate(100);
  
  noFill();
  stroke(255);
  strokeWeight(2);
  
  oscP5 = new OscP5(this,12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 57110);
  
  cp5 = new ControlP5(this);
  
  amp = cp5.addKnob("Amplitude Knob")
     .setLabel("")
     .setPosition(140, 100)
     .setRadius(120)
     .setHeight(150)
     .setRange(0, 1)
     .setValue(0.5)
     .setColorBackground(color(#E4A82E))
     .setColorForeground(color(#1C6587))
     .setColorActive(color(#2482AD))
     .setColorCaptionLabel(color(255));
     
  pan = cp5.addKnob("Panning Knob")
     .setLabel("")
     .setPosition(440, 100)
     .setRadius(120)
     .setHeight(150)
     .setRange(-1, 1)
     .setDecimalPrecision(1)
     .setValue(0)
     .setColorBackground(color(#E4A82E))
     .setColorForeground(color(#1C6587))
     .setColorActive(color(#2482AD))
     .setColorCaptionLabel(color(255));
     
  carFreq = cp5.addSlider("Carrier Frequency Slider")
     .setLabel("")
     .setLabel("")
     .setSliderMode(Slider.FLEXIBLE)
     .setPosition(150, 430)
     .setSize(65, 350)
     .setRange(0,3000)
     .setValue(1000)
     .setHandleSize(15)
     .setColorBackground(color(#5E1724))
     .setColorForeground(color(#7690D5))
     .setColorActive(color(#8AA5EA));
     
  carPart = cp5.addSlider("Carrier Partials Slider")
     .setLabel("")
     .setSliderMode(Slider.FLEXIBLE)
     .setPosition(300, 430)
     .setSize(65, 350)
     .setRange(1,8)
     .setDecimalPrecision(0)
     .setValue(1)
     .setHandleSize(15)
     .setColorBackground(color(#5E1724))
     .setColorForeground(color(#7690D5))
     .setColorActive(color(#8AA5EA));    
     
  modFreq = cp5.addSlider("Modulator Frequency Slider")
     .setLabel("")
     .setSliderMode(Slider.FLEXIBLE)
     .setPosition(450, 430)
     .setSize(65, 350)
     .setRange(0, 3000)
     .setValue(0)
     .setHandleSize(15)
     .setColorBackground(color(#5E1724))
     .setColorForeground(color(#7690D5))
     .setColorActive(color(#8AA5EA));     
     
  modPart = cp5.addSlider("Modulator Partials Slider")
     .setLabel("")
     .setSliderMode(Slider.FLEXIBLE)
     .setPosition(600, 430)
     .setSize(65, 350)
     .setRange(1, 8)
     .setDecimalPrecision(0)
     .setValue(200)
     .setHandleSize(15)
     .setColorBackground(color(#5E1724))
     .setColorForeground(color(#7690D5))
     .setColorActive(color(#8AA5EA));
     
  mod2Freq = cp5.addSlider("Second Modulator Frequency Slider")
     .setLabel("")
     .setSliderMode(Slider.FLEXIBLE)
     .setPosition(750, 430)
     .setSize(65, 350)
     .setRange(0, 3000)
     .setValue(1)
     .setHandleSize(15)
     .setColorBackground(color(#5E1724))
     .setColorForeground(color(#7690D5))
     .setColorActive(color(#8AA5EA));
     
  modIndex = cp5.addKnob("Modulator Index Knob")
     .setLabel("")
     .setPosition(950, 500)
     .setRadius(100)
     .setHeight(150)
     .setRange(0, 10)
     .setDecimalPrecision(0)
     .setValue(0)
     .setColorBackground(color(#E8E8ED))
     .setColorForeground(color(#50B397))
     .setColorActive(color(#5EC5A8))
     .setColorCaptionLabel(color(0))
     .setColorValue(color(0));
          
  mod2Index = cp5.addKnob("Second Modulator Index Knob")
     .setLabel("")
     .setPosition(1250, 500)
     .setRadius(100)
     .setHeight(150)
     .setRange(0, 10)
     .setDecimalPrecision(0)
     .setValue(0)
     .setColorBackground(color(#E8E8ED))
     .setColorForeground(color(#50B397))
     .setColorActive(color(#5EC5A8))
     .setColorCaptionLabel(color(0))
     .setColorValue(color(0));
  
  ampLabel = cp5.addTextlabel("Amplitude Label")
     .setText("Amplitude")
     .setPosition(219, 345)
     .setColorValue(255)
     .setFont(createFont("Arial", 16));
     
  panLabel = cp5.addTextlabel("Panning Label")
     .setText("Panning")
     .setPosition(525, 345)
     .setColorValue(255)
     .setFont(createFont("Arial", 16));
  
  carFreqLabel = cp5.addTextlabel("Carrier Frequency Label")
     .setText("   Carrier\nFrequency")
     .setPosition(140, 785)
     .setColorValue(255)
     .setFont(createFont("Arial", 16));
     
  carPartLabel = cp5.addTextlabel("Carrier Partials Label")
     .setText("Carrier\nPartials")
     .setPosition(300, 785)
     .setColorValue(255)
     .setFont(createFont("Arial", 16));
     
  modFreqLabel = cp5.addTextlabel("Modulator Frequency Label")
     .setText("    First\nModulator\nFrequency")
     .setPosition(442, 785)
     .setColorValue(255)
     .setFont(createFont("Arial", 16));
     
  modPartLabel = cp5.addTextlabel("Modulator Partials Label")
     .setText("    First\nModulator\n  Partials")
     .setPosition(593, 785)
     .setColorValue(255)
     .setFont(createFont("Arial", 16));
     
     
  mod2FreqLabel = cp5.addTextlabel("Second Modulator Frequency Label")
     .setText("  Second\nModulator\nFrequency")
     .setPosition(742, 785)
     .setColorValue(255)
     .setFont(createFont("Arial", 16));
     
  modIndexLabel = cp5.addTextlabel("Modulator Index Label")
     .setText("First Modulator Index")
     .setPosition(972, 715)
     .setColorValue(255)
     .setFont(createFont("Arial", 16));
     
  mod2IndexLabel = cp5.addTextlabel("Second Modulator Index Label")
     .setText("Second Modulator Index")
     .setPosition(1262, 715)
     .setColorValue(255)
     .setFont(createFont("Arial", 16));
}



float t = 0;
float pcarfreq, pcarpart, pmodfreq, pmodpart,pmodindex, pmod2freq, pmod2index, pamp, ppan;

void draw() {
  background(#0F655C);
  
  line((6.5/12.0)*width, height/4, (10.0/12.0)*width, height/4);
  
  
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 11; j++) {
      line(140+(i*300), 437+(j*33.5), 145+(i*300), 437+(j*33.5));
    }
  }
  
  for (int i = 0; i < 2; i++) {
    for (int j = 0; j < 8; j++) {
      line(290+(i*300), 437+(j*48) , 295+(i*300), 437+(j*48));
    }
  }
  
  
  beginShape();
  
  for(float theta = 0; theta <= 2 * PI; theta += 0.01){
    float rad = r(
      theta,
      1.0 + 100.0 * pamp,                                               //a
      1.0 + 100.0 * pamp,                                               //b
      100.0 + (pcarfreq/10.0),                                          //m
      4,                                                                //n1
      0.05 * sin((50+(pmodfreq/60))*t) + 1 + pmodindex/10 + pmodpart/8,  //n2
      0.05 * cos((50+(pmod2freq/60))*t) + 1 + pmod2index               //n3
    );
    float x = (1.75/12.0)*width * ppan + (8.25/12.0)*width + rad * cos(theta) * 50;
    float y = height/4 + rad * sin(theta) * 50;
    vertex(x, y);
  }
  
  endShape();
  
  t += 0.001;
  
  
  carFreq.setValue(pcarfreq);
  carPart.setValue(pcarpart);
  modFreq.setValue(pmodfreq);
  modPart.setValue(pmodpart);
  modIndex.setValue(pmodindex);
  mod2Freq.setValue(pmod2freq);
  mod2Index.setValue(pmod2index);
  amp.setValue(pamp);
  pan.setValue(ppan);
}


float r(float theta, float a, float b, float m, float n1, float n2, float n3) {
 
 return pow(pow(abs(cos(m * theta / 4.0) / a), n2) + pow(abs(sin(m * theta / 4.0) / b), n3), -1.0 / n1);
 
}


void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  /*
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  print(" p1: "+theOscMessage.get(0).floatValue());
  print(" p2: "+theOscMessage.get(1).floatValue());
  print(" p3: "+theOscMessage.get(2).floatValue());
  print("\n");
  */
  
  pcarfreq = theOscMessage.get(0).floatValue();
  pcarpart = theOscMessage.get(1).floatValue();
  pmodfreq = theOscMessage.get(2).floatValue();
  pmodpart = theOscMessage.get(3).floatValue();
  pmodindex = theOscMessage.get(4).floatValue();
  pmod2freq = theOscMessage.get(5).floatValue();
  pmod2index = theOscMessage.get(6).floatValue();
  pamp = theOscMessage.get(7).floatValue();
  ppan = theOscMessage.get(8).floatValue();
}
