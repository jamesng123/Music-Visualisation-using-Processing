class Lissajous {

  //float x1(float t) {
  //  return sin(t/10 + PI/2) * 60 + 100;
  //}

  //float y1(float t) {
  //  return cos(t/30) * 300 + 10;
  //}

  //float x2(float t) {
  //  return sin(t/10) * 100 - 100;

  //  //return sin(t/10) * 200 + sin(t) * 2;
  //}

  //float y2(float t) {
  //  return cos(t/2) * 30;

  //  //return cos(t/20) * 200 + sin(t/12) * 20;
  //}
  
//  float x1(float t) {
//  return sin(t/10 + PI/2) * 60 + 100 + sin(t) * 3;
//}

//float y1(float t) {
//  return cos(t/30) * 300 + cos(t/10) * 120;
//}

//float x2(float t) {
//  return sin(t/10) * 200 - 100 - sin(t) * 2;
//}

//float y2(float t) {
//  return cos(t/20) * 200 + cos(t/12) * 20 + cos(t/50) * 600;
//}

float x1(float t) {
  return sin(t/10 + PI/2) * 60;
}

float y1(float t) {
  return cos(t/30) * 300 + cos(t/10) * 300;
}

float x2(float t) {
  return sin(t/10) * 200 - sin(t) * 2 + sin(t/50) * 400;
}

float y2(float t) {
  return cos(t/20) * 200 + cos(t/12) * 20 + cos(t/50) * 600;
}
}
