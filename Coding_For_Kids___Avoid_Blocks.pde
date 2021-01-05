PImage img;
PImage playe;

   PImage ver ;


int playerXCor = 400;
int playerYCor = 300;
int playerWidth = 128;
int playerHeight = 128;
int difficulty = 10;
int limit = 10;
float score = 0;
Baddie[] baddies;
boolean isCollided = false;

//baddies the enemy 
void initBaddies(int xMin, int xMax, int yMin, int yMax, int num){
  baddies = new Baddie[num];
 
  for(int i = 0; i < baddies.length; i++){
     int x = (int)random(xMin, xMax);//random num from xmin to x max
     int y = (int)random(yMin, yMax);// random mum frm ......
     baddies[i] = new Baddie(x, y, 30, 15);
  }// the new baddies 
}
// In a program that has the setup() function, the size()/fullscreen() function must be the first line of code inside setup(), and the setup() function must appear in the code tab with the same name as your sketch folder.
void setup(){
 

  //fullScreen();
  size(600,600);
  //rameRate(60);
  img = loadImage("bg.png");
   
  playe=loadImage("baby.png");
   ver = loadImage("ver.png");
initBaddies(-100, width + 20, 50,50, difficulty);

  
}

void draw(){
   image(img,0,0);
   fill(0, 102, 153);
    textSize(30);
    text("PRESS ENTER TO START ",130, 200);
   
     
      fill(255, 0, 0);
       textSize(20);
    text("move the girl with mouse to \n save it from corona virus ",150, 300);
     

   if(keyCode == ENTER )
  
  {
  image(img,0,0); // Using instead of background();
  drawPlayer();
  
  if(!isCollided){
    moveBaddies();
    if(score > limit && score < limit + 2){
      initBaddies(-100, width + 20, 50, 50, difficulty); difficulty += 10; limit += 20;
    }
  }
 else{
   text("Score: "+(int)score,100, 100);
 }

  
}}
//baddies step
void moveBaddies(){
      for(int i = 0; i < baddies.length; i++){
        if(baddies[i].yCor > height){
           baddies[i].yCor = -10;
        }
        baddies[i].display();
        baddies[i].drop(random(1, 15));
      //condition of kill
        boolean conditionXLeft = baddies[i].xCor + baddies[i].w >= playerXCor;
        boolean conditionXRight = baddies[i].xCor + baddies[i].w <= playerXCor + playerWidth + 4;
        boolean conditionUp =  baddies[i].yCor >= playerYCor;
        boolean conditionDown = baddies[i].yCor + baddies[i].h <= playerYCor + playerHeight;
      
        if(conditionXLeft && conditionXRight && conditionUp && conditionDown){
             isCollided = true;
        }
  
      }
     
 
    score += 0.1; // add one if not kill condation is false 
//display 
    fill(0, 102, 153);
    text("Score: "+(int)score, 10, 40);
    textSize(25);
}



void drawPlayer(){
  stroke(204, 132, 0);//the border 
  strokeWeight(4);
 
 image(playe,playerXCor,playerYCor); 
}




void mouseDragged(){
  if(mouseX >= 0){
    playerXCor = mouseX;
  }
 if(mouseY >= 0 ){
    playerYCor = mouseY;
  }
 
}


 class Baddie{

  public int xCor;
  public int yCor;
  public int w;
  public int h;


  Baddie(int xVal, int yVal, int wVal, int hVal){
    xCor = xVal;
    yCor = yVal;
    w = wVal;
    h = hVal;
    
  } 
  
  public void drop(float speed){
    yCor += speed;
  }
  
  public void display(){

      image(ver,xCor,yCor,w,h);
  }
}
