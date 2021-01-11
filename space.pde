//new task has been implmented
//thanks to project team Arwa, salma, shimaa, nada, yomna
// github repo "https://github.com/shimaahamdy/grphics-project"


// images for game
PImage img;                   //background image when we start
PImage player;                //player image
PImage enemy;                 // enemy image
PImage start_button;          //start button
PImage start_button2;         //start button2
PImage coins;                 // coins 
PImage gameback;              //game background
PImage rocks;                 //rocks 
PImage score_image;           //score image during game
PImage game_score;            //score image after game finished

// varables of postions and shapes dimensions
int coin_width = 45;                          //coins width
int coin_height = 45;                        //coin height
int enemy_width = 50;                     //enemy width
int enemy_height = 50;                   //enemy height
int player_width = 100;                  //player width
int player_height = 300;                 //player height
int player_x=1300/2-70;                 //player x position
int player_y=700-player_height;       //player height position
int rocks_x=0;                             //rocks x pos
int rocks_y=-560;                             //rocks y pos
float angle =0.0;

// variables of levesl and diffculty of game
int coin_sz=10;              //coins number
int difficulty = 3;          //set difficulty of game      
int score = 0;               //score 
boolean clicked = false;           //check if start  button clicked

//hold enemies and coiness
enemy[] enemies;             //array of enemies
coins[] coinss;              //array of coiness -------------------> can be chnged to array list

// check if player died or not
boolean isCollided = false;


// move rocks as in background
void move_rocks()
{
  // check if rock position less than end of screen so we can move it down
  if(rocks_y < height)
        {
           rocks_y +=4;
        }
        // opacity of picture
        tint(255, 127); // Display at half opacity 
        image(rocks,rocks_x,rocks_y,width,height); //show image
        noTint();
        // ene opacity
        //check if rock reach to end screen repeat again
        if(rocks_y >= height)
        rocks_y=-560;
        
        
}

//move coins 
void move_coins()
{
  //loop on coins if any of them reach the end of screen reset to inital positon
   for(int i = 0; i < coinss.length; i++){
        if(coinss[i].y > height)
        {
           coinss[i].y = -20; // set coins to inital pos
        }
       
        //condition of eacting coins
        boolean condition_coin_left = coinss[i].x + coinss[i].w >= player_x;  
        boolean condition_coin_right = coinss[i].x + coinss[i].w <= player_x + player_width + 4; 
        boolean condition_coin_up =  coinss[i].y >= player_y;
        boolean condition_coin_down = coinss[i].y + coinss[i].h <= player_y + player_height;
      
         //check if that coin still alive and had been eaten
        if(condition_coin_left && condition_coin_right && condition_coin_up && condition_coin_down && coinss[i].alive)
        {  
           coinss[i].alive = false;
           score++;
        }
        
        // if coin still alive show image and increase speed with random number
        if(coinss[i].alive){
        coinss[i].show_coins();
        coinss[i].drop_coins((int)random(1, 15));  // move coins down
        }
       
        
       
      }
    
}

// similar to coins move function but with no alive conditon
void move_enemy(){
      for(int i = 0; i < enemies.length; i++){
        if(enemies[i].y > height){
           enemies[i].y = -10;
         
        }
        enemies[i].show_enemy();
        enemies[i].drop_enemy((int)random(1, 15));
 
      
       
       //condition of kill
        boolean conditionXLeft = enemies[i].x + enemies[i].w >= player_x;
        boolean conditionXRight = enemies[i].x + enemies[i].w <= player_x + player_width + 4;
        boolean conditionUp =  enemies[i].y >= player_y;
        boolean conditionDown = enemies[i].y + enemies[i].h <= player_y + player_height;
      
      // check if enemy touch player set it is touched
        if(conditionXLeft && conditionXRight && conditionUp && conditionDown){
             isCollided = true;
        }
        
   
      }
     

}


  
void rotate_players()
{
   pushMatrix();
translate (200,200);
rotate(angle);
 image(player,-50,-150,player_width,player_height);
 angle+=.1;
 popMatrix();
 translate (width-200,200);
rotate(angle);
 image(player,-50,-150,player_width,player_height);
 angle+=.1;
}

// check if mouse touch start button

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
  
  //show enemy shape
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
  public boolean alive = true;   //if not alive => disappear
  
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
  
  //show coins shape
  public void show_coins()
  {
    image(coins,x,y,w,h);
  }
}
/* 
  initalize enmies function 
 to set at random x postion that enemy fall from ,also number of enemies
*/
void init_enemies(int x_min, int x_max, int size,int coins_size){
  enemies = new enemy[size];  // set number of enemies to array size
  coinss = new coins[coins_size]; // set number of coins to array 
  
  // loop on enemies to set random x pos
 for(int i = 0; i < enemies.length; i++)
  {
     int x = (int)random(x_min, x_max);//random num from xmin to xmax
     int y = -10; // startes postition
     enemies[i] = new enemy(x, y, enemy_width, enemy_height); 
  }
  for(int i = 0; i < coinss.length; i++)
  {
     int x = (int)random(x_min, x_max);//random num from xmin to xmax
     int y = -10; // startes postition
     coinss[i] = new coins(x, y, coin_width, coin_height); 
  }
}

void setup(){

  size(1300,700);                                     // size of window 
  img=loadImage("background.png");                     // load background starter image
  player=loadImage("player.png");                       //load player image
  enemy = loadImage("enemy.png");                       //load virus image
  start_button = loadImage("start.png");              // load start button
  start_button2 = loadImage("start2.png");            //load start button clicked
  gameback = loadImage("gameback.jpg");                //load game background
  rocks = loadImage("rocks.png");                      //load rocks 
  score_image = loadImage("score.png");                //load score1 image
  game_score = loadImage("game_score.png");            //load score2 image
  init_enemies(-20, width+20 , difficulty,coin_sz);          //call initalize enimies function 
  coins=loadImage("coins.png");                                //load image of coins

  
}

void draw(){
   
  
  image(img,0,0,width,height);  // draw start background
  image(start_button,width/2-70,height/2+100,150,100); //draw start button image
  
  //check if we start game
  mousepressed();
  
  //start game if we press mouse
  if(clicked)
  {
    image(gameback,0,0,width,height);
     
     move_rocks();
     image(player,player_x,player_y,player_width,player_height);             //draw player 
   
  
  //check if player still alive
  if(!isCollided)
  {
    move_enemy();  
    move_coins();
   image(score_image,0,10,200,50); //draw score shape
   
   // take from keyboard player action
   if(keyPressed && (key ==CODED))  
  {
    //check if we press left and we didnt reach end of screen
    if(keyCode == LEFT && player_x>=15)
    player_x-=30;   //change x depend on key 
    
    //check if we press right and we didnt reach end of screen
    else if(keyCode==RIGHT && player_x<=width-100)
    player_x+=30;
  }
   
   // write score during game
   textSize(30);
   text(score,100,45);
  
    
  }
  
  //if player died 
 else{
   image(gameback,0,0,width,height);                          
   image(game_score,width/2-300,height/2-300,500,500);       // show final score
   textSize(50);
   fill(0,0,0);
   text(score,width/2-65,height/2+30);
   rotate_players();  //translate and rotation player
   
 }


  
}}
