int radius = 40;
float x = 390;
float y = 400;
float speed = 2.0;
int direction = 1;
int face = 1;

int[] dx;
int[] dy;
int[][] flag;

int allow = 5;
int count = 0;
int offsetX = 0;
int offsetY = 0;

float mouth = 0;
float openClose = 0.05;

int time = 0;
int timeLimit = 60;
int countDown = 0;

void setup(){
  size(800,800);
  ellipseMode(RADIUS);
  smooth();
  
  dx = new int[width/radius-1];
  dy = new int[height/radius-1];
  flag = new int[width/radius-1][height/radius-1];
  
  for(int i = 0; i < dx.length; i++){
    dx[i] = i*radius+radius;
    dy[i] = i*radius+radius;    
    
    for(int j = 0; j < dy.length; j++){
      flag[i][j] = 1;
    }
  }
}  

//draw
void draw(){
  background(0);
  fill(255);
  
  drawDot();
  drawLine();
  move();
  
  textSize(20);
  fill(0);
  getCount();
  text(count, x+offsetX,y+offsetY);
  countdown();
}
//draw end  

//move
void move(){
  if(x > width + radius){
    x = -radius;
  }
  if(x < -radius){
    x = width + radius;
  }
  if(y > height + radius){
    y = -radius;
  }
  if(y < -radius){
    y = height + radius;
  }
  
  if(keyPressed == true){
    if(keyCode == RIGHT){
      face = 1;
      x = x + speed * direction;
      if((x > width - radius && y < height/2 - allow) || (x > width - radius && y > height/2 + allow)){  
        x = width - radius;
      }
    }       
    if(keyCode == LEFT){
      face = 3;
      x = x + speed * -direction;
      if((x < radius && y < height/2 - allow) || (x < radius && y > height/2 + allow)){
        x = radius;
      }
    }
    if(keyCode == DOWN){
      face = 2;
      y = y + speed * direction;
      if((x < width/2 - allow && y > height - radius) || (x > width/2 + allow && y > height - radius)){
        y = height - radius;
      }
    }
    if(keyCode == UP){
      face = 4;
      y = y + speed * -direction;
      if((x < width/2 - allow && y < radius) || (x > width/2 + allow && y < radius)){
        y = radius;
      }
    }
  }

  if(face == 1){
    mouth = mouth+ openClose;
    if(mouth>PI/6 || mouth<0){
      openClose = -openClose;
    }
    arc(x,y,radius,radius,mouth,TWO_PI-mouth);
    offsetX = -28;
    offsetY = -10;
  }
  if(face == 2){
    mouth = mouth+ openClose;
    if(mouth>PI/6 || mouth<0){
      openClose = -openClose;
    }
    arc(x,y,radius,radius,HALF_PI+mouth,TWO_PI+HALF_PI-mouth);
    offsetX = -20;
    offsetY = -10;
  }
  if(face == 3){
    mouth = mouth+ openClose;
    if(mouth>PI/6 || mouth<0){
      openClose = -openClose;
    }
    arc(x,y,radius,radius,PI+mouth,TWO_PI+PI-mouth);
    offsetX = -15;
    offsetY = -10;
  }
  if(face == 4){
    mouth = mouth+ openClose;
    if(mouth>PI/6 || mouth<0){
      openClose = -openClose;
    }
    arc(x,y,radius,radius,-HALF_PI+mouth,PI+HALF_PI-mouth);
    offsetX = -20;
    offsetY = 18;
  }
  
  for(int i = 0; i < dx.length; i++){
    for(int j = 0;j < dy.length; j++){
      if((x-allow <= dx[i] && dx[i] <= x+allow) && (y-allow <= dy[j] && dy[j] <= y+allow)){
        flag[i][j] = 0;
      }
    }
  }
}
//move end
  
//getCount
void getCount(){
  count = 0;
  for(int i = 0; i < dx.length; i++){
    for(int j = 0;j < dy.length; j++){
      if(flag[i][j] == 0){
        if(i%5 == 4 || j%5 == 4){
          count++;
        }else{
          count--;
        }        
      }
    }
  }  
}
//getCount end

//mouseClicked
void mouseClicked(){
  x = 390;
  y = 400;
  direction = 1;
  face = 1;
  count = 0;
  time = 0;
  timeLimit = 60;
  countDown = 0;
  
  for(int i = 0; i < dx.length; i++){
    for(int j = 0;j < dy.length; j++){
      flag[i][j] = 1;
    }
  }
  loop();
}
//mouseClicked end

//drawDot
void drawDot(){
  for(int i = 0; i < dx.length; i++){
    for(int j = 0; j < dy.length; j++){
      if(flag[i][j] == 1){
        if(i%5 == 4 || j%5 == 4){ 
          fill(255,0,0);
        }else{          
          fill(255,255,255);
        }
        ellipse(dx[i],dy[j],5,5);
      }
    }
  }  
}
//drawDot end

//drawLine
void drawLine(){
  stroke(0,255,0);
  strokeWeight(3);
  line(0, height/2-radius-allow, 30, height/2-radius-allow);
  line(0, height/2+radius+allow, 30, height/2+radius+allow);
  line(770, height/2-radius-allow, 800, height/2-radius-allow);
  line(770, height/2+radius+allow,800, height/2+radius+allow);
  line(width/2-radius-allow, 0, width/2-radius-allow, 30);
  line(width/2+radius+allow, 0, width/2+radius+allow, 30);
  line(width/2-radius-allow, 770, width/2-radius-allow, 800);
  line(width/2+radius+allow, 770, width/2+radius+allow, 800);
  noStroke();
}
//drawLine end

//countdown
void countdown(){
  time++;
  countDown = timeLimit - time/60;  
  if(countDown > 0){
    fill(255);
    text("Count Down:" + countDown,600,25);
  }else{
    noLoop();
    background(255, 100, 100);
    text("Time Over", 350, 300);
    text("Point: " + count, 350, 330);    
  }
}
//countdown end
