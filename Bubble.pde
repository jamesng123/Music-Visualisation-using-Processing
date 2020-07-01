class Bubble {

  float size;
  float x;
  float y;
  color outsideCol;
  color col;
  float transparency;

  float xspeed;
  float yspeed;

  float xdirection;
  float ydirection;

  float lowerBoundary = 50;
  float upperBoundary = height/4;


  Bubble(float size) {
    // size = random(lowerBoundary, upperBoundary);
    this.size = size;
    x = random(size*0.5, width-size*0.5);
    y = random(size*0.5, height-size*0.5);
    transparency = map(size, lowerBoundary, upperBoundary, 0, 255);
    if (size < 150) {
      this.col = color(random(255), random(255), random(255), 255 - transparency*1.3);
      this.outsideCol = color(random(255), random(255), random(255), 255 - transparency);
    } else {
      this.col = color(random(100), random(100), random(100), 255 - transparency);
      this.outsideCol = color(random(100), random(100), random(100), 255 - transparency);
    }

    xdirection = map(size, lowerBoundary, upperBoundary, -1, 1);
    ydirection = map(size, lowerBoundary, upperBoundary, -1, 1);
  }

  void display() {
    stroke(outsideCol);
    fill(col);
    ellipse(x, y, size, size);
  }

  void move(float xspeed, float yspeed) {
    x = x + (xspeed * xdirection);
    y = y + (yspeed * ydirection);

    if (x > width-size/2 || x < size/2) {
      xdirection *= -1;
    }
    if (y > height-size/2 || y < size/2) {
      ydirection *= -1;
    }
  }
}
