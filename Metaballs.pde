Attractor[] attractors = new Attractor[10];

int skip = 50;

int inColour;
int outColour;

void setup() {
  size(1080, 1080);
  
  inColour = color(255);
  outColour = color(0);
  
  fill(inColour);
  noStroke();
  frameRate(100);
  randomSeed(2);

  Attractor a = new Attractor(width/2, height/2, 500, new PVector(0, 0));
  a.draw = false;
  a.locked = true;
  attractors[0] = a;
  for(int i = 1; i < attractors.length; ++i) {
    attractors[i] = new Attractor();
  }
  
}

boolean inRegion(int x, int y) {
  float sum = 0;
  for (int i = 1; i < attractors.length; ++i) {
    Attractor a = attractors[i];
    sum += 1/( pow(x - a.pos.x, 2) + pow(y - a.pos.y, 2));
  }
  return sum > 9E-5;
}

void draw() {
  for(Attractor a : attractors) {
    a.calculateTotalForce();
  }
  for(Attractor a : attractors) {
    a.updateAttractor();
  }
  background(outColour);
  for (int x = 0; x < width; x += skip) {
    for (int y = 0; y < height; y += skip) {
      if (inRegion(x, y) && inRegion(x + skip, y) && inRegion(x, y + skip) && inRegion(x + skip, y + skip)) {
        rect(x, y, skip, skip);
      } else if (inRegion(x, y) || inRegion(x + skip, y) || inRegion(x, y + skip) || inRegion(x + skip, y + skip)) {
        for (int xx = x; xx < x + skip && xx < width; xx++) {
          for (int yy = y; yy < y + skip && yy < height; yy++) {
            if (inRegion(xx, yy)) {
              set(xx, yy, inColour);
            }
          }
        }
      }
    }
  }
}
