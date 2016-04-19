/* This object appears first falling from the top to bottom 

*/

class Seed {
  PVector location;
  PVector velocity;
  PVector acceleration;
  int mass = 1;
  int size = 10;
  
  Seed() {
    location = new PVector(width/2, 0);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }
    void update() {
      location.add(velocity);
      velocity.add(acceleration);
      acceleration.mult(0);
    }
    
    void addForce(PVector force) {
      PVector f = PVector.div(force, mass);
      acceleration.add(f);
    }
    
    void display() {
      noStroke();
      fill(0, 100, 0);
      ellipse(location.x, location.y, size, size);
    }
}
    