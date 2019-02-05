import processing.sound.*;

int backgroundColor = 0;
int ballPosX, ballPosY, displacement  = 5, ballWidth = 10, ballHeight = 10, directionX = 1, directionY = 1;
int rightPlayerPosX, rightPlayerPosY, rightPlayerHeight = 150, rightPlayerWidth = 5, rightPlayerMarker = 0, rightPlayerRadious = 5;
int leftPlayerPosX, leftPlayerPosY, leftPlayerHeight = 150, leftPlayerWidth = 5, leftPlayerMarker = 0, leftPlayerRadious = 5;
int goalFlag = 0;
SoundFile sound1;

void setup()
{
  size(800,600);

  ballPosX = width/2 - ballWidth/2;
  ballPosY = height/2 - ballHeight/2;

  rightPlayerPosX = width -60;
  rightPlayerPosY = height/2 - rightPlayerHeight;
  
  leftPlayerPosX = 40;
  leftPlayerPosY = height/2 - leftPlayerHeight;
  
  sound1 = new SoundFile ( this , "./pong_sound1.wav" ) ;


}
void draw() {  
  
  drawComponents();
  
  testIfTouching();
 
}

void drawComponents(){
  background(backgroundColor);
  drawPlayers();
  drawMarker();
  if(goalFlag>0){
    ballPosX = width/2 - ballWidth/2;
    ballPosY = height/2 - ballHeight/2;
    drawGoalMessage();
    goalFlag--;
  } else {
    drawBall();
  }
}

void drawBall(){
  stroke(255,0,0);
  strokeWeight(1);
  fill(255,0,0);
  moveBall(displacement, directionX, directionY);
  ellipse(ballPosX, ballPosY, ballWidth, ballHeight);
}

void drawPlayers(){
  moveRightPlayer();
  moveLeftPlayer();
  drawRightPlayer();
  drawLeftPlayer();
}

void drawRightPlayer(){
  fill(255);
  stroke(0,0,255);
  strokeWeight(1);
  rect(rightPlayerPosX, rightPlayerPosY, rightPlayerWidth, rightPlayerHeight, rightPlayerRadious); 
}

void drawLeftPlayer(){
  fill(255);
  stroke(0,255,0);
  strokeWeight(1);
  rect(leftPlayerPosX, leftPlayerPosY, leftPlayerWidth, leftPlayerHeight, leftPlayerRadious);
}

void moveRightPlayer(){

  if (keyPressed) {
    if (key == 'w' || key == 'W') {
      leftPlayerPosY = leftPlayerPosY - 10; 
    }
    if (key == 's' || key == 'S') {
      leftPlayerPosY = leftPlayerPosY + 10; 
    }

  }
}

void moveLeftPlayer(){
  rightPlayerPosY = mouseY -30; 
}
void moveBall(int displacement, int directionX, int directionY){
  ballPosX = ballPosX + directionX*displacement;
  ballPosY = ballPosY + directionY*displacement;
}


void drawMarker(){
  fill(255);
  textSize(30);
  text(leftPlayerMarker + " - " + rightPlayerMarker, width/2 - 50 , 40);
}

void setGoalFlag(){
  goalFlag = 40;
}

void drawGoalMessage(){
  fill(255);
  textSize(60);
  text("GOAL" , width/2-70, height/2) ;
}

boolean touchingRightWall(){
  return (ballPosX + ballWidth/2 > width);
}
boolean touchingLeftWall(){
  return (ballPosX - ballWidth/2 < 0);
}
boolean touchingDownWall(){
  return (ballPosY <= 0); 
}
boolean touchingTopWall(){
  return (ballPosY >= height); 
}
void changeDirectionX(){
  directionX = -directionX ;
}
void changeDirectionY(){
  directionY = -directionY ;
}
void addPointToRightPlayer(){
  rightPlayerMarker++;
}
void addPointToLeftPlayer(){
  leftPlayerMarker++;
}

void testIfTouching(){
  if (touchingPlayer()){
    changeDirectionX();
  } else if (touchingRightWall()){
    changeDirectionX();
    addPointToLeftPlayer();
    setGoalFlag();
  } else if (touchingLeftWall()){
    changeDirectionX();
    addPointToRightPlayer();
    setGoalFlag();
  } else if (touchingTopWall()){
    changeDirectionY();
  } else if (touchingDownWall()){
    changeDirectionY();
  } else if (touchingPlayer()){
    changeDirectionX(); 
  }
}

boolean touchingPlayer(){
  if( ballPosY >=  rightPlayerPosY - rightPlayerRadious
    && ballPosY <= rightPlayerPosY + rightPlayerHeight + rightPlayerRadious
    && ballPosX >= rightPlayerPosX - rightPlayerRadious/2 
    && ballPosX <= rightPlayerPosX + rightPlayerWidth + rightPlayerRadious/2) 
  {
    sound1.play();
    return true;
  } else if(ballPosY >=  leftPlayerPosY - leftPlayerRadious
  && ballPosY <= leftPlayerPosY + leftPlayerHeight + rightPlayerRadious
  && ballPosX >= leftPlayerPosX - leftPlayerRadious/2
  && ballPosX <= leftPlayerPosX + leftPlayerWidth + leftPlayerRadious/2)
  {
    sound1.play();
    return true;
  }
  return false;
}
