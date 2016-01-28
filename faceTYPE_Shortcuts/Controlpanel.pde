// Class for the Dropdown Menu to calibrate, and for the clar text button
float n;
int myColorBackground;
class Controlpanel{
  ControlP5 cp5;
  ControlFont font = new ControlFont(regular, 241);
  int sliderValue = 100;
  Controlpanel(ControlP5 cp5){
    this.cp5 = cp5;
    
    this.cp5.setFont(font);
    this.cp5.getFont()
    .setSize(16)
    ;
    
    this.cp5.setColorCaptionLabel(color(0));
    this.cp5.setColorBackground(color(255));
    this.cp5.setColorActive(color(200));
    this.cp5.setColorForeground(color(240));
    
  this.cp5.addButton("buttonG")
     .setPosition((width/5)*3-85,(height/4)*3 + height/6+10)
     .setSize(100,40)
     .setValue(250)
     .setLabel("FINISH")
     ;   
  this.cp5.addButton("buttonF")
     .setPosition((width/5)*4-85,(height/4)*3 + height/6+10)
     .setSize(160,40)
     .setValue(250)
     .setLabel("CLEAR TEXTFIELD")
     ;
  }

}

  void controlEvent(ControlEvent theControlEvent) {

  if (theControlEvent.isTab()) {
  }
}

void buttonF() {
     input.clear();
}
void buttonG() {
  
     save("screenshot.png");
     saveStrings("timesmeasured.txt",times);
}