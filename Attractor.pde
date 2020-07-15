class Attractor {

  public PVector pos;
  public PVector vel;
  public PVector forceToApply;
  public int mass;
  public color colour = color(255);
  
  public boolean draw = true;
  public boolean locked = false;
  
  private float rndVelocityScale = 3;
  private float rndPositionScale = 500;
  private float G = 0.00125;

  public Attractor(int x, int y, int mass, PVector vel) {
    this.pos = new PVector(x, y);
    this.mass = mass;
    this.vel = vel;
    this.mass = mass;
  }

  // Create random Attractor
  public Attractor() {
    // Random position
    float angle = random(PI * 2);
    float x = width/2 + rndPositionScale * cos(angle) * random(1);
    float y = height/2 + rndPositionScale * sin(angle) * random(1);
    this.pos = new PVector(x, y);
    // Random velocity
    float a = random(PI * 2);
    this.vel = new PVector(cos(a), sin(a)).mult(rndVelocityScale);
    // Random mass
    this.mass = (int) (random(1) * 50);
  }
  
  // Calculate the force between this Attractor and another
  public PVector getForce(Attractor other) {
    PVector p = other.pos.copy();
    PVector distance = p.sub(pos);
    if (distance.mag() == 0) {
      return new PVector();
    }
    PVector direction = distance.normalize();
    PVector force = direction.mult(G * mass * other.mass / (distance.mag()*distance.mag()));
    return force;
  }
  
  // Calculate the force exereted on this Attractor by other Attractors
  void calculateTotalForce() {
    forceToApply = new PVector();
    for (Attractor other : attractors) {
      forceToApply.add(getForce(other));
    }
  }
  
  void updateAttractor() {
    if (!locked) {
      PVector acc = forceToApply.div(mass);
      vel.add(acc);
      pos.add(vel);
    }
  }
  
  void drawAttractor() {
    if (draw) {
      fill(colour);
      ellipse(pos.x, pos.y, mass * drawScale, mass * drawScale);
    }
  }
  
}
