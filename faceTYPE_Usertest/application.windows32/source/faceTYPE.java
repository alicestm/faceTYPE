import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 
import oscP5.*; 
import java.util.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class faceTYPE extends PApplet {

 




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

float mouthValue = 10.5f;
float zValue= -0.1f;
float browVal = 8.5f;
float eyeVal = 3.0f;

float poseScale;
//Face Detection

boolean detect = true;

//Text editor
Textfield input, calibInput; 
PFont regular, bold, underlined, italic, underlinedAndBold, underlinedAndItalic, boldAndItalic,all; 

//Text editor
String mode = "normal";

public void setup(){
  
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

public void draw(){
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

public void keyPressed() { 
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
class Cockpit{
     PImage img = loadImage("logo_facetype.png");
 Cockpit(){
   
 }
 public void updateanddraw(){
   
   //draw the Logo
   image(img, width/8, 40);

 }
 // draws the three circles with their color, depending on which formats are currently activated
 public void drawFormat(String format){
   pushMatrix();
     translate((width/2-80), 90);
     int color1 = color(255);
     int color2 = color(255);
     int color3 = color(255);
     //textFont(italic);
     textAlign(CENTER);
     //text(format,60,60);
     if (format == "italic"){

       color1 = color(125,167,217);
       color2 = color(255);
       color3 = color(255);
       textFont(italic);       
     }
       else if (format == "underlined"){

       color3 = color(189,140,191);
       color2 = color(255);
       color1 = color(255);
       textFont(underlined);

     }
     else if (format == "bold"){

       color2 = color(130,202,156);
       color1 = color(255);
       color3 = color(255);
       textFont(bold);

     }
     else if (format == "underlinedAndBold"){

       color2 = color(130,202,156);
       color1 = color(255);
       color3 = color(189,140,191);
       textFont(underlinedAndBold);

     }
     else if (format == "underlinedAndItalic"){

       color2 = color(255);
       color1 = color(125,167,217);
       color3 = color(189,140,191);
       textFont(underlinedAndItalic);

     }
     else if (format == "boldAndItalic"){

       color2 = color(130,202,156);
       color1 = color(125,167,217);
       color3 = color(255);
       textFont(boldAndItalic);

     }
     else if (format == "all"){

       color2 = color(130,202,156);
       color1 = color(125,167,217);
       color3 = color(189,140,191);
       textFont(all);

     }
     else{
       textFont(regular);

     }
     
     
     fill(color2);
     ellipse(0,0,80,80);
     fill(0);
     textFont(bold);
     text("B", 2,12,32);
     
     fill(color1);
     ellipse(90,0,80,80);
     fill(0);
     textFont(italic);
     text("I", 91,12,32);
     
     fill(color3);
     ellipse(180,0,80,80);
     fill(0);
     textFont(underlined);
     text("U", 180,10,32);
     textAlign(LEFT);
     popMatrix();
 }
 
 public void drawMessage(String message){
   pushMatrix();
   translate(width/4+50,40);
   textSize(24);
   text(message,0,0);
   popMatrix();
 }
}
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

  public void controlEvent(ControlEvent theControlEvent) {

  if (theControlEvent.isTab()) {
  }
}

public void buttonF() {
  if(mode=="normal"){
     input.clear();
  }
  else{
   calibInput.clear(); 
  }
 // println("a slider event. setting background to "+theColor);
}

public void calibration(int n){
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
class DetectionMaster{
  OscP5 oscP5;
  MouthDetect mouth;
  EyebrowDetect eye;
  OrientationDetect orientation;
  MouthAndOrientationDetect mouthorientation;
  MouthAndEyebrowDetect moutheye;
  EyebrowAndOrientationDetect eyeorientation; 
  AllDetected all;
 // boolean found;
 // boolean detect = true;
  DetectionMaster(OscP5 oscP5){
  this.oscP5 = oscP5;
  this.oscP5.plug(this, "mouthWidthReceived", "/gesture/mouth/width");
  this.oscP5.plug(this, "mouthHeightReceived", "/gesture/mouth/height");
  this.oscP5.plug(this, "eyebrowLeftReceived", "/gesture/eyebrow/left");
  this.oscP5.plug(this, "eyebrowRightReceived", "/gesture/eyebrow/right");
  this.oscP5.plug(this, "eyeLeftReceived", "/gesture/eye/left");
  this.oscP5.plug(this, "eyeRightReceived", "/gesture/eye/right");
  this.oscP5.plug(this, "jawReceived", "/gesture/jaw");
  this.oscP5.plug(this, "nostrilsReceived", "/gesture/nostrils");
  this.oscP5.plug(this, "found", "/found");
  this.oscP5.plug(this, "poseOrientation", "/pose/orientation");
  this.oscP5.plug(this, "posePosition", "/pose/position");
  this.oscP5.plug(this, "poseScale", "/pose/scale");
  

 }
     public void mouthWidthReceived(float w) {
     // println("mouth width: " + w); 
      mouthWidth = w;
    }
    
    public void mouthHeightReceived(float h) {
      //println("mouth height: " + h);
      mouthHeight = h;
    }
    
    public void eyebrowLeftReceived(float h) {
     // println("eyebrow left: " + h);
      leftEyebrowHeight = h;
    }
    
    public void eyebrowRightReceived(float h) {
    // println("eyebrow right: " + h);
      rightEyebrowHeight = h;
    }
    
    public void eyeLeftReceived(float h) {
      //println("eye left: " + h);
      eyeLeftHeight = h;
    }
    
    public void eyeRightReceived(float h) {
     // println("eye right: " + h);
      eyeRightHeight = h;
    }
    
    public void jawReceived(float h) {
      //println("jaw: " + h);
    }
    
    public void nostrilsReceived(float h) {
      //println("nostrils: " + h);
      nostrilHeight = h;
    }
    
    public void found(int i) {
      //println("found: " + i); // 1 == found, 0 == not found
      found = i == 1;
    }
    
    public void posePosition(float x, float y) {
     // println("pose position\tX: " + x + " Y: " + y );
      posePosition.x = x;
      posePosition.y = y;
    }
    
    public void poseScale(float s) {
      //println("scale: " + s);
      poseScale = s;
    }
    
    public void poseOrientation(float x, float y, float z) {
     // println("pose orientation\tX: " + x + " Y: " + y + " Z: " + z);
      poseOrientation.x = x;
      poseOrientation.y = y;
      poseOrientation.z = z;
    }
    public void oscEvent(OscMessage theOscMessage) {
    if (theOscMessage.isPlugged()==false) {
      println("UNPLUGGED: " + theOscMessage);
      }
    }
    
   public void updateanddraw(){
    if(found){   

      mouth = new MouthDetect(mouthWidth, mouthValue); 
      eye = new EyebrowDetect(browVal, rightEyebrowHeight, eyeVal, eyeRightHeight); 
      orientation = new OrientationDetect(zValue, poseOrientation.z);
      mouthorientation = new MouthAndOrientationDetect(mouthWidth,mouthValue,zValue,poseOrientation.z);
      moutheye = new MouthAndEyebrowDetect(mouthWidth,mouthValue,browVal, rightEyebrowHeight,eyeVal,eyeRightHeight);
      eyeorientation = new EyebrowAndOrientationDetect(browVal,rightEyebrowHeight,eyeVal,eyeRightHeight,zValue,poseOrientation.z);
      all = new AllDetected(browVal,rightEyebrowHeight,eyeVal,eyeRightHeight,zValue,poseOrientation.z,mouthWidth,mouthValue);
      cockpit.drawFormat(detectGesture());
      calibInput.setFont(detectGesture());
      //If the boolean detect is true, which means, if a word is finished and the system is waitin for a new word
      if (detect){
        input.setFont(detectGesture()); 
      }
    }
   }
   
     public String detectGesture(){
       //detect if mouth, mouthebrow or angle is detected 
       if (all.isdetected()){
        // println("EVERYTHING means UNDERLINED and italic and bOLD");
         return "all";
         
       }
        if (mouthorientation.isdetected()){
        // println("MOUTh and ORIENTATION means UNDERLINED and italic");
         return "underlinedAndItalic";
       }
       if (moutheye.isdetected()){
        // println("MOUTh and eYEBROW means UNDERLINED and BOLD");
         return "underlinedAndBold";
       }
       if (eyeorientation.isdetected()){
         //println("EYE and ORIENTATION means BOLD and ITALIC");
         return "boldAndItalic";        
       }
        if (mouth.isdetected()){
       return "underlined"; 
        }
        if (eye.isdetected()){
           return "bold"; 
        }
        if (orientation.isdetected()){  
           return "italic"; 
        }
           
        else{
         return "regular"; 
        }
      }
}
class MouthDetect{
  float w; 
  float v;
  
  MouthDetect(float mw, float mvalue){
    w=mw;
    v=mvalue;
  }
  public boolean isdetected(){
    if (w <= v){
     return true;  
    }
    else return false; 
  }
}

class OrientationDetect{
  float z,zVal;  
  
  OrientationDetect(float zValue, float oz){
    zVal=zValue;
    z=oz;
  }
  public boolean isdetected(){
    if (z< zVal){
     return true;  
    }
    else return false; 
  }
}

class EyebrowDetect{
  float rightbrow,righteye,bvalue,evalue; 
  
  EyebrowDetect(float browValue,float rbrow,float eyeValue,float reye){
   // l=lbrow;
    rightbrow=rbrow;
   // le=leye;
    righteye=reye;
    bvalue=browValue;
    evalue = eyeValue;
    
  }
  public boolean isdetected(){
    if ( rightbrow > bvalue) {
      if (righteye >= evalue)
      {
        return true;  
      }
      return false;
    }
    else return false; 
  }
}

class MouthAndOrientationDetect{
  float w; 
  float v;
  float z,zVal;  

  
  MouthAndOrientationDetect(float mw, float mvalue,float zValue, float oz){
    w=mw;
    v=mvalue;
    zVal=zValue;
    z=oz;
  }
  public boolean isdetected(){
    if (w <= v && z< zVal){
     return true;  
    }
    else return false; 
  }
}

class MouthAndEyebrowDetect{
  float w; 
  float v;
  float rightbrow,righteye,bvalue,evalue; 
  
  MouthAndEyebrowDetect(float mw, float mvalue,float browValue,float rbrow,float eyeValue,float reye){
    w=mw;
    v=mvalue;
    rightbrow=rbrow;
    righteye=reye;
    bvalue=browValue;
    evalue = eyeValue;
  }
  public boolean isdetected(){
    if (w <= v && rightbrow > bvalue){
    if (righteye >= evalue)
      {
        return true;  
      }
     return false;  
    }
    else return false; 
  }
}
class EyebrowAndOrientationDetect{
  float rightbrow,righteye,bvalue,evalue; 
  float z,zVal;
  
  EyebrowAndOrientationDetect(float browValue,float rbrow,float eyeValue,float reye, float zValue, float oz){
   // l=lbrow;
    rightbrow=rbrow;
   // le=leye;
    righteye=reye;
    bvalue=browValue;
    evalue = eyeValue;
    zVal=zValue;
    z=oz;
    
  }
  public boolean isdetected(){
    if ( rightbrow > bvalue && z< zVal) {
      if (righteye >= evalue)
      {
        return true;  
      }
      return false;
    }
    else return false; 
  }
}

class AllDetected{
  float rightbrow,righteye,bvalue,evalue; 
  float z,zVal;
  float w; 
  float v;
  
  AllDetected(float browValue,float rbrow,float eyeValue,float reye, float zValue, float oz,float mw, float mvalue){
   // l=lbrow;
    rightbrow=rbrow;
   // le=leye;
    righteye=reye;
    bvalue=browValue;
    evalue = eyeValue;
    zVal=zValue;
    z=oz;
    w=mw;
    v=mvalue;
    
  }
  public boolean isdetected(){
    if ( rightbrow > bvalue && z< zVal && w <= v) {
      if (righteye >= evalue)
      {
        return true;  
      }
      return false;
    }
    else return false; 
  }
}
class Textfield{

  PFont currentfont;
  int w = width/4*3;
  int h = (height/4)*3; 
  ArrayList<String> txt = new ArrayList<String>();
  String source = "S";
  ArrayList<PFont> fonts = new ArrayList<PFont>(); 
  int lineHeight = 32;
  int fontSize = 32;
  
  Textfield(){
   fonts.add(regular);
   textLeading(lineHeight); 
  }
  
  public void updateanddraw(){
    
  pushMatrix();
  fill(255);
  noStroke();
  rect(width/8,height/6, w,h);
  fill(0);

    int tx=(width/8)+7;
    int ty = (height/6)+55; 
  for (int i = 0; i<source.length(); i++){
    textFont(fonts.get(i),32);
    text(source.charAt(i),tx,ty);
    tx += textWidth(source.charAt(i));
    if (tx>(w+(width/8)-30)){
     ty += 50; 
     tx = (width/8)+7;
    }
  }
  popMatrix();
  }

  
  public void setFont(String type){
    if (type == "regular"){
      currentfont = regular; 
    }
    if (type == "bold"){
       currentfont = bold; 
    }
    if (type == "italic"){
       currentfont = italic; 
    }
    if (type == "underlined"){
       currentfont = underlined; 
    }
    if (type == "underlinedAndBold"){
       currentfont = underlinedAndBold; 
    }
    
    if (type == "underlinedAndItalic"){
       currentfont = underlinedAndItalic; 
    }
    if (type == "boldAndItalic"){
       currentfont = boldAndItalic; 
    }
    if (type == "all"){
      currentfont = all; 
    }
  }
  
 public void clear(){
   source ="";
   txt.clear();
   fonts.clear();
 }
}
  public void settings() {  size(1000 ,800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "faceTYPE" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
