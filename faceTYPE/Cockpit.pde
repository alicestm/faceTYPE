class Cockpit{
     PImage img = loadImage("logo_facetype.png");
 Cockpit(){
   
 }
 void updateanddraw(){
   
   //draw the Logo
   image(img, width/8, 40);

 }
 // draws the three circles with their color, depending on which formats are currently activated
 void drawFormat(String format){
   pushMatrix();
     translate((width/2-80), 90);
     color color1 = color(255);
     color color2 = color(255);
     color color3 = color(255);
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
 
 void drawMessage(String message){
   pushMatrix();
   translate(width/4+50,40);
   textSize(24);
   text(message,0,0);
   popMatrix();
 }
}