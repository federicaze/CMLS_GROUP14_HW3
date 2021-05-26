// LIBRARIES
import controlP5.*;
import oscP5.*;
import netP5.*;

// We declare the variables we need to set the connection between Supercollider and Processing
OscP5 oscP5;
NetAddress myRemoteLocation;
ControlP5 cp5;

// We declare the variables we need to draw the sliders and the knobs of the GUI
Knob amp, pan, modIndex, mod2Index;
Slider carFreq, carPart, modFreq, modPart, mod2Freq;
Textlabel ampLabel, panLabel, carFreqLabel, carPartLabel, modFreqLabel, modPartLabel, modIndexLabel, mod2FreqLabel, mod2IndexLabel;


void setup() {
  size(1650, 950);
  background(#0F655C);
  frameRate(100);
  
  
  // We enstablish the connection with Supercollider
  oscP5 = new OscP5(this,12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 57110);
  
  // We draw all the knobs and sliders with the correspondent labels
  cp5 = new ControlP5(this);
  
  amp = cp5.addKnob("Amplitude Knob")
     .setLabel("")
     .setPosition(100, 130)
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
     .setPosition(400, 130)
     .setRadius(120)
     .setHeight(150)
     .setRange(-1, 1)
     .setValue(0)
     .setColorBackground(color(#E4A82E))
     .setColorForeground(color(#1C6587))
     .setColorActive(color(#2482AD))
     .setColorCaptionLabel(color(255));
     
        
  modIndex = cp5.addKnob("Modulator Index Knob")
     .setLabel("")
     .setPosition(100, 540)
     .setRadius(120)
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
     .setPosition(400, 540)
     .setRadius(120)
     .setHeight(150)
     .setRange(0, 10)
     .setDecimalPrecision(0)
     .setValue(0)
     .setColorBackground(color(#E8E8ED))
     .setColorForeground(color(#50B397))
     .setColorActive(color(#5EC5A8))
     .setColorCaptionLabel(color(0))
     .setColorValue(color(0));
     
  carFreq = cp5.addSlider("Carrier Frequency Slider")
     .setLabel("")
     .setLabel("")
     .setSliderMode(Slider.FLEXIBLE)
     .setPosition(800, 500)
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
     .setPosition(950, 500)
     .setSize(65, 350)
     .setRange(1, 8)
     .setDecimalPrecision(0)
     .setValue(1)
     .setHandleSize(15)
     .setColorBackground(color(#5E1724))
     .setColorForeground(color(#7690D5))
     .setColorActive(color(#8AA5EA));    
     
  modFreq = cp5.addSlider("Modulator Frequency Slider")
     .setLabel("")
     .setSliderMode(Slider.FLEXIBLE)
     .setPosition(1100, 500)
     .setSize(65, 350)
     .setRange(0, 5000)
     .setValue(0)
     .setHandleSize(15)
     .setColorBackground(color(#5E1724))
     .setColorForeground(color(#7690D5))
     .setColorActive(color(#8AA5EA));     
     
  modPart = cp5.addSlider("Modulator Partials Slider")
     .setLabel("")
     .setSliderMode(Slider.FLEXIBLE)
     .setPosition(1250, 500)
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
     .setPosition(1400, 500)
     .setSize(65, 350)
     .setRange(0, 5000)
     .setValue(1)
     .setHandleSize(15)
     .setColorBackground(color(#5E1724))
     .setColorForeground(color(#7690D5))
     .setColorActive(color(#8AA5EA));
  
  
  ampLabel = cp5.addTextlabel("Amplitude Label")
     .setText("Amplitude")
     .setPosition(179, 375)
     .setColorValue(255)
     .setFont(createFont("Arial", 16));
     
  panLabel = cp5.addTextlabel("Panning Label")
     .setText("Panning")
     .setPosition(485, 375)
     .setColorValue(255)
     .setFont(createFont("Arial", 16));
     
  modIndexLabel = cp5.addTextlabel("Modulator Index Label")
     .setText("Mod 1 Index")
     .setPosition(173, 790)
     .setColorValue(255)
     .setFont(createFont("Arial", 16));
     
  mod2IndexLabel = cp5.addTextlabel("Second Modulator Index Label")
     .setText("Mod 2 Index")
     .setPosition(472, 790)
     .setColorValue(255)
     .setFont(createFont("Arial", 16));
  
  carFreqLabel = cp5.addTextlabel("Carrier Frequency Label")
     .setText("   Carrier\nFrequency")
     .setPosition(791, 855)
     .setColorValue(255)
     .setFont(createFont("Arial", 16));
     
  carPartLabel = cp5.addTextlabel("Carrier Partials Label")
     .setText("Carrier\nPartials")
     .setPosition(952, 855)
     .setColorValue(255)
     .setFont(createFont("Arial", 16));
     
  modFreqLabel = cp5.addTextlabel("Modulator Frequency Label")
     .setText("   Mod 1\nFrequency")
     .setPosition(1094, 855)
     .setColorValue(255)
     .setFont(createFont("Arial", 16));
     
  modPartLabel = cp5.addTextlabel("Modulator Partials Label")
     .setText("   Mod 1\n  Partials")
     .setPosition(1245, 855)
     .setColorValue(255)
     .setFont(createFont("Arial", 16));
     
     
  mod2FreqLabel = cp5.addTextlabel("Second Modulator Frequency Label")
     .setText("   Mod 2\nFrequency")
     .setPosition(1394, 855)
     .setColorValue(255)
     .setFont(createFont("Arial", 16));
     
}


// We declare and define a variable we need to draw the "wave interpreter"
float t = 0;

// We declare the variables that will store the values read from Supercollider
float pcarfreq, pcarpart, pmodfreq, pmodpart,pmodindex, pmod2freq, pmod2index, pamp, ppan;

void draw() {
  background(#0F655C);
  
  // We draw the ticks of the sliders
  stroke(255);
  
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 11; j++) {
      line(790+(i*300), 507+(j*33.5), 795+(i*300), 507+(j*33.5));
    }
  }
  for (int i = 0; i < 2; i++) {
    for (int j = 0; j < 8; j++) {
      line(940+(i*300), 507+(j*48) , 945+(i*300), 507+(j*48));
    }
  }
  
  
  // We create the screen where the "wave interpreter" will be placed
  strokeWeight(10);
  stroke(#ADB2B8, 200);
  fill(#000000);
  rect(700, 55, 875, 395, 7);
  
  
  // We draw the line in the middle of the screen on which the "wave interpreter" slides
  colorMode(HSB, 360);
  stroke(pcarfreq/30.00 + pmodfreq/38.47 + pmod2freq/38.47, 360, 360);
  strokeCap(SQUARE);
  strokeWeight(2);
  line((5.7/12.0)*width, height/3.8, (10.8/12.0)*width, height/3.8);
  
  
  // We draw the "wave interpreter" inside the screen using polar coordinates and the function r()
  strokeWeight(1.5);
  strokeCap(ROUND);
  beginShape();
  
  for(float theta = 0; theta <= 2 * PI; theta += 0.01){
    float rad = r(
      theta,
      0.5 + 20.0 * pamp,                                                                           //a
      0.5 + 20.0 * pamp,                                                                           //b
      100.0 + (pcarfreq/10.0),                                                                     //m
      4.0,                                                                                         //n1
      0.05 * sin((50.0+(pmodfreq/10.0))*t) + 1 + pmodindex/50.0 + pmodpart/40.0 + pmod2index/50.0, //n2
      0.05 * cos((50.0+(pmod2freq/10.0))*t) + 1                                                    //n3
    );
    float x = (1.75/12.0)*width * ppan + (8.25/12.0)*width + rad * cos(theta) * 50;
    float y = height/3.8 + rad * sin(theta) * 50;
    vertex(x, y);
  }
  
  endShape();
  colorMode(RGB, 255);
  
  t += 0.001;
  
  // We assign the values read from Supercollider to the correspondent sliders and knobs
  carFreq.setValue(pcarfreq);
  carPart.setValue(pcarpart);
  modFreq.setValue(pmodfreq);
  modIndex.setValue(pmodindex);
  modPart.setValue(pmodpart);
  mod2Freq.setValue(pmod2freq);
  mod2Index.setValue(pmod2index);
  amp.setValue(pamp);
  pan.setValue(ppan);
}


// The function that calculates the radius of the "wave interpreter" for each angle theta
float r(float theta, float a, float b, float m, float n1, float n2, float n3) {
 
 return pow(pow(abs(cos(m * theta / 4.0) / a), n2) + pow(abs(sin(m * theta / 4.0) / b), n3), -1.0 / n1);
 
}


// We use this function to read incoming messages from Supercollider
void oscEvent(OscMessage theOscMessage) {
  
  pcarfreq = theOscMessage.get(0).floatValue();
  pcarpart = theOscMessage.get(1).floatValue();
  pmodfreq = theOscMessage.get(2).floatValue();
  pmodindex = theOscMessage.get(3).floatValue();
  pmodpart = theOscMessage.get(4).floatValue();
  pmod2freq = theOscMessage.get(5).floatValue();
  pmod2index = theOscMessage.get(6).floatValue();
  pamp = theOscMessage.get(7).floatValue();
  ppan = theOscMessage.get(8).floatValue();
  
}
