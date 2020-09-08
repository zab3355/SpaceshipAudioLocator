/*
author: Zach Brown
project: Controlling a UFO around a circular orbit with an audio effect on the UFO and background music
*/
import processing.sound.*;
import processing.video.*;
 
PImage ufoImage;

Movie spaceMovie;

//direction counter for image
int direction = 0;

int blackHoleVal = 0;

float mouseSpeed = 0;
float distanceX, distanceY;

boolean ufoGo = false;
boolean filterEffect = false;

SoundFile spaceSound;
SoundFile galaxyMusic;

void setup()
{
   size(1920,1080);
  
  //movie from: https://pixabay.com/videos/space-galaxy-abstract-lights-5200/
  spaceMovie = new Movie(this, "spaceMovie.mov");   
  spaceMovie.loop();
  
   // source of music: https://www.youtube.com/watch?v=SpIgi3Ebn5s
   galaxyMusic = new SoundFile(this, "galaxyMusic.mp3");

   //image source
   // Space pic: https://apod.nasa.gov/apod/ap061005.html
   // UFO pic: https://www.stickpng.com/img/download/5ba661c3bede2105e7aaeef1
   ufoImage = loadImage("ufo1.png");
   
   //handling sound
   //https://processing.org/reference/libraries/sound/SoundFile.html
   //sound file source: http://soundbible.com/2213-Alien-Spaceship-UFO.html
   spaceSound = new SoundFile(this, "alienSound.mp3");
}

//if the mouse is clicked
void mousePressed() {
    ufoGo = true;
    spaceSound.play();
    galaxyMusic.play();
    background(spaceMovie);
    frameRate(10);
}

//if the mouse is released
void mouseReleased() {
    ufoGo = false;
    spaceSound.stop();
    galaxyMusic.pause();
    frameRate(30);
}

//movieEvent for reading spaceMovie
void movieEvent(Movie spaceMovie) {  
  spaceMovie.read();
}

//draw method
void draw(){
    background(spaceMovie);
    if (spaceMovie.available()){
        spaceMovie.read();
    }
    //if mouse is pressed, rotate UFO
    if (ufoGo == true){
      
        //mouse speed triggering an event: https://www.reddit.com/r/processing/comments/228wmf/mouse_speed_triggers_event/
        mouseSpeed =  dist(mouseX, mouseY, pmouseX, pmouseY);
        distanceX = lerp(distanceX, mouseX, 0.15);
        distanceY = lerp(distanceY, mouseY, 0.15);
        
        translate(0, 0);
        //angles range from 0 to Pi
        float rotateAround = map(mouseX, 0, width, 0, PI); 
        translate(width/2, height/2);
        rotate(rotateAround);
        direction++;
        //black hole
        fill(50);
        ellipse(0, 0, blackHoleVal, blackHoleVal);
        blackHoleVal++;
        image(ufoImage,0, 0, 300, 300);
        
        //the mouse speed is 400 or above, change the background to dark blue
        if(mouseSpeed >400){
           background(0,0,85); 
        }
    }
}
