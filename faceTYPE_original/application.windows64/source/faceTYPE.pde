import controlP5.*; 
import oscP5.*;
import java.util.*;


//Buttons for Calibration modes and Home mode
ControlP5 cp5;
Controlpanel c;


//Face detection components
OscP5 oscP5;
DetectionMaster master;

// Cockpit which shows the current Face, if its detected or not, and the current format.
Cockpit cockpit;
  
//Buttons
// face Detection 
PVector posePosition;
PVector poseOrientation;

boolean found;
float eyeLeftHeight;
float eyeRightHeight;
float mouthHeight;
float mouthWidth;
float nostrilHeight;
float leftEyebrowHeight;
float rightEyebrowHeight;

float mouthValue = 10.5;
float zValue= -0.1;
float browVal = 8.5;
float eyeVal = 3.0;

float poseScale;
//Face Detection

boolean detect = true;

//Text editor
Textfield input, calibInput; 
PFont regular, bold, underlined, italic, underlinedAndBold, underlinedAndItalic, boldAndItalic,all; 

//Text editor
String mode = "normal";

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
  calibInput = new Textfield();
  calibInput.setFont("regular");
  cp5 =new ControlP5(this);
  c = new Controlpanel(cp5);
  
  //Face Detection specific stuff
  posePosition = new PVector();
  poseOrientation = new PVector();
  
  oscP5 = new OscP5(this, 8338);
  master = new DetectionMaster(oscP5);
  
}

void draw(){
 background(253,239,203);
  
  if (mode == "mouth"){
         background(253,239,203);

    calibInput.updateanddraw();
    textFont(regular);
     cockpit.drawMessage("squeeze your lips and press Strg");

  }
  if (mode == "eyebrow"){
        background(253,239,203);

    calibInput.updateanddraw();
    textFont(regular);
    cockpit.drawMessage("eyebrows up and STRG; eyes looking straight and ALT");
  }
  if(mode == "orientationR"){
    background(253,239,203);

    calibInput.updateanddraw();
    textFont(regular);
    cockpit.drawMessage("raise your head to the right and press Strg");
  }
  if(mode == "orientationL"){  
    calibInput.updateanddraw();
  }
  else if (mode == "normal"){
    background(253,239,203);
    input.updateanddraw();
  }
    master.updateanddraw();
    cockpit.updateanddraw();
}

void keyPressed() { 
  //check the current mode and add the current Input either to the inputtext or to the calibrationtext
  Textfield temp;
  if(mode == "normal"){
   temp = input; 
  }
  else{
    temp = calibInput;
  }
  //delete the words
  if(key==BACKSPACE) {
    if(temp.source.length()>0) {
      temp.source = temp.source.substring(0,temp.source.length()-1);
      temp.fonts.remove(temp.fonts.size()-1);
    }
  } 
  else {
    temp.source += key;
    temp.fonts.add(temp.currentfont);
  }
  
  if(mode == "mouth" && key==CODED) {
    if(keyCode == CONTROL){
      mouthValue = mouthWidth;
      }
    }
  if(mode == "orientationR" && key==CODED) {
  if(keyCode == CONTROL){
      zValue = poseOrientation.z;
      }
    }
    
  if(mode == "eyebrow" && key==CODED) {
    if(keyCode == CONTROL){
      browVal = rightEyebrowHeight;
      }
    if(keyCode == ALT){
      eyeVal = eyeRightHeight;
      }
    }
    
  if(detect && key != ' '){
      detect = false;
    }   
  if (key == ' '){
     detect = true; 
    }
   
}