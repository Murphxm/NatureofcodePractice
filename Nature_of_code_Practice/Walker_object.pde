/* main component of this visualisation */
class Walker {
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector circularStep;
  float stepX;
  float stepY;
  
  
  Walker() {
    location = new PVector(width/2, height); //start where seed falls
    velocity = new PVector(0, 0);
    acceleration= new PVector(0, 0);
  }
  
  void update() {
    location.add(velocity);
    velocity.add(acceleration);
    velocity.limit(10);
    acceleration.mult(0);
    
  }
  
  void randomStep(PVector randomNum, int i) {
    //Takes perlian noise and converts it to a location on a hypothetical circle
    stepX = sin(randomNum.x);
    stepY = cos(randomNum.y);
    
    circularStep = new PVector(stepX, stepY);
    
    PVector S = PVector.div(circularStep, mass[i]); //divide by object mass
    
    acceleration.add(S); //accelerate toward point according to mass
    acceleration.normalize();
    acceleration.mult(2);
  }
  
  //keep all objects within the boundaries
  void edges(int i) { 
    if (location.x >= width - size[i]/2) {
      location.x = width - size[i]/2;
      velocity.x *= -1;
    } else if (location.x <= size[i]/2) {
      velocity.x *= -1;
      location.x = size[i]/2;
    } else if(location.y >= height - size[i]/2) {
      location.y = height - size[i]/2;
      velocity.y *= -1;
    } else if(location.y <= size[i]/2) {
      location.y = size[i]/2;
      velocity.y *= -1;
    }
  }
  //adds gravity and wind forces
  void addForce (PVector force, int i) {
    PVector f = PVector.div(force, mass[i]);
    acceleration.add(f);
    
  }
  
  void display(int i) {
    float angle = velocity.heading(); // determines the direction of the vector
    ellipseMode(CENTER);
    noStroke();
    pushMatrix();
    translate(location.x,location.y); // shifts the layer to the current location
    rotate(angle); // rotates layer according to direction of vector
    ellipse(0, 0, size[i]/2, size[i]/2); 
    beginShape();
      vertex(-size[i]/3, -size[i]/3);
      vertex(size[i]/2, 0);
      vertex(-size[i]/3, size[i]/3);
      vertex(-size[i]/6, 0);
      endShape(CLOSE);
    popMatrix();
  }
}
   