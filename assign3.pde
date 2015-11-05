//You should implement your assign2 here.

PImage bgImg, bgImg2, appearanceImg, treasureImg, fighterImg, startImg1, startImg2, endImg1, endImg2;
int treasureX, treasureY, enemyX=0, enemyY, hpX, bgX=640, bgX2=0, gameState, fighterX, fighterY, fighterSpeed, enemySpeedX, enemySpeedY;
final int GAME_START=1, GAME_RUN=2, GAME_OVER=3;
PImage[] enemyImg=new PImage[5];

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

void setup () {
  size(640,480) ;  // must use this size.
  // my code
  startImg2 = loadImage("img/start2.png");
  startImg1 = loadImage("img/start1.png");
  endImg2 = loadImage("img/end2.png");
  endImg1 = loadImage("img/end1.png");
  bgImg = loadImage("img/bg1.png");
  bgImg2 = loadImage("img/bg2.png");
  appearanceImg = loadImage("img/hp.png");
  treasureImg = loadImage("img/treasure.png");
  enemyImg[0] = loadImage("img/enemy.png");
  fighterImg = loadImage("img/fighter.png");
  treasureX = floor(random(640));
  treasureY = floor(random(300));
  hpX = 40;
  gameState = GAME_START;
  enemyX = 0;
  enemyY = floor(random(430));
  fighterX = 580;
  fighterY = 240;
  enemySpeedX = int(random(5))+3;
  enemySpeedY = int(random(3))+3; 
  fighterSpeed = 5;
}

void draw() {
  // my code
  
  switch(gameState){
    case GAME_START:
        if (mouseY > 370 && mouseY < 410 && mouseX > 200 && mouseX < 450){
          image(startImg1,0,0);
          if (mousePressed){
            // click
            gameState = GAME_RUN;
          }
        }else{   
          image(startImg2,0,0);
        }
        break;
        
    case GAME_RUN:
        
        if(enemyX%640==639){
            enemySpeedX = int(random(5))+3;  
            //enemySpeedY = int(random(3))+1;  
        }
        
        /*if(enemyY>fighterY){
            enemyY-=enemySpeedY;
        }
        if(enemyY<fighterY){
            enemyY+=enemySpeedY;
        }*/
    
        bgX++;
        bgX2++;
        image(bgImg,640-(bgX%1280),0);
        image(bgImg2,640-(bgX2%1280),0);
        image(treasureImg,treasureX,treasureY);

         if((int)enemyX%2080>=2070 && (int)enemyX%2080<=2080){
                  enemyY = floor(random(430));
                  enemyX+=enemySpeedX;
         }else if(enemyX%3120>=2080 && enemyX%3120<=3120){
             for(int i=0,x=0,y=0;i<5;i++,x+=80,y+=40){
               if(y%240>=120 && y%280<=280){
                  y-=80;
                  image(enemyImg[0],(enemyX-x)%1040,enemyY-(y%120));
                  image(enemyImg[0],(enemyX-x)%1040,enemyY+(y%120));
                  y-=80;
               }else{
                  image(enemyImg[0],(enemyX-x)%1040,enemyY+(y%120));
                  image(enemyImg[0],(enemyX-x)%1040,enemyY-(y%120));
               }
             }
             image(enemyImg[0],(enemyX+=enemySpeedX)%1040,enemyY);
         }else if(enemyX%2080>=1040 && enemyX%2080<=2080){
             for(int i=0,x=0,y=0;i<5;i++,x+=80,y+=20){
                  image(enemyImg[0],(enemyX-x)%1040,enemyY+y);
             }
             image(enemyImg[0],(enemyX+=enemySpeedX)%1040,enemyY);
         }else{
             for(int i=0,x=0;i<5;i++,x+=80){
                  image(enemyImg[0],(enemyX-x)%1040,enemyY);
             }
             image(enemyImg[0],(enemyX+=enemySpeedX)%1040,enemyY);
         }
         
        //appearance

        stroke(0);
        fill(30, 255, 0);
        rect(10, 5, hpX, 25);
        image(appearanceImg,5, 5);
        image(fighterImg,fighterX,fighterY);
        
        //end appearance
        
        //

       if( upPressed)
       {
       if(fighterY>=1){
           fighterY -= fighterSpeed;
         }
       }

       if( downPressed)
       {
       if(fighterY<=420){
           fighterY += fighterSpeed;
         }
       }

       if( leftPressed)
       {
       if(fighterX>=0){
           fighterX -= fighterSpeed;
         }
       }

       if( rightPressed)
       {      
       if(fighterX<=600){
           fighterX += fighterSpeed;
         }
       }
         
        //
        
        /*if(fighterX+29 >= (enemyX)%640 && fighterX <= (enemyX+30)%640 && fighterY+50 >= enemyY && fighterY <= enemyY+50 ){
          enemyX = 0;
          enemyY = int(random(430));
          enemySpeedX = int(random(5))+1;
          enemySpeedX = int(random(3))+1;
          hpX -= 40;
          if(hpX<=0){
            gameState=GAME_OVER;
          }
        }*/
        
         if(fighterX+29 >= treasureX && fighterX <= treasureX+30 && fighterY+49 >= treasureY && fighterY <= treasureY+50 ){
          treasureX = floor(random(430));
          treasureY = floor(random(430));
          hpX += 20;
          if(hpX>200){
            hpX=200;
          }
        }
        
        break;
        
    case GAME_OVER:
        if (mouseY > 310 && mouseY < 350 && mouseX > 200 && mouseX < 450){
          image(endImg1,0,0);
          if (mousePressed){
            // click
            gameState = GAME_RUN;
            hpX = 80;
            enemyX=0;
            enemyY = floor(random(430));
            enemySpeedX = int(random(5))+1;
            enemySpeedY = int(random(3))+1;
            fighterX=600;
          }
        }else{   
          image(endImg2,0,0);
        }
        break;
  }
}
void keyPressed(){
  if (key == CODED) { // detect special keys 
    switch (keyCode) {
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
}
void keyReleased(){
  if (key == CODED) {
      switch (keyCode) {
        case UP:
          upPressed = false;
          break;
        case DOWN:
          downPressed = false;
          break;
        case LEFT:
          leftPressed = false;
          break;
        case RIGHT:
          rightPressed = false;
          break;
      }
  }
   
}
