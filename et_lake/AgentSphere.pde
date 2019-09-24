// An agent on a sphere, with a mood system
// for them to switch direction from time to time

// If you feel lost reading this, consider reading :
// https://natureofcode.com/book/chapter-6-autonomous-agents/

class AgentSphere {
  
  PVector pos = new PVector();
  PVector ang = new PVector();
  PVector vel = new PVector();
  PVector acc = new PVector();
  float friction = 0.98;
  float speedEx = 0.0003;

  float radius = 700;
  float radiusInner = 200;

  float mood = 0;
  float moodChange = 150;

  float dir = random(TWO_PI);
  float dirAmp = 0.01;

  float ctrlTar = 0;
  float ctrl = ctrlTar;
  boolean active = true;

  AgentSphere() {
    ang = PVector.random2D();
    ang.mult(TWO_PI);
  }

  void update() {
    PVector wind = PVector.random3D();
    wind.mult(speedEx);
    this.applyAngularForce(wind);
    this.updateMood();

    PVector forth = new PVector(cos(dir), sin(dir));
    forth.mult(speedEx);
    this.applyAngularForce(forth);
    this.physics();

    pos.x = radius * cos(ang.x) * sin(ang.y);
    pos.y = radius * sin(ang.x) * sin(ang.y);
    pos.z = radius * cos(ang.y);

    if ( active ) {
      ctrlTar = 1;
    } else {
      ctrlTar = 0;
    }

    ctrl = lerp(ctrl, ctrlTar, 0.1);
  }

  void render() {
    float rad = map(ctrl, 0, 1, 4, 20);

    PVector posInner = pos.copy().normalize().mult(radiusInner);

    pushMatrix();
    translate(pos.x, pos.y, pos.z); 
    stroke(255);
    strokeWeight(2.0);
    circle(0, 0, rad);
    popMatrix();
    
    pushMatrix();
    translate(posInner.x, posInner.y, posInner.z); 
    stroke(255);
    strokeWeight(2.0);
    circle(0, 0, rad);
    popMatrix();

    stroke(255, 100);
    strokeWeight(2.0);
    line(posInner.x, posInner.y, posInner.z, pos.x, pos.y, pos.z);
  }

  void physics() {
    vel.add(acc);
    vel.mult(friction);
    ang.add(vel);
    acc.mult(0);
  }

  void applyAngularForce(PVector force) {
    acc.add(force);
  }

  void updateMood() {
    mood += 1;

    if ( random(1 * map(mood, 0, moodChange, 0, 1)) > 0.9 ) {
      mood = 0;
      this.changeDirection();
    }
  }

  void changeDirection() {
    dir += random(-dirAmp, dirAmp);
  }

  void trigger(boolean state) {
    active = state;
  }
}
