import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;
import java.util.*;

// tools
OpenSimplexNoise noise;
float t = 0;
PostFX fx;
PVector center;

//scene
Particles particles;
Core core;

void setup() {
  size(1000, 1000, P3D);
  frameRate(60);
  smooth(8);
  
  // tools
  noise  = new OpenSimplexNoise();
  center = new PVector(width/2, height/2);
  fx     = new PostFX(this);

  // scene
  particles = new Particles();
  core      = new Core();

  recording = false;
}

void draw() {
  background(0);
  t = frameCount * 0.01;

  particles.addPulses();

  particles.run();
  core.run();

  fx.render()
    .bloom(0.1, 30, 10)
    .noise(0.05, 0.05)
    .bloom(0.1, 30, 10)
    .compose();

  record();

  fill(255);
  text(round(frameRate), 10, 10);
}
