import processing.video.*;
Capture cam;
import twitter4j.conf.*;
import twitter4j.internal.async.*;
import twitter4j.internal.org.json.*;
import twitter4j.internal.logging.*;
import twitter4j.json.*;
import twitter4j.internal.util.*;
import twitter4j.management.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import twitter4j.util.*;
import twitter4j.internal.http.*;
import twitter4j.*;
import twitter4j.internal.json.*;


boolean sketchFullScreen() {
  return true;
}
int touches=0;
boolean usetwitter=true;
//for twitter
int minsince=0;
//for which phrase to use
int secsince=0;
PFont font;
float angle=0.0;
float speed=.1;
int counter=0;
StringList please;
int phrase=0;
File file;

ConfigurationBuilder cb;
Twitter twitter;


void setup(){
  frameRate(10);
  colorMode(HSB, 100);
  background(0, 0, 0);
  size(displayWidth, displayHeight);
  font=loadFont("GillSans-Light-48.vlw");


//    String[] cameras = Capture.list();
//    cam = new Capture(this, cameras[0]);
//    cam.start();

    //14 Phrases
    please = new StringList();
    please.append("Please don't touch me ");
    please.append("Really, please don't touch me ");
    please.append("Please. I really don't like that ");
    please.append("I'm serious. Please don't touch me ");
    please.append("Stop it. ");
    please.append("I'm not joking! Please don't touch me! ");
    please.append("Stop it! I really don't like this! ");
    please.append("I'm feeling really violated! Stop it! ");
    please.append("Stop it now! ");
    please.append("Get your hand off of me! ");
    please.append("HELP! ");
    please.append("Don't fucking touch me! ");
    please.append("Get the fuck away from me! ");
    please.append("STOP FUCKING TOUCHING ME! SOMEONE PLEASE HELP! ");
}

void draw(){
  
  if(minsince!=minute()){
   usetwitter=true; 
  }
  counter++;
//  println(touches);
  if(counter%30==0){
    touches=0;
  }
  if(touches>=5){
    secsince=second();
    if(abs(secsince-second())>20){
      phrase++;
    }
    if(phrase==15){
      shutdown();  
    }   
    println(touches);
    String text = new String(please.get(phrase)+hour()+"-"+minute()+"-"+second());
    if(usetwitter){
      
//         //Camera
//       if (cam.available() == true) {
//        cam.read();
//        PImage pg = cam.get();
//        pg.save(text + ".jpeg");
//      }
//      //Create filename of picture
//      String filename = new String(sketchPath + "/" + text + ".jpeg");
//      File file = new File(filename);
//      
//      ConfigurationBuilder cb = new ConfigurationBuilder();
//      cb.setOAuthConsumerKey("oDO33fLfAMCQy0el202L5g");
//      cb.setOAuthConsumerSecret("m7TA9xR4aWu1e2sgpgp0mnzZi1uR5xWfKJbWq22B0");
//      cb.setOAuthAccessToken("443442085-7sGOKirZXdbfPTzFaGcbDc1NKJyvWs0Pe3TnpFFC");
//      cb.setOAuthAccessTokenSecret("HSLLov4aI5yCoyL1cCakz3o2oxHTPdT5RG1WdnKHjAAbq");
//      Twitter twitter = new TwitterFactory(cb.build()).getInstance();
//       try{
//          StatusUpdate status = new StatusUpdate(text);
//          status.setMedia(file);
//          twitter.updateStatus(status);
//       }catch (TwitterException te){
//        println("Couldn't Connect"+te);
//       }
      println("Tweet");
      minsince=minute();
      usetwitter=false;
    }
   counter=0;
   touches=0;
   if(speed<=1){
     speed+=.01;
   }
  }
  if(counter>=250 && speed>.5){
    speed=.5;
    phrase=0;
  }
  if(counter>=500 && speed>.1){
    speed=.1;
    phrase=0;
  }
  
  background(0, 0, 100*sin(angle));
  angle+=speed;
}

void mouseMoved() {
  dont();
}

void keyPressed() {
  dont();
}

void dont(){
  touches++;
  if(phrase<14){
    text(please.get(phrase), width/2, height/2);
  }
}

void shutdown(){
  background(0,0,0);
  touches=0;
  usetwitter=true;
  minsince=0;
  speed=.1;
  counter=0;
  phrase=0;
  int min=0;
  if(minute()<=58){
    min=minute();
  }else{
    min=60;
  }
  print("waiting");
  while(abs(minute()-min)<2){
  }
  
}
