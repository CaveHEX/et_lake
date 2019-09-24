final int TTL = 10; // Time to leave

// A particle system and its particle

// If you feel lost reading this, consider reading :
// https://natureofcode.com/book/chapter-4-particle-systems/

class Particles {

  ArrayList<Particle> particles;

  Particles() {
    particles = new ArrayList<Particle>();
  }

  void update() {
    Iterator<Particle> it = particles.iterator();
    while ( it.hasNext() ) {
      Particle p = it.next();
      p.update();
      if ( p.done() ) {
        it.remove();
      }
    }
  }

  void render() {
    for ( Particle p : particles ) {
      p.render();
    }
  }

  void run() {
    this.update();
    this.render();
  }

  void addPulse(PVector pos) {
    particles.add(new Particle(
      pos, 
      random(150), 
      random(150), 
      random(0.01, 0.04), 
      color(255), 
      false
      ));
  }

  void addPulses() {
    float ex = 0.03;
    for ( int i = 0; i < 2; ++i ) {
      PVector pos = new PVector(-1, -1);


      // Randomly trying to place the particle, we mask it with
      // a simplex noise field
      for ( int j = 0; j < TTL; ++j ) {
        PVector p = new PVector(random(width), random(height));
        PVector p_ = p.copy().mult(ex);
        if ( (float)noise.eval(p_.x*ex, p_.y*ex, t) > 0.0 ) {
          pos = p.copy();
        }
      }

      // If we did place the particle, and that it is far enough
      // from the center
      if ( pos.x > 0 && pos.y > 0 && PVector.dist(pos, center) > 250 ) {
        this.addPulse(pos);
      }
    }
  }
}

class Particle {

  PVector pos;
  float radiusStart;
  float radiusEnd;
  float animationSpeed;
  color col;
  boolean filled;

  float radius;
  float alpha;
  float ctrl = 0.0;

  Particle(PVector pos, float radiusStart, float radiusEnd, float animationSpeed, color col, boolean filled) {
    this.pos = pos.copy();
    this.radiusStart = radiusStart;
    this.radiusEnd = radiusEnd;
    this.animationSpeed = animationSpeed;
    this.col = col;
    this.filled = filled;
  }

  void update() {
    radius = lerp(radiusStart, radiusEnd, ctrl);
    alpha = lerp(255, 0, ctrl);
    ctrl = constrain(ctrl + animationSpeed, 0, 1);
  }

  void render() {
    push();
    if ( filled ) {
      noStroke();
      fill(col, alpha);
    } else {
      stroke(col, alpha);
      noFill();
    }

    circle(pos.x, pos.y, radius);
    pop();
  }

  boolean done() {
    return ctrl >= 0.9999;
  }
}
