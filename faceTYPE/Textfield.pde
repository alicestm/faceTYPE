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
  
  void updateanddraw(){
    
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

  
  void setFont(String type){
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
  
 void clear(){
   source ="";
   txt.clear();
   fonts.clear();
 }
}