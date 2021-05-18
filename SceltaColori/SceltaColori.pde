import controlP5.*;

ControlP5 cp5;

Knob knob1;
Knob knob2;
Knob knob3;
Knob knob4;
Knob knob5;
Knob knob6;
Knob knob7;
Knob knob8;

void setup() {
  size(1700, 900);
  background(255);
  frameRate(100);
  
  
  cp5 = new ControlP5(this);
  
  knob1 = cp5.addKnob("1")
     .setPosition(100, 100)
     .setRadius(150)
     .setRange(0, 1000)
     .setValue(500)
     .setColorForeground(color(#DD822C))
     .setColorBackground(color(#941B0C))
     .setColorActive(color(#EB9C0A))
     .setColorCaptionLabel(color(20,20,20));
     
  knob2 = cp5.addKnob("2")
     .setPosition(100, 500)
     .setRadius(150)
     .setRange(0, 1000)
     .setValue(500)
     .setColorForeground(color(#322D8B))
     .setColorBackground(color(#8C92E3))
     .setColorActive(color(#4B2EB2))
     .setColorCaptionLabel(color(20,20,20));
     
  knob3 = cp5.addKnob("3")
     .setPosition(500, 100)
     .setRadius(150)
     .setRange(0, 1000)
     .setValue(500)
     .setColorForeground(color(#DE5A37))
     .setColorBackground(color(#4B4378))
     .setColorActive(color(#FFB05B))
     .setColorCaptionLabel(color(20,20,20));
     
  knob4 = cp5.addKnob("4")
     .setPosition(500, 500)
     .setRadius(150)
     .setRange(0, 1000)
     .setValue(500)
     .setColorForeground(color(#95D5B2))
     .setColorBackground(color(#29664D))
     .setColorActive(color(#B7E1CD))
     .setColorCaptionLabel(color(20,20,20));
     
  knob5 = cp5.addKnob("5")
     .setPosition(900, 100)
     .setRadius(150)
     .setRange(0, 1000)
     .setValue(500)
     .setColorForeground(color(#B8C7F4))
     .setColorBackground(color(#5D005D))
     .setColorActive(color(#E7F4F0))
     .setColorCaptionLabel(color(20,20,20));
     
  knob6 = cp5.addKnob("6")
     .setPosition(900, 500)
     .setRadius(150)
     .setRange(0, 1000)
     .setValue(500)
     .setColorForeground(color(#FFC60A))
     .setColorBackground(color(#0054A3))
     .setColorActive(color(#FFDA1F))
     .setColorCaptionLabel(color(20,20,20));
     
  knob7 = cp5.addKnob("7")
     .setPosition(1300, 100)
     .setRadius(150)
     .setRange(0, 1000)
     .setValue(500)
     .setColorForeground(color(#9E6240))
     .setColorBackground(color(#A7DCD2))
     .setColorActive(color(#A78062))
     .setColorCaptionLabel(color(20,20,20));
     
  knob8 = cp5.addKnob("8")
     .setPosition(1300, 500)
     .setRadius(150)
     .setRange(0, 1000)
     .setValue(500)
     .setColorForeground(color(#A7AFAF))
     .setColorBackground(color(#000000))
     .setColorActive(color(#C6C2C7))
     .setColorCaptionLabel(color(20,20,20));
}


void draw() {
  background(255);
}
