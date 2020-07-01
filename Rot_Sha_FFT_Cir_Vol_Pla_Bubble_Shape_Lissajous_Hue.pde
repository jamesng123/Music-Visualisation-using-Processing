import ddf.minim.*;
import ddf.minim.analysis.*;
import controlP5.*;
import http.requests.*;
import java.util.List;
import java.awt.Color;

Minim minim;

AudioPlayer song;

BeatDetect beat;

FFT fft;
float offsetX = 0;
float offsetY = -50;
float fftOffsetChangerX = 0.75;
float fftOffsetChangerY = 0.75;


Bubble b;
int numOfBubbles = 15;

Shape innerShape;
Shape outerShape;

Lissajous lissajous;
float t = 0;
int trail_lines = 10;
color lissjousColour;
float c1, c2, c3, c4 = random(255);

int bands = 512;
float angle = 0;
float fftRadius = 1.2;
boolean playFlag = false;
String songName = "";

ArrayList<Bubble> bubbles = new ArrayList<Bubble>();
boolean reverse = false;

float count = 0;
float fft_sum = 0;
float fft_snapshot;
float initial = 0;
float lValue = 0;
float lFade = 1;
float ranRed = 1;
float ranGreen = 1;


float beatCount = 0;
float bpmSet = 20;
boolean beatF = false;

ControlP5 cp5;
int volume;

void setup() {

  size(1600, 900, P3D);

  innerShape = new Shape();
  innerShape.radius = 75;

  outerShape = new Shape();

  lissajous = new Lissajous();

  ellipseMode(RADIUS);

  cp5 = new ControlP5(this);
  cp5.begin();
  cp5.addSlider("volume")
    .setPosition(10, 20)
    .setSize(200, 20)
    .setRange(0, 100)
    .setValue(100);

  cp5.end();  

  File folder = new File("C:/Users/James/Documents/Processing/Rot_Sha_FFT_Cir_Vol_Pla_Bubble_Shape_Lissajous_Hue/data");
  File [] files = folder.listFiles();
  ArrayList<String> fileNames = new ArrayList<String>();

  for (File file : files) {
    fileNames.add(file.getName());
  }

  cp5.addScrollableList("Songs")
    .setPosition(10, 50)
    .setSize(200, 100)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(fileNames);


  minim = new Minim(this);
  beat = new BeatDetect();
}

void draw()
{
  if (playFlag == true) {

    song.play();  
    beat.detect(song.mix);  
    fft.forward(song.mix);

    // Sum of FFT band readings
    for (int i = 0; i < bands; i++) {
      fft_sum += fft.getBand(i);
      fft_snapshot = fft.getBand(i);
    }


    color currentColour = lerpColor(color(initial * ranRed, initial * ranGreen, 150), color(count * ranRed, count * ranGreen, 150), lValue);

    lValue += lFade/100;


    // Average out the sum of FFT band readings
    if (frameCount % 150 == 0) {
      initial =  count;
      count = fft_sum/(2.5*bands);
      lValue = 0;
      fft_sum = 0;
    } 


    if (frameCount % 300 == 0) {
      bpmSet = 12 * beatCount;
      beatCount = 0;
    }




    background(currentColour);
    //println(currentColour);
    pushStyle();
    if ( beat.isOnset() ) { 
      outerShape.beatShape = 140;
      innerShape.beatShape = 100;
      outerShape.radius = 500;
      strokeWeight(6);
      beatF = true;
    } else {
      strokeWeight(1);
    }
    popStyle();


    for (Bubble b : bubbles) {
      pushStyle();
      blendMode(SCREEN);
      strokeWeight(map(b.size, 0, 500, 15, 5));
      b.display();
      b.move(map(bpmSet, 0, 200, 0, 6), map(bpmSet, 0, 200, 0, 6));
      popStyle();
    }


    if (bubbles.size() <= 0) {
      reverse = false;
    } else if (bubbles.size() >= numOfBubbles) {
      reverse = true;
    }

    if (!(beat.isOnset()) && beatF == true) {
      c1 = random(255);
      c2 = random(255);
      c3 = random(255);
      c4 = random(255);
      beatCount +=  1;
      // change the light on the beat

      String k = "{\"bri\":255}";
      PostRequest put = new PostRequest("http://192.168.1.201/api/aN-2gDI1JkTvIyZ-YoPoK5tam-JKHDN2KMfRpwqS/lights/1/state");
      put.method("PUT");

      put.addJson(k);
      put.send(); // stops program until complete


      beatF = false;
      if (reverse == false) {
        bubbles.add(b = new Bubble(map(fft_snapshot, 0, 0.4, 70, height/4)));
      } else if (reverse == true) {
        bubbles.remove(bubbles.size() - 1);
      }
    }

    outerShape.radius *= 0.925;
    outerShape.beatShape *= 0.9999999;
    innerShape.beatShape *= 0.9999999;

    if (outerShape.radius < 200) {
      outerShape.radius = 200;
    }

    if (outerShape.beatShape < 80 || (outerShape.beatShape > 123 && outerShape.beatShape < 127)) {
      outerShape.beatShape = 80;
    }
    if (innerShape.beatShape < 50) {
      innerShape.beatShape = 50;
    }

    pushStyle();
    for (int i = 0; i < bands; i+=8) {
      stroke(255, count, count*0.7);
      strokeWeight(5);
      angle = radians(i*360/bands);
      line(fftRadius*sin(angle)*100 + width/2, fftRadius*cos(angle)*100 + height/2, (sin(angle)*100 + width/2) + 100*sin(angle)*(1 - song.left.get(i)) + offsetX, (cos(angle)*100 + height/2) + 100*cos(angle)*(1 - song.left.get(i)) + offsetY);
    }
    popStyle();

    offsetX += fftOffsetChangerX;
    offsetY += fftOffsetChangerY;

    if (offsetX >= 60) {
      fftOffsetChangerX = -0.5;
    } else if (offsetX <= -60) {
      fftOffsetChangerX = 0.5;
    }

    if (offsetX > 0) {
      fftOffsetChangerY = 0.5;
    } else if (offsetX < 0) {
      fftOffsetChangerY = -0.5;
    }

    // Middle Shapes
    pushStyle();
    strokeWeight(2);
    noFill();
    outerShape.display(0.25, bpmSet, color(255, 255, 255));

    innerShape.display(-1.5, bpmSet, color(255, 255, 0));
    popStyle();

    // Volume
    float vol;
    vol = map(volume, 0, 100, -70, 0);
    song.setGain(vol);

    pushStyle();
    strokeWeight(4);
    lissjousColour = color(c1, c2, c3, c4);
    stroke(lissjousColour);
    pushMatrix();
    translate(width/2, height/2);
    for (int i = 0; i < trail_lines; i++) {
      line(lissajous.x1(t + i), lissajous.y1(t + i), lissajous.x2(t + i), lissajous.y2(t + i));
    }
    t += map(bpmSet, 0, 200, 0.05, 1);
    popMatrix();
    popStyle();

    if (frameCount % 30 == 0) {
      Color c = new Color(currentColour);

      String k = "{\"xy\":[" + getRGBtoXY(c)[0] + ", " + getRGBtoXY(c)[1] + "], \"bri\":50}";

      PostRequest put = new PostRequest("http://192.168.1.201/api/aN-2gDI1JkTvIyZ-YoPoK5tam-JKHDN2KMfRpwqS/lights/1/state");
      put.method("PUT");

      put.addJson(k);
      put.send(); // stops program until complete
    }
  }
}

void Songs(int n) {  
  if (!(songName.contentEquals(""))) {
    song.pause();
  }

  songName = cp5.get(ScrollableList.class, "Songs").getItem(n).get("text").toString();

  playFlag = true;
  song = minim.loadFile(songName);
  fft = new FFT(song.bufferSize(), song.sampleRate());
}

void keyPressed() {
  cp5.get(ScrollableList.class, "Songs").setType(ControlP5.LIST);
  if (key == 'q') ranRed = random(5);
  if (key == 'q') ranGreen = random(5);
  if (key == 'w') {
    for (Bubble b : bubbles) {
      b.ydirection *= -1;
      b.xdirection *= -1;
    }
  }
}

public static double[] getRGBtoXY(Color c) {
  // For the hue bulb the corners of the triangle are:
  // -Red: 0.675, 0.322
  // -Green: 0.4091, 0.518
  // -Blue: 0.167, 0.04
  double[] normalizedToOne = new double[3];
  float cred, cgreen, cblue;
  cred = c.getRed();
  cgreen = c.getGreen();
  cblue = c.getBlue();
  normalizedToOne[0] = (cred / 255);
  normalizedToOne[1] = (cgreen / 255);
  normalizedToOne[2] = (cblue / 255);
  float red, green, blue;

  // Make red more vivid
  if (normalizedToOne[0] > 0.04045) {
    red = (float) Math.pow(
      (normalizedToOne[0] + 0.055) / (1.0 + 0.055), 2.4);
  } else {
    red = (float) (normalizedToOne[0] / 12.92);
  }

  // Make green more vivid
  if (normalizedToOne[1] > 0.04045) {
    green = (float) Math.pow((normalizedToOne[1] + 0.055)
      / (1.0 + 0.055), 2.4);
  } else {
    green = (float) (normalizedToOne[1] / 12.92);
  }

  // Make blue more vivid
  if (normalizedToOne[2] > 0.04045) {
    blue = (float) Math.pow((normalizedToOne[2] + 0.055)
      / (1.0 + 0.055), 2.4);
  } else {
    blue = (float) (normalizedToOne[2] / 12.92);
  }

  float X = (float) (red * 0.649926 + green * 0.103455 + blue * 0.197109);
  float Y = (float) (red * 0.234327 + green * 0.743075 + blue * 0.022598);
  float Z = (float) (red * 0.0000000 + green * 0.053077 + blue * 1.035763);

  float x = X / (X + Y + Z);
  float y = Y / (X + Y + Z);

  double[] xy = new double[2];
  xy[0] = x;
  xy[1] = y;
  return xy;
}
