import java.util.concurrent.ThreadLocalRandom;
import java.io.FileReader;
import processing.sound.*;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

Grid grid;
Cell[][] cells;
ArrayList<Block> blockList = new ArrayList<Block>();
ArrayList<Digit> digitList = new ArrayList<Digit>();
PFont font;
int score, browns;
boolean isPaused, mainMenu, game, themeScreen, store, quit, scores, about;
int theme;
PImage sloth,bird,lion, roh, be, sha, drakePic, bold, musicMute, musicUnmute; 
sprit body_s, body_b, body_l; 
head rohan, ben, shakk;  
Coin coin;
SoundFile levelup_noise, ding_noise,file, redFile, greenFile, blueFile, drakeFile, drakeBitFile;  
String path, audio1= "b1.mp3", audio2= "b2.mp3", audio3 = "b3.mp3"; 
String  leveluppath, dingpath, ding = "Ding.mp3", levelup="rise.mp3";
String redLocation = "redMusic.mp3", greenLocation = "greenMusic.mp3", blueLocation = "blueMusic.mp3";
String drakeLocation = "drakeMusic.mp3", drakeBitLocation = "drakeBit.mp3";
String redPath, greenPath, bluePath, drakePath, drakeBitPath;
boolean isPlaying; 
boolean muted_noise, music; 
boolean rMusicPlay, gMusicPlay, bMusicPlay, dMusicPlay;
PImage unmuted, muted;

String[] scoresList = new String[5];  
String fileName = "scores.txt";  
String outputList;
String oldScores;
boolean scoreChecks;
boolean writeOnce = true;


void setup(){
  size(1200,900);
  theme = 1;
  mainMenu = true;
  game = false;
  store = false;
  scores = false;
  themeScreen = false;
  quit = false;
  about = false;
  music = true;
 
  score = 0;
  browns = 10;
  isPaused = false;
  frameRate(60);
  
  rMusicPlay = false;
  gMusicPlay = false;
  bMusicPlay = false;
  dMusicPlay = false;
  
  cells = new Cell[4][4];
  grid = new Grid(theme);
  grid.generate();
  grid.generate();
   
  for (int i = 0; i < 3; i++){
    int randomNum = ThreadLocalRandom.current().nextInt(0, 12);
    blockList.add(i, new Block(randomNum*100, 0, 2, theme));
  }
    
  smooth();  
  sloth = loadImage("sloth.png");
  bird= loadImage("bird.png");
  lion= loadImage("lion.png");
  drakePic = loadImage("drakePic.jpg");
  bold = loadImage("bold.png");
  musicMute = loadImage("musicMute.jpg");
  musicUnmute = loadImage("musicUnmute.png");
  sloth.resize(150,150);
  bird.resize(150,150);
  lion.resize(150,150);
  body_s = new sprit(sloth, 0,170, .5,0);
  body_l = new sprit(lion, 0,560, .5,0);
  body_b = new sprit(bird, 0,340, .5,0);
    
  roh = loadImage("rohan_right.PNG"); 
  roh.resize(90,90);
  be = loadImage("ben_right.png");
  be.resize(100,100); 
  sha = loadImage("shakk_right.png"); 
  sha.resize(90,90);
  
  drakePic.resize(1500,900);
  musicMute.resize(50, 50);
  musicUnmute.resize(50, 50);
    
  rohan = new head(roh, body_b.location.x + 10, body_b.location.y - 40, 10,170); 
  ben = new head(be, body_l.location.x + 10, body_l.location.y - 40, 10,170); 
  shakk = new head(sha, body_s.location.x + 10, body_s.location.y - 40, 10,170); 
  font = createFont("Tw Cen MT Condensed Extra Bold", 32);
  textFont(font);
  coin = new Coin("coin_", 42);
  
  isPlaying = true;
  
  dingpath = sketchPath(ding) ; 
  ding_noise = new SoundFile(this,dingpath);
  leveluppath = sketchPath(levelup); 
  levelup_noise = new SoundFile(this,leveluppath); 
  
  redPath = sketchPath(redLocation);
  redFile = new SoundFile(this, redPath);
  greenPath = sketchPath(greenLocation);
  greenFile = new SoundFile(this, greenPath);
  bluePath = sketchPath(blueLocation);
  blueFile = new SoundFile(this, bluePath);
  
  drakePath = sketchPath(drakeLocation);
  drakeFile = new SoundFile(this, drakePath);
  drakeBitPath = sketchPath(drakeBitLocation);
  drakeBitFile = new SoundFile(this, drakeBitPath);
    
  muted_noise = false; 
  muted = loadImage("muted.png"); 
  unmuted = loadImage("unmuted.png");
  
  redFile.stop();
  greenFile.stop();
  blueFile.stop();
}

void draw(){
  
  highscore();
  for (int i = 0; i < cells.length; i++){
    for (int j = 0; j < cells[i].length; j++){
      if (cells[i][j].theme != theme){
        cells[i][j].theme = theme;
      }
    }
  }
  grid.theme = theme;
  
  if (theme == 1){
    if (!rMusicPlay){
      redFile.loop();
      greenFile.stop();
      blueFile.stop();
      drakeFile.stop();
      rMusicPlay = true;
      gMusicPlay = false;
      bMusicPlay = false;
      dMusicPlay = false;
    }
  }  
  if (theme == 2){
    if (!gMusicPlay){
      greenFile.loop();
      redFile.stop();
      blueFile.stop();
      drakeFile.stop();
      gMusicPlay = true;
      rMusicPlay = false;
      bMusicPlay = false;
      dMusicPlay = false;
    }
  }
  if (theme == 3){
    if (!bMusicPlay){
      blueFile.loop();
      redFile.stop();
      greenFile.stop();
      drakeFile.stop();
      bMusicPlay = true;
      rMusicPlay = false;
      gMusicPlay = false;
      dMusicPlay = false;
    }
  }
  if (theme == 4){
    if (!dMusicPlay){
      drakeFile.loop();
      redFile.stop();
      greenFile.stop();
      blueFile.stop();
      dMusicPlay = true;
      rMusicPlay = false;
      gMusicPlay = false;
      bMusicPlay = false;
    }
  }
  
  if (music){
    drakeFile.amp(1);
    redFile.amp(1);
    greenFile.amp(1);
    blueFile.amp(1);
  }else{
    drakeFile.amp(0);
    redFile.amp(0);
    greenFile.amp(0);
    blueFile.amp(0);
  }
        
  if (about){
    if (theme == 1){
      background(152,21,27);
    }
    if (theme == 2){
      background(29, 196, 18);
    }
    if (theme == 3){
      background(21,27,152);
    }
    if (theme == 4){
      background(224,187,0);
      image(bold, 0, 0);
    }
    
    strokeWeight(4);
    
    fill(buttonColor(theme, 890, 890+275, 790, 790+95)[0], buttonColor(theme, 890, 890+275, 790, 790+95)[1], buttonColor(theme, 890, 890+275, 790, 790+95)[2]);
    rect(890, 790, 275, 95);
    
    fill(255);
    textSize(80);
    text("back", 960, 865);
    textSize(130);
    text("about us", 380, 110);
    
    textSize(30); 
    text("Project by: Shakkhar Biswas, Rohan Chaudhry, Benjamin Wondwossen\nMWF9a\nBold & Brown",30,800); 
    
    body_s.update(); 
    shakk.update(body_s.location.x ,body_s.location.y );
    body_s.display(); 
    shakk.display(); 
   
    body_b.update(); 
    rohan.update(body_b.location.x ,body_b.location.y);
    body_b.display();
    rohan.display(); 
     
    body_l.update(); 
    ben.update(body_l.location.x  ,body_l.location.y);
    body_l.display(); 
    ben.display(); 
  }
  
  if(scores){
    if (theme == 1){
      background(152,21,27);
    }
    if (theme == 2){
      background(29, 196, 18);
    }
    if (theme == 3){
      background(21,27,152);
    }
    if (theme == 4){
      background(224,187,0);
      image(drakePic, -200, 0);
    }
    
    strokeWeight(4);
    
    fill(buttonColor(theme, 890, 890+275, 790, 790+95)[0], buttonColor(theme, 890, 890+275, 790, 790+95)[1], buttonColor(theme, 890, 890+275, 790, 790+95)[2]);
    rect(890, 790, 275, 95);
    
    fill(255);
    textSize(80);
    text("back", 960, 865);
    textSize(130);
    text("highscores", 340, 110);
    
    String[] lines = loadStrings(fileName);
    //println("there are " + lines.length + " lines");
    int startY = height/2-190;
    for (int i = 0 ; i < lines.length; i++) {
      text(lines[i],(width/2) -110,startY);
      startY = startY+120;
    }
  }
  
  if (store){
    if (theme == 1){
      background(152,21,27);
    }
    if (theme == 2){
      background(29, 196, 18);
    }
    if (theme == 3){
      background(21,27,152);
    }
    if (theme == 4){
      background(224,187,0);
      image(drakePic, -200, 0);
    }
    
    strokeWeight(7);
    if (theme == 1){
      fill(255,0,0);
    }
    if (theme == 2){
      fill(0, 255, 0);
    }
    if (theme == 3){
      fill(0,0,255);
    }
    if (theme == 4){
      fill(245,229,47);
    }
    rect(15, 145, 550, 745);
    rect(15, 25, 550, 100);
    rect(590, 25, 575, 100);
    rect(590, 145, 575, 625);
    
    strokeWeight(0);
    if (theme == 1){
      fill(188, 137, 137);
    }else{
      fill(255, 93, 93);
    }
    rect(40,170,500,150);
    fill(170, 5, 5);
    textSize(85);
    text("ruby", 390, 300);
    fill(220);
    textSize(130);
    if(theme == 1){
      text("selected", 115, 285);
    }
    
    if (theme == 2){
      fill(129,173,137);
      
    }else{
      fill(45, 237, 82);
    }
    rect(40,330,500,150);
    fill(7, 167, 16);
    textSize(85);
    text("emerald", 273, 472);
    fill(220);
    textSize(130);
    if(theme == 2){
      text("selected", 115, 445);
    }
    
    if (theme == 3){
      fill(137,137,188);
    }else{
      fill(93, 93, 255);
    }
    rect(40,490,500,150);
    fill(18,54,113);
    textSize(85);
    text("sapphire", 253, 620);
    fill(220);
    textSize(130);
    if(theme == 3){
      text("selected", 115, 605);
    }
    
    if (theme == 4){
      fill(193,184,131);
    }else{
      fill(232,201,21);
    }
    rect(40,650,500,150);
    fill(155,135,20);
    textSize(85);
    text("drake",350,790);
    fill(220);
    textSize(130);
    if(theme == 4){
      text("selected", 115, 765);
    }
       
    fill(255);
    textSize(80);
    text("select theme", 95, 102);
    text("brown bucks", 685, 102);
    
    textSize(40);
    text("you have", 625, 202);
    textSize(200);
    text(""+browns, 750, 352);
    textSize(53);
    text("brown bucks", 899, 410);
    
    strokeWeight(3);
    fill(brownButton(620,620+250, 470, 470+110)[0],brownButton(620,620+250, 470, 470+110)[1], brownButton(620,620+250, 470, 470+110)[2]);
    rect(620, 470, 250, 110);
    fill(brownButton(620,620+250, 600, 600+110)[0],brownButton(620,620+250, 600, 600+110)[1], brownButton(620,620+250, 600, 600+110)[2]);
    rect(620, 600, 250, 110);
    fill(brownButton(890,890+250, 470, 470+110)[0],brownButton(890,890+250, 470, 470+110)[1], brownButton(890,890+250, 470, 470+110)[2]);
    rect(890, 470, 250, 110);
    fill(brownButton(890,890+250, 600, 600+110)[0],brownButton(890,890+250, 600, 600+110)[1], brownButton(890,890+250, 600, 600+110)[2]);
    rect(890, 600, 250, 110);
    
    fill(203,174,138);
    textSize(40);
    text("5 brown bucks", 635, 510);
    text("10 brown bucks", 895, 510);
    text("25 brown bucks", 625, 640);
    text("50 brown bucks", 895, 640);
    textSize(45);
    text("$9.99 USD", 655, 565);
    text("$24.99 USD", 909, 565);
    text("$99.99 USD", 645, 695);
    text("$499.99 USD", 905, 695);
    
    
    strokeWeight(4);
    

    fill(buttonColor(theme, 590, 590+280, 790, 790+95)[0], buttonColor(theme, 590, 590+280, 790, 790+95)[1], buttonColor(theme, 590, 590+280, 790, 790+95)[2]);
    rect(590, 790, 280, 95);
    
    fill(buttonColor(theme, 890, 890+275, 790, 790+95)[0], buttonColor(theme, 890, 890+275, 790, 790+95)[1], buttonColor(theme, 890, 890+275, 790, 790+95)[2]);
    rect(890, 790, 275, 95);
    
    fill(255);
    textSize(80);
    text("back", 960, 865);
    text("quit", 680, 865);
  }
  
  if (mainMenu){
  
    if (theme == 1){
      background(152,21,27);
    }
    if (theme == 2){
      background(29, 196, 18);
    }
    if (theme == 3){
      background(21,27,152);
    }
    if (theme == 4){
      background(224,187,0);
      image(drakePic, -200, 0);
    }
    
    for (int i = 0; i < blockList.size(); i++){
      blockList.get(i).checkEdge();
      blockList.get(i).update();
      blockList.get(i).display();
    }
    
    int randomNum = ThreadLocalRandom.current().nextInt(0, 12);
    int mili = (int)System.currentTimeMillis();
    if (mili % 10 == 0){
      int newXpos = randomNum*100;
      boolean placeable = true;
      for (int i = 0; i < blockList.size(); i++){
        if (blockList.get(i).xpos == newXpos){
          if (blockList.get(i).ypos < 100){
            placeable = false;
          }
        }
      }
      
      if (placeable){
        blockList.add(new Block(randomNum*100, 0, 2, theme));
      }
    }
    
    for (int i = 0; i < blockList.size(); i++){
      int x = blockList.get(i).xpos;
      int y = blockList.get(i).ypos;
      for (int j = 0; j < blockList.size(); j++){
        if (i != j){
          if (blockList.get(j).xpos == x){
            if (Math.abs(blockList.get(j).ypos - y) < 100){
              blockList.get(i).setSpeed(0);
            }
          }
        }
      }
    }
    
    int counter = 0;
    
    for (int i = 0; i < blockList.size(); i++){
      if (blockList.get(i).ypos >= 799){
        counter++;
      }
    }
    
    if (counter == 12){
      for (int i = 0; i < blockList.size(); i++){
        if (blockList.get(i).ypos >= 799){
          blockList.remove(i);
          i = i-1;
        }
      }
        
    }
    
    
    for (int i = 0; i < blockList.size(); i++){
      if (blockList.get(i).speed == 0){
        boolean found = false;
        for (int j = 0; j < blockList.size(); j++){
          if (i != j){
            if (blockList.get(j).xpos == blockList.get(i).xpos){
              if (blockList.get(j).ypos > blockList.get(i).ypos){
                found = true;
              }
            }           
          }
        }
        if (! found){
          blockList.get(i).setSpeed(2);
        }
      }
    }
    
    
    
    for (int i = 0; i < blockList.size(); i++){
      if ((blockList.get(i).ypos >= 699) && (blockList.get(i).ypos < 800)){
        boolean found = false;
        for (int j = 0; j < blockList.size(); j++){
          if (i != j){
            if (blockList.get(j).xpos == blockList.get(i).xpos){
              if (blockList.get(j).ypos > 798){
                found = true;
              }
            }            
          }
        }
        
        if (!found){
          blockList.get(i).setSpeed(2);
        }
      }
    }
      
    fill(255);
    textSize(250);
    text("2048",365, 220);
    textSize(30);
    text("game by Benjamin, Rohan & Shakkhar", 385, 258);
 
    fill(255);
    strokeWeight(4);
    
    fill(buttonColor(theme, 450, 450+300, 300, 300+120)[0], buttonColor(theme, 450, 450+300, 300, 300+120)[1], buttonColor(theme, 450, 450+300, 300, 300+120)[2]);    
    rect(450, 300, 300, 120);
      
    fill(buttonColor(theme, 450, 450+300, 450, 450+120)[0], buttonColor(theme, 450, 450+300, 450, 450+120)[1], buttonColor(theme, 450, 450+300, 450, 450+120)[2]);
    rect(450, 450, 300, 120);
 
    fill(buttonColor(theme, 450, 450+300, 600, 600+120)[0], buttonColor(theme, 450, 450+300, 600, 600+120)[1], buttonColor(theme, 450, 450+300, 600, 600+120)[2]);
    rect(450, 600, 300, 120);
   
    fill(buttonColor(theme, 450, 450+300, 750, 750+120)[0], buttonColor(theme, 450, 450+300, 750, 750+120)[1], buttonColor(theme, 450, 450+300, 750, 750+120)[2]);
    rect(450, 750, 300, 120);
    
    fill(buttonColor(theme, 0,0,0,0)[0], buttonColor(theme, 0,0,0,0)[1], buttonColor(theme, 0,0,0,0)[2]);
    rect(35, 770, 150, 100);
    textSize(100);
    fill(255);
    text("play", 518, 388);
    text("store", 508, 538);
    text("scores", 488, 688);
    text("about", 492, 838);
    
    coin.display(120, 787);
    textSize(60);    
    text("" + browns, 60, 830);
    textSize(22);    
    text("brown bucks", 62, 850);
    
  }
  
  
  
  
  //====================================================================GAME==================================================

  if (quit){
    exit();
  }
  if (game){
    
    if (theme == 1){
      background(152,21,27);
    }
    if (theme == 2){
      background(29, 196, 18);
    }
    if (theme == 3){
      background(21,27,152);
    }
    if (theme == 4){
      background(224,187,0);
      image(drakePic, -400, 0);
    }
    
    fill(255);
    strokeWeight(2);
    
    fill(buttonColor(theme, 10, 10+70, 10, 10+35)[0], buttonColor(theme, 10, 10+70, 10, 10+35)[1], buttonColor(theme, 10, 10+70, 10, 10+35)[2]); 
    rect(10, 10, 70, 35);
    
    fill(255);
    textSize(30);
    text("back", 18, 38);
  
    //redrawing the grid
    if (theme == 1){
      fill(98, 17, 14);
    }
    if (theme == 2){
      fill(35, 88, 14);
    }
    if (theme == 3){
      fill(24,27,95);
    }
    if (theme == 4){
      fill(147,136,16);
    }
    
    rect(150, 200, 600, 600);
    for (int i = 150; i<=750; i+=150) {
      smooth();
      stroke(255);
      strokeWeight(6);
      line(150, i + 50, 750, i +50);
      line(i, 200, i, 800);
    }
  
    font = createFont("Tw Cen MT Condensed Extra Bold", 32);
    textFont(font);
    fill(255); 
    textSize(185);
    text("2048", 270, 150);
    //String[] fontList = PFont.list();
    //printArray(fontList);
    fill(66,39,255);
    rect(900,0,300,900);
    fill(255);
    textSize(24);
    text("game by Benjamin, Rohan & Shakkhar", 270, 180);
    textSize(40);

    //SIDEBAR:
    if (theme == 1){
      fill(144, 3, 3);
    }
    if (theme == 2){
      fill(50,147,94);
    }
    if (theme == 3){
      fill(66,39,255);
    }
    if (theme == 4){
      fill(216,174,0);
    }
    strokeWeight(0);
    rect(900,0,300,900);
    fill(255);
    textSize(110);
    if (score < 10){
      text("" + score, 1120, 130);
    }
    else if (score < 100){
      text("" + score, 1070, 130);
    }
    else if (score < 1000){
      text("" + score, 1020, 130);
    }
    else if (score < 10000){
      text("" + score, 970, 130);
    }
    else{
      text("" + score, 920, 130);
    }
    textSize(50);
  
    text("points", 1065, 180);
  
    //CONTROLS:
    if (theme == 1){
      fill(183,47,20);
    }
    if (theme == 2){
      fill(116,178,131);
    }
    if (theme == 3){
      fill(46,100,255);
    }
    if (theme == 4){
      fill(216,189,79);
    }
    rect(900,240,300,220);
    textSize(35);
    fill(255);
    text("controls:", 915, 280);
    textSize(22);
    text("ARROW KEYS     move tiles", 960, 320);
    text("P     pause", 1059, 350);
    text("R     restart", 1059, 380);

    //BUTTONS:
  
    if ((mouseX > 1130) && (mouseX < 1180) && (mouseY > 830) && (mouseY < 880)){
      fill(70);
    }
    else{
      fill(0);
    }
    strokeWeight(2);
    rect(1130, 830, 50, 50);
    fill(255);
    rect(1144,840,8,30);
    rect(1158,840,8,30);
    
    rect(1005, 830, 50, 50);
    if (music){
      image(musicUnmute, 1005, 830);
    }else{
      image(musicMute, 1005, 830);
    }
  
    strokeWeight(6);
    
    if(muted_noise){                
      image(muted,1070, 830, 50,50);
      drakeBitFile.amp(0);
    } 
    else{
      image(unmuted,1070, 830, 50,50);
      drakeBitFile.amp(1);
    } 
   
    //draws the cells that have a numeric value
    for (Cell c : grid.returnOccupied(true)){
      c.drawTile();
      
      //checking player win condition:
      if (c.number == 2048) {
        fill(32, 0, 165);
        rect(200, 300, 500, 300);
        textSize(130);
        fill(255);
        text("YOU", 325, 420);
        text("WIN", 335, 558);
        
        scoreChecks = scoreCheck(str(score));
        if (scoreChecks == true){ 
          if (writeOnce);
            addNewScore(str(score));
            saveHighscore();
            writeOnce = false;
        }
        }else{
          //print("not large enough");
        }
      }
    }
  
    //checks if player lost
    if (grid.returnOccupied(true).size() >= 16) {
      if (grid.check()) {
        if (theme == 1){
          fill(175,23,23);
        }else if (theme == 2){
          fill(35,155,30);
        }else if (theme == 3){
          fill(32, 0, 165);
        }else{
          fill(201, 172, 22);
        }
        rect(200, 300, 500, 370);
        textSize(130);
        fill(255);
        text("GAME", 305, 420);
        text("OVER", 315, 558);
        textSize(40);
        text("press R to restart", 320, 628);
      }
      
      scoreChecks = scoreCheck(str(score));
        if ((scoreChecks == true)){ 
          if (writeOnce){
            addNewScore(str(score));
            saveHighscore();
            writeOnce = false;
          }
        }else{
          //print("not large enough");
        }
    }
  
    //PAUSING:
  
    if (isPaused){
      noLoop(); 
      fill(0);
      rect(200, 300, 500, 300);
      textSize(120);
      fill(255);
      text("paused", 295, 420);
      strokeWeight(2);
      fill(66,112,121);
      rect(225, 500, 200, 80);
      if((mouseX > 470) && (mouseX < 670) && (mouseY > 500) && (mouseY < 580)){
        fill(41,58,62);
      }
      else
      {
        fill(66,112,121);
      }
      rect(470, 500, 200, 80);
      fill(255);
      textSize(70);
      text("exit", 270, 558);
      textSize(50);
      text("continue", 490, 555);
    
    }
    else{
      loop();
    }
    
    if (grid.returnOccupied(true).size() <= 16 && (keyCode == UP || keyCode == DOWN|| keyCode == LEFT || keyCode == RIGHT) ) {
      grid.moveTiles();
    }
  
  
  //================================================================================================================================
  
}

void mouseClicked(){
  
  if (game){
    if(muted_noise == false){
    if ((mouseX > 1070) && (mouseX < 1120) && (mouseY > 830) && (mouseY < 880)){
        levelup_noise.amp(0); 
        print("\nMUTED\n");
        muted_noise = true; 
      }
    }
    else if(muted_noise == true){
      if ((mouseX > 1070) && (mouseX < 1120) && (mouseY > 830) && (mouseY < 880)){
        levelup_noise.amp(1); 
        print("\nUNMUTED\n");
        muted_noise = false; 
      }
    
    } 
    if (!isPaused){
      if ((mouseX > 1130) && (mouseX < 1180) && (mouseY > 830) && (mouseY < 880)){
        isPaused = true;
        print("PAUSED");
      }
    }
    else if (isPaused){
      if ((mouseX > 1130) && (mouseX < 1180) && (mouseY > 830) && (mouseY < 880)){
        isPaused = false;
        println("UNPAUSED");
        redraw();
      }
      else if((mouseX > 470) && (mouseX < 670) && (mouseY > 500) && (mouseY < 580)){
        isPaused = false;
        println("UNPAUSED");
        redraw();
      }
      else if((mouseX > 225) && (mouseX < 425) && (mouseY > 500) && (mouseY < 580)){
        isPaused = false;
        println("UNPAUSED");
        exit();
      }
    }  
  }
  
  if (mainMenu){
    if (buttonCheck(450, 450+300, 300, 300+120)){
      game = true;
      mainMenu = false;
    }
    if (buttonCheck(450, 750, 450, 570)){
      store = true;
      mainMenu = false;
    }
    if (buttonCheck(450, 450+300, 600, 600+120)){
      scores = true;
      mainMenu = false;
    }
    if (buttonCheck(450, 450+300, 750, 750+120)){
      about = true;
      mainMenu = false;
    }
  }
  
  if (store){
    if (buttonCheck(590, 590+280, 790, 790+95)){
      store = false;
      quit = true;
    }
    if (buttonCheck(890, 890+275, 790, 790+95)){
      mainMenu = true;
      store=false;
    }
    if (buttonCheck(40, 40+500, 170, 170+150)){
      if (browns > 0){
        theme = 1;
        browns -= 1;
      }
    }
    if (buttonCheck(40, 40+500, 330, 330+150)){
      if (browns > 0){
        theme = 2;
        browns -= 1;
      }
    }
    if (buttonCheck(40, 40+500, 490, 490+150)){
      if (browns > 0){
        theme = 3;
        browns -= 1;
      }
    }
    if (buttonCheck(40, 40+500, 650, 650+150)){
      if (browns > 4){
        theme = 4;
        browns -= 5;
      }
    }
    if (buttonCheck(620,620+250, 470, 470+110)){
      browns += 5;
    }
    if (buttonCheck(620,620+250, 600, 600+110)){
      browns += 25;
    }
    if (buttonCheck(890,890+250, 470, 470+110)){
      browns += 10;
    }
    if (buttonCheck(890,890+250, 600, 600+110)){
      browns += 50;
    }
  }
  
  if (scores){
    if (buttonCheck(890, 890+275, 790, 790+95)){
      mainMenu = true;
      scores=false;
    }
  }
  
  if (about){
    if (buttonCheck(890, 890+275, 790, 790+95)){
      mainMenu = true;
      about=false;
    }
  }
  
  if (game){
    if (buttonCheck(10, 10+70, 10, 10+35)){
      mainMenu = true;
      game=false;
    }
    if (buttonCheck(1005, 1005+50, 830, 830+50)){
      if (music){
        music = false;
      }else{
        music = true;
      }
    }
  }
}

void keyPressed(){
  if ((keyCode == 'P')||(keyCode == 'p')){
    isPaused = true;
    print("PAUSED");
  }
  
  if (key == 'r') {
    redFile.stop();
    greenFile.stop();
    blueFile.stop();
    drakeFile.stop();
    setup();
  }
}

boolean buttonCheck(int x1, int x2, int y1, int y2){
  
  if ((mouseX > x1) && (mouseX < x2) && (mouseY > y1) && (mouseY < y2)){
    return true;
  }else{
    return false;
  } 
}

int[] buttonColor(int theme, int x1, int x2, int y1, int y2){
  
  theme = theme - 1;
  
  int[][] unpressed = new int[][]{
    {144, 12, 7},      //theme 1 (RED)
    {92, 185, 26},     //theme 2 (GREEN)
    {40, 91, 131},     //theme 3 (BLUE)
    {222, 186, 4},     //theme 4 (DRAKE)
    
  };
  
  int[][] pressed = new int[][]{
    {196, 25, 16},      //theme 1 (RED)
    {112, 255, 31},     //theme 2 (GREEN)
    {27, 107, 175},     //theme 3 (BLUE)
    {160, 136, 16},     //theme 4 (DRAKE)
    
  };
  if (buttonCheck(x1, x2, y1, y2)){
    int r = pressed[theme][0];
    int g = pressed[theme][1];
    int b = pressed[theme][2];
    int[] result = new int[] {r, g, b};
    return result;
  }else{
    int r = unpressed[theme][0];
    int g = unpressed[theme][1];
    int b = unpressed[theme][2];
    int[] result = new int[] {r, g, b};
    return result;    
  }
}

int[] brownButton(int x1, int x2, int y1, int y2){
  int[] unpressed = new int[] {160, 95, 16};
  int[] pressed = new int[] {100, 63, 17};
  if (buttonCheck(x1,x2,y1,y2)){
    return pressed;
  }else{
    return unpressed;
  }
}

void highscore(){
  for (int i=0; i<scoresList.length; i++) {
    scoresList[i] = str(0);
  }
  
  String[] scoresAsStrings=null;
  scoresAsStrings = loadStrings(fileName);
  
  if (scoresAsStrings!=null) {
    // load was successful
    for (int i=0; i<scoresList.length; i++) {
      // put strings into scores as int 
      scoresList[i] = (scoresAsStrings[i]);
    }
  } else {
    println("New Score initialized - first run\n");
  }
} 

void addNewScore(String score) {
  // adds element when its high enough and sorts high score list. 
  for (int i=0; i<scoresList.length; i++) {
    if (score.compareTo(scoresList[i])>0) {
      for (int j=scoresList.length-1; j>=max(i, 1); j--) {
        scoresList[j] = scoresList[j-1];
      }
      scoresList[i] = score;
      break;
    }
  }
}
    
void saveHighscore() {
  // convert to string array
  String[] scoresAsStrings = new String[scoresList.length];
  for (int i=0; i<scoresList.length; i++) {
    scoresAsStrings[i]=(scoresList[i]);
  }
  // save
  saveStrings(fileName, scoresAsStrings);
}//func

boolean scoreCheck(String score){
  // test whether new score is high enough to get into the highscore 
  for (int i=0; i<scoresList.length; i++) {
    if (score.compareTo(scoresList[i])>0) { 
      return true; // high enough
    }//if
  }//for
  return false; // NOT high enough
}