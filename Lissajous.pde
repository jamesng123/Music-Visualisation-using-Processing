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

///////////////////////////////////////////////////////////////////////////////////////////////////

//float x1(float t) {
//  return 250*cos(t/39) +250*cos(t/42);
//}

//float y1(float t) {
//  return 250*sin(t/62) + sin(t/39
//    )*250;
//}

//float x2(float t) {
//  return 250*cos(t/53) +250*cos(t/-18);
//}

//float y2(float t) {
//  return 250*sin(t/12) + sin(t/30)*250;
//}



//float x1(float t) {
//  return 250*cos(t/27) +250*cos(t/15);
//}
//float y1(float t) {
//  return 250*sin(t/19) + sin(t/177)*250;
//}
//float x2(float t) {
//  return 250*cos(t/53) +250*cos(t/-18);
//}
//float y2(float t) {
//  return 250*sin(t/12) + sin(t/30)*250;
//}


float x1(float t) {
  return (sin(t/10 + PI/2) * 60) - 60;
}

float y1(float t) {
  return (cos(t/30) * 300 + cos(t/10) * 300) + 30;
}

float x2(float t) {
  return (sin(t/10) * 200 - sin(t) * 2 + sin(t/50) * 400) - 140;
}

float y2(float t) {
  return (cos(t/20) * 200 + cos(t/12) * 20 + cos(t/50) * 600) + 340;
}




}
