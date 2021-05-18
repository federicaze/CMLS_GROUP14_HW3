import controlP5.*;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
ControlP5 cp5;

Knob carFreq;
Knob modFreq;
Knob modIndex;
Knob pan;

void setup() {
  size(1700, 900);
  background(#0F655C);
  frameRate(100);
  
  noFill();
  stroke(255);
  strokeWeight(2);
  
  oscP5 = new OscP5(this,12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 57110);
  
  cp5 = new ControlP5(this);
  
  carFreq = cp5.addKnob("Carrier Frequency")
     .setPosition(100, 100)
     .setRadius(150)
     .setRange(0, 1000)
     .setValue(500)
     .setColorValueLabel(0)
     .setColorForeground(color(#50B397))
     .setColorBackground(color(#E8E8ED))
     .setColorActive(color(#5EC5A8))
     .setColorCaptionLabel(color(255));
     
  modFreq = cp5.addKnob("Modulation Frequency")
     .setPosition(100, 500)
     .setRadius(150)
     .setRange(0, 1000)
     .setValue(500)
     .setColorForeground(color(#1C6587))
     .setColorBackground(color(#E4A82E))
     .setColorActive(color(#2482AD))
     .setColorCaptionLabel(color(255));
     
  modIndex = cp5.addKnob("Modulation Index")
     .setPosition(500, 100)
     .setRadius(150)
     .setRange(0, 1000)
     .setValue(500)
     .setColorForeground(color(#BAC2E9))
     .setColorBackground(color(#D16755))
     .setColorActive(color(#C5CCED))
     .setColorCaptionLabel(color(255));
     
  pan = cp5.addKnob("Panning")
     .setPosition(500, 500)
     .setRadius(150)
     .setRange(0, 1000)
     .setValue(500)
     .setColorForeground(color(#E6BC9E))
     .setColorBackground(color(#BF173D))
     .setColorActive(color(#FFDCC2))
     .setColorCaptionLabel(color(255));

}

float t = 0;
float p1, p2, p3, p4;

void draw() {
  background(#0F655C);
  
  //translate(0.75*width, height/2);
  
  
  beginShape();
  
  for(float theta = 0; theta <= 2 * PI; theta += 0.01){
    float rad = r(
      theta,
      5.0, //a
      5.0, //b
      20,//int(200 * (sin(t/50) + 1)), //m
      1, //n1
      0.01 * sin(t) + 1, //n2
      0.01 * cos(t) + 1  //n3
    );
    float x = 0.75*width+ rad * cos(theta) * 50;
    float y = height/2+ rad * sin(theta) * 50;
    vertex(x, y);
  }
  
  endShape();
  
  
  //carFreq.setValue(p1);
  //modFreq.setValue(p2);
  //modIndex.setValue(p3);
  //pan.setValue(p4);
  
  
  t += 0.1;
}


float r(float theta, float a, float b, float m, float n1, float n2, float n3) {
  
 return pow(pow(abs(cos(m * theta / 4.0) / a), n2) + pow(abs(sin(m * theta / 4.0) / b), n3), -1.0 / n1);
 
}


void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  print(" p1: "+theOscMessage.get(0).floatValue());
  print(" p2: "+theOscMessage.get(1).floatValue());
  print(" p3: "+theOscMessage.get(2).floatValue());
  
  p1 = theOscMessage.get(0).floatValue();
  p2 = theOscMessage.get(1).floatValue();
  p3 = theOscMessage.get(2).floatValue();
  p4 = theOscMessage.get(3).floatValue();
  
  print("\n");
}
