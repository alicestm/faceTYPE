class MouthDetect{
  float w; 
  float v;
  
  MouthDetect(float mw, float mvalue){
    w=mw;
    v=mvalue;
  }
  boolean isdetected(){
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
  boolean isdetected(){
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
  boolean isdetected(){
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
  boolean isdetected(){
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
  boolean isdetected(){
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
  boolean isdetected(){
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
  boolean isdetected(){
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