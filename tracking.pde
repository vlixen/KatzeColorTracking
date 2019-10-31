void tracking() {
  
  String[] cameras = Capture.list();
  printArray(cameras);
  video = new Capture(this, cameras[0]);
  video.start();
  trackColor = color(#DE3333);
  
  }
  
void trackingDraw() {
  pushMatrix();
  video.loadPixels();
  translate(width, 0);
  scale(-2, 2);
  threshold = 80;
  float avgX = 0;
  float avgY = 0;
  int count = 0;
  for (int x = 0; x < video.width; x++ ) {
    for (int y = 0; y < video.height; y++ ) {
      int loc = x + y * video.width;
      color currentColor = video.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackColor);
      float g2 = green(trackColor);
      float b2 = blue(trackColor);
      float d = distSq(r1, g1, b1, r2, g2, b2); 
      if (d < threshold*threshold) {
        stroke(255);
        strokeWeight(1);
        avgX += x;
        avgY += y;
        count++;
      }
    }
  }

  if (count > 0) { 
    avgX = avgX / count;
    avgY = avgY / count;

    fill(255);
    strokeWeight(4.0);
    stroke(0);

    cursor.setTarget(avgX, avgY);
    if (avgX>x1-tam/2 && avgX<x1+tam/2 && avgY>y1-tam/4 && avgY<y1+tam/4 && tam2>=-tam) {
      tam2-=2;
    } else {
      tam2=0;
    }
  }
  popMatrix();
}
