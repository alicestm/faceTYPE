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
    
    
    
      List l = Arrays.asList("mouth", "eyebrow", "orientation", "home");
  /* add a ScrollableList, by default it behaves like a DropdownList */
      this.cp5.addScrollableList("calibration")
     .setPosition((width/7)*6, 20)
     .setSize(130, 200)
     .setBarHeight(30)
     .setItemHeight(21)
     .addItems(l)
     .setOpen(false) 
     .setColorBackground(color(253,239,203))
     .setColorForeground(color(255))
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
  if(mode=="normal"){
     input.clear();
  }
  else{
   calibInput.clear(); 
  }
 // println("a slider event. setting background to "+theColor);
}

void calibration(int n){
   if (n == 0){
     mode = "mouth";
   }
   if (n == 1){
     mode = "eyebrow";
   }
   if (n == 2){
     mode = "orientationR";
   }
   if (n == 3){
     mode = "normal";
     calibInput.clear();
   }
}