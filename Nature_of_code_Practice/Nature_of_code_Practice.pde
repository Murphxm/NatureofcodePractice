/*Nature of code practice.
version 1.0    @author Murphxm

This program uses arrays to initialise multiple random walker objects that accelerate
in random directions, these objects are triangles, the point of this triangle
points in the direction of the current velocity.

The walkers accelerate and deccelerate, all the walkers have a varying mass
derived from a standard deviation bell curve. This mass affects the walkers size and
speed of acceleration.

There is a constant gravity force causing the walkers to accelerate toward the bottom
of the screen. Also a wind force activated by either the left or right directional keys
will cause the walkers to gradually accelerate toward the relevant side of the screen.

I initially had this as a basic simulation Howver I decided to turn it into a
visualisation.

The seed object will drop from the top of the screen gradually accelerating.
When it hits the bottom of the screen the walkers will initialise, causing an explosive
like reaction visual.

*/

int numberOfWalkers = 100;

//bell curve used to determine mass
import java.util.Random;
Random gen = new Random();
float stddev = 1;
int mean = 3;

boolean backDrop = true; // whether or not the background refreshes
float num;


PVector randomNum; //used in walk function
PVector wind;
PVector gravity;

//function to create random color every call (for diversity)
color randomColor() {
  return color(0, random(256), 0,random(50, 200));
}

//Array statements
Walker[] walker = new Walker[numberOfWalkers]; // array of movers
color[] newFill = new color[walker.length]; // array of fill colors
float[] xOff = new float[walker.length]; // initial noiseX value
float[] yOff = new float[walker.length]; // initial noiseY value

//mass / size related arrays
float[] mass = new float[walker.length];
float[] m = new float[walker.length];
float[]size = new float[walker.length];

Seed seed;
void setup() {
  size(1400, 800);
  frameRate(30);
  wind = new PVector(0, 0);
  background(0);
  seed = new Seed();
  //array initialiser
  for(int i = 0; i < walker.length; i ++) {
    walker[i] = new Walker();
    //random mass generator
    m[i] = (float)gen.nextGaussian();
    mass[i] = m[i]*stddev + mean;
    size[i] = mass[i]*15;
    //Allows each object to have a random color
    newFill[i] = color(randomColor());
    
    //random noise initialiser
    xOff[i] = random(1000000);
    yOff[i] = random(1000000);
  }
}

void draw() {
  if (backDrop) {
    background(0);
  }
  
  gravity = new PVector(0, .5);
  //seed acceleration via gravity
  seed.update();
  seed.addForce(gravity);
  seed.display();
  
  if (seed.location.y > height+30) {
    backDrop = false; //turn off background refresh
    for(int i = 0; i < walker.length; i ++) {
       fill(newFill[i]);
       
       //calculate new random value then accelerate in that direction
       num = noise(xOff[i], yOff[i])*360;
       randomNum = new PVector(num, num);
       walker[i].randomStep(randomNum, i);
       
       walker[i].update();
       walker[i].display(i);
       walker[i].edges(i);
       
       //initilize gravity
       gravity = new PVector(0, 0.05);
       gravity.mult(mass[i]); //remove mass to make gravity constant on all objects
       walker[i].addForce(gravity, i); //add gravity
       
       if (keyPressed) {
         if (keyCode == RIGHT) {
           wind.x = 0.1;
           walker[i].addForce(wind, i);
         } else if (keyCode == LEFT) {
           wind.x = -0.1;
           walker[i].addForce(wind, i);
         }
       }
       //move along perlian noise chart
       xOff[i] ++;
       yOff[i] ++;
     }
  }
}