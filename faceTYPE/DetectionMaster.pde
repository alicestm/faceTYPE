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
    void oscEvent(OscMessage theOscMessage) {
    if (theOscMessage.isPlugged()==false) {
      println("UNPLUGGED: " + theOscMessage);
      }
    }
    
   void updateanddraw(){
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
   
     String detectGesture(){
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