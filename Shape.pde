class Shape {


  int beatShape;
  float radius;

  void display(float rotation, float bpm, color col) {
    stroke(col);
    pushMatrix();
    translate(width/2, height/2);
    beginShape(TRIANGLE_STRIP);
    rotate(radians(rotation * (bpm/20) * frameCount % 360));
    float b = map(this.beatShape, 0, width, 5, 100);
    for (int j = 0; j < 360; j+=b) {
      float q = this.radius * sin(j);
      float w = this.radius * cos(j);
      vertex(q, w);
    }
    endShape();
    popMatrix();
  }
}
