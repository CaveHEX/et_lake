// "Core" simply manages the AgentSphere(s)
// It also dictates when the agent should be "active"

class Core {
  ArrayList<AgentSphere> agents;

  Core() {
    agents = new ArrayList<AgentSphere>();
    for ( int i = 0; i < 20; ++i ) {
      agents.add(new AgentSphere());
    }
  }

  void update() {
    float state = sin(t + cos(t) * 2) + sin(sin(t)+cos(t));
    this.trigger(state > 0);

    for ( AgentSphere as : agents ) {
      as.update();
    }
  }

  void render() {
    // Rendering the agents
    push();
    translate(width/2, height/2);
    for ( AgentSphere as : agents ) {
      as.render();
    }
    pop();
    // We mirror it
    push();
    translate(width/2, height/2);
    rotateY(PI);
    for ( AgentSphere as : agents ) {
      as.render();
    }
    pop();
  }

  void run() {
    this.update();
    this.render();
  }

  void trigger(boolean state) {
    for ( AgentSphere as : agents ) {
      as.trigger(state);
    }
  }
}
