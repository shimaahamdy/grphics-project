// coins to disappear
// rocks   
// score  show score 
// hearts /levels 
//button red

// meetings ---> 5pm


// images for game
PImage img;                   //background image when we start
PImage player;                //player image
PImage enemy;                 // enemy image
PImage start_button;          //start button
PImage start_button2;         //start button2
PImage coins;                 // coins 
PImage gameback;              //game background

// varables of postions and shapes dimensions
int coin_width=45;                         //coins width
int coin_height=30;                       //coin height
int enemy_width = 45;                     //enemy width
int enemy_height = 30;                    //enemy height
int player_width = 100;                   //player width
int player_height = 300;                 //player height
int player_x=width/2-70;                 //player x position
int player_y=height-player_height;      //player height position

// variables of levesl and diffculty of game
int difficulty = 3;          //set difficulty of game
int limit = 10;          
int score = 0;               //score 
boolean clicked = false;           //check if start  button clicked

//hold enemies and coiness
enemy[] enemies;             //array of enemies
coins[] coinss;              //array of coiness -------------------> can be chnged to array list

// check if player died or not
boolean isCollided = false;

//can be split to 2 functions
void move(){
      for(int i = 0; i < enemies.length; i++){
        if(enemies[i].y > height){
           enemies[i].y = -10;
           coinss[i].y = -10;
        }
        enemies[i].show_enemy();
        enemies[i].drop_enemy((int)random(1, 15));
        
        //condition of kill
        boolean condition_coin_left = coinss[i].x + coinss[i].w >= player_x;
        boolean condition_coin_right = coinss[i].x + coinss[i].w <= player_x + player_width + 4;
        boolean condition_coin_up =  coinss[i].y >= player_y;
        boolean condition_coin_down = coinss[i].y + coinss[i].h <= player_y + player_height;
      
       
       //condition of kill
        boolean conditionXLeft = enemies[i].x + enemies[i].w >= player_x;
        boolean conditionXRight = enemies[i].x + enemies[i].w <= player_x + player_width + 4;
        boolean conditionUp =  enemies[i].y >= player_y;
        boolean conditionDown = enemies[i].y + enemies[i].h <= player_y + player_height;
      
        if(conditionXLeft && conditionXRight && conditionUp && conditionDown){
             isCollided = true;
        }
        
        
        // condtion that we need enemy to be disapear
        if(condition_coin_left && condition_coin_right && condition_coin_up && condition_coin_down)
        {
           continue;
        }
        coinss[i].show_coins();
        coinss[i].drop_coins((int)random(1, 15));
  
      }
     
 /*
    score += 0.1; // add one if not kill condation is false 
    //display 
    fill(0, 102, 153);
    text("Score: "+(int)score, 10, 40);
    textSize(25);
    */
}


// draw playe
void drawPlayer()
{
  image(player,player_x,player_y,player_width,player_height); 
}



// check keybord movment

void mousepressed(){
  if(mouseX >= width/2-70 && mouseX<= width/2-70+150 && mouseY>= height/2+100 && mouseY<=height/2+100+100 && mousePressed == true)
  {
    clicked = true;
  }

}


// class enemy represnt virus that falling from sky
class enemy{
  
  public int x;  // x cordinate
  public int y;  // y cordinate
  public int w;  //width
  public int h;  //height
  
  // constuctior to intialize xcordinate, ycordinate, width and height
  enemy(int x, int y, int w, int h)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  } 
  
  //set speed of falling of enemy
  public void drop_enemy(int speed)
  {
    y += speed;
  }
  
  //show virus shape
  public void show_enemy()
  {
    image(enemy,x,y,w,h);
  }
}

// class enemy represnt virus that falling from sky
class coins{
  
  public int x;  // x cordinate
  public int y;  // y cordinate
  public int w;  //width
  public int h;  //height
  
  // constuctior to intialize xcordinate, ycordinate, width and height
  coins(int x, int y, int w, int h)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  } 
  
  //set speed of falling of enemy
  public void drop_coins(int speed)
  {
    y += speed;
  }
  
  //show virus shape
  public void show_coins()
  {
    image(coins,x,y,w,h);
  }
}
/* 
  initalize enmies function 
 to set at random x postion taht enemy fall from also number of enemies
*/
void init_enemies(int x_min, int x_max, int size,int coins_size){
  enemies = new enemy[size];  // set number of enemies to array size
  coinss = new coins[coins_size];
 for(int i = 0; i < enemies.length; i++)
  {
     int x = (int)random(x_min, x_max);//random num from xmin to xmax
     int y = 5; // startes postition
     enemies[i] = new enemy(x, y, enemy_width, enemy_height); // set enemy basic valuse
  }
  for(int i = 0; i < coinss.length; i++)
  {
     int x = (int)random(x_min, x_max);//random num from xmin to xmax
     int y = 5; // startes postition
     coinss[i] = new coins(x, y, coin_width, coin_height); // set enemy basic valuse
  }
}

void setup(){
  
  size(1300,700);                                     // size of window 
  img=loadImage("background.png");                     // load background image
  player=loadImage("player.png");                       //load player image
  enemy = loadImage("enemy.png");                       //load virus image
  start_button = loadImage("start.png");              // load start button
  start_button2 = loadImage("start2.png");            //load start button clicked
  gameback = loadImage("gameback.jpg");
  init_enemies(-20, width+20 , difficulty,5);          //call initalize enimies function
  player_x=width/2-70;
  player_y=height-300;
  coins=loadImage("coins.png");

  
}

void draw(){
   
  
  image(img,0,0,width,height);  // draw start background
  image(start_button,width/2-70,height/2+100,150,100);
  //check if we start game
  mousepressed();
 
  if(clicked)
  {
      // try to change button when it clicked -----------------------------------------------------
     //image(start_button2,width/2-70,height/2+100,150,100); // draw button clicked
     
     image(gameback,0,0,width,height);
     drawPlayer();             //draw player 
  
  if(!isCollided){
    move();
    
    if(keyPressed && (key ==CODED))  //check if keypressed 
  {
    if(keyCode == LEFT)player_x-=10;   //change x depend on key
    else if(keyCode==RIGHT) player_x+=10;
  }
    if(score > limit && score < limit + 2){
      init_enemies(-100, width + 20, difficulty,5); difficulty += 10; limit += 20;
    }
  }
 else{
   text("Score: "+(int)score,100, 100);
 }

  
}}
