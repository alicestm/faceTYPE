// Press the Arraw Key UP to start teime-measuring, and the ey DOWN to stop measuring. press "finish" to save the current screen and the times measured.
import controlP5.*; 
import oscP5.*;
import java.util.*;


//Buttons for Calibration modes and Home mode
ControlP5 cp5;
Controlpanel c;


// Cockpit which shows the current Face, if its detected or not, and the current format.
Cockpit cockpit;
  

boolean detect = true;

//Text editor
Textfield input; 
PFont regular, bold, underlined, italic, underlinedAndBold, underlinedAndItalic, boldAndItalic,all; 


// Time measured
String[]times = {"times: "};
int start,time;
boolean shift = false;
boolean control = false;
boolean b = false;
boolean i = false;
boolean u = false;
String formatValue="regular";

void setup(){
  size(1000 ,800);
  frameRate(30);

   all= loadFont("AlleFonts-32.vlw");
   regular = loadFont("JosefinSansRegular-32.vlw");
   underlined= loadFont("Aliceunderlined-underlined-32.vlw"); 
   bold= loadFont("JosefinSans-Bold-32.vlw"); 
   italic= loadFont("JosefinSans-LightItalic-32.vlw");
   underlinedAndBold= loadFont("Aliceboldunderlined-Aliceboldunderlined-32.vlw"); 
   underlinedAndItalic= loadFont("Aliceitalicunderlined-Aliceitalicunderlined-32.vlw"); 
   boldAndItalic= loadFont("JosefinSans-BoldItalic-32.vlw");
   

  cockpit = new Cockpit();
  input = new Textfield();
  input.setFont("regular");
  cp5 =new ControlP5(this);
  c = new Controlpanel(cp5);
  
}

void draw(){
 background(253,239,203);
  
 input.updateanddraw();

 cockpit.updateanddraw();

 cockpit.drawFormat(formatValue);
 
}

void keyPressed() { 
  //check the current mode and add the current Input either to the inputtext or to the calibrationtext
  Textfield temp;
   temp = input; 
    temp.source += key;
    temp.fonts.add(temp.currentfont);
  
  if (key == CODED){
   if (keyCode == CONTROL){
      control = true;
     }
    }
  if (key == CODED){
       if(keyCode == SHIFT){
      shift = true;
    }
  }
 if (keyCode == 66){
  b=true; 
 }
  if (keyCode == 73){
  i=true; 
 }
  if (keyCode == 85){
  u=true; 
 }
    
 if (shift && control && i){
      input.setFont("italic");
      formatValue="italic";
    }
 if (u && shift && control){
      input.setFont("underlined");
      formatValue="underlined";    }
  if (b && shift && control){
      input.setFont("bold");
      formatValue="bold";
    }
    
   
  
  if(detect && key != ' '){
      detect = false;
    }   
  if (key == ' '){
     detect = true; 
     control = false;
     shift = false;
     i=false;
     b=false;
     u=false;
     input.setFont("regular");
     formatValue="regular";
    }
    
  if (key == CODED){
    if(keyCode == UP){
      println("KEY UP");
      start = millis();
    }
    if(keyCode == DOWN){
      println("key DOWN");
      time = millis() - start;
      times = append(times,str(time));
      
    }
  }
   
}

void keyReleased(){
 if (key == CODED){
  if (keyCode == CONTROL){
   control = false; 
  }
 }
  if (key == CODED){
  if (keyCode == SHIFT){
   shift = false; 
  }
 }

}