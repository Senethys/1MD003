import java.util.Stack;
import processing.sound.*;
import java.awt.*;

SoundFile cheerFile;
SoundFile gameOverFile;
SoundFile woodFile;

//Get the screen size of the device.
Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
int screenSizeY = (int)screenSize.getHeight();
int screenSizeX = (int)screenSize.getWidth();


int side = 4;
int target = 2048;
int highest = 2;
int[][] board = new int[side][side];
int [][] copyBoard = new int[side][side];
int [][] prev[] = new int[side][side][3];
// pad = Distance between tiles
// bs = sie of the tiles            //100
int pad = (screenSizeX / 30) , bs = (screenSizeX - screenSizeY) / 5, len = pad * (side+1)+ bs * side, score = 0, animStart, animLength = 10;

float undoButtonX = 70 , undoButtonY = 5, undoButtonWidth = 50, undoButtonHeight = 10;
float redoButtonX = 140 , redoButtonY = 5, redoButtonWidth = 50, redoButtonHeight = 10;
Button undoButton, redoButton;

Stack<int[][]> undoStack = new Stack();
Stack<int[][]> redoStack = new Stack();

color[] colorTable = {
        color(232, 248, 245),color(232, 248, 245), color(209, 242, 235),  color(163, 228, 215),  
        color(118, 215, 196), color(72, 201, 176), color(26, 188, 156), color(23, 165, 137),
        color(20, 143, 119), color(17, 120, 100), color(14, 98, 81),
        color(17, 122, 101), color(14, 102, 85)};

color buttonColor = color(81, 46, 95);
color gridColor = color(229, 231, 233);
color emptyColor = color(232, 248, 245);

//Different states throughout the game.
enum State 
{
   start, won, running, over
}

State gameState = State.start;



void settings() {
  size(screenSizeX / 2, screenSizeY);
  undoButton = new Button("Undo", undoButtonX, undoButtonY, undoButtonWidth, undoButtonHeight);
  redoButton = new Button("Redo", redoButtonX, redoButtonY, redoButtonWidth, redoButtonHeight);
  cheerFile = new SoundFile(this, "Cheering.mp3");
  gameOverFile = new SoundFile(this, "GameOver.mp3");
  woodFile = new SoundFile(this, "wood.wav"); //ADD THIS SOUND EFFECT TO COLLISION
  restart();

  println(screenSizeY," ", screenSizeX);
  print((screenSizeX - screenSizeY) / 5);
}
void setup() {
    //This option only works with setup();
  textFont(createFont("Courier",50));
}
void restart() {
  board = new int[4][4];
  copyBoard = new int[4][4];
  spawn();
  spawn();
  undoStack.push(board);
  score = 0;
  highest = 2;
  gameState = State.running;
}

void spawn() {
  ArrayList<Integer> xs = new ArrayList<Integer>(), ys = new ArrayList<Integer>();
  for (int j = 0 ; j < side; j++) for (int i = 0 ; i < side; i++) if (board[j][i]==0) {
    xs.add(i);
    ys.add(j);
  }
  int rnd = (int)random(0, xs.size()), y = ys.get(rnd), x = xs.get(rnd);
  board[y][x] = random(0,1) < .5 ? 2 : 4;
  prev[y][x][0] = -1;
}

void draw() {
  background(255);
  noStroke();
  rectt(0, 0, width, height, 10, color(gridColor));
  for (int j = 0 ; j < side; j++) {
    for (int i = 0 ; i < side; i++) 
    {
      fill(color(emptyColor));
      rect(pad+(pad+bs)*i, pad+(pad+bs)*j, bs, bs, 5);
    }
  }
  float gscore = 0, textvoff = 22;
  
  for (int j = 0 ; j < side; j++) {
    for (int i = 0 ; i < side; i++) {
      float xt = pad+(pad+bs)*i, yt = pad+(pad+bs)*j;
      float x = xt, y=yt;
      int val = board[j][i];
      float dur = (frameCount - animStart)*1.0/animLength;
      
      if (frameCount - animStart < animLength && prev[j][i][0]>0) 
      {
        int prevy = pad+(pad+bs)*prev[j][i][1];
        int prevx = pad+(pad+bs)*prev[j][i][2];
        x = (x - prevx)*dur + prevx;
        y = (y - prevy)*dur + prevy;
        if (prev[j][i][0]>1) 
        {
          val = prev[j][i][0];
          fill(colorTable[(int) (Math.log(board[j][i]) / Math.log(2)) + 1]);
          rect(xt, yt, bs, bs, 5); 
          fill(0);
          textAlign(CENTER);
          textSize(40);
          text(""+prev[j][i][0], xt, yt + textvoff, bs, bs);
        }
      }
      
      if (frameCount - animStart > animLength || prev[j][i][0] >= 0) 
      {
        if (prev[j][i][0]>=2) {
          float grow = abs(0.5-dur)*2;
          if(frameCount - animStart > animLength*3) grow = 1;
          else gscore = grow;
          fill(0,0,255,100); // draws the blue thing around the tile after collision
          rect(x-2*grow, y-2*grow, bs+4*grow, bs+4*grow, 5);
        }
        else  if (prev[j][i][0]==1) {
          fill(255,100);
          rect(x-2, y-2, bs+4, bs+4, 5);
        }
        fill(200);
        if (val > 0) {
          fill(colorTable[(int) (Math.log(board[j][i]) / Math.log(2)) + 1]);
          rect(x, y, bs, bs, 5);
          fill(0);
          textAlign(CENTER);
          textSize(40);
          text(""+val, x, y + textvoff, bs, bs);
        }
      }
      
    }
  }
  
  undoButton.Draw();
  redoButton.Draw();
  
  textt("score: "+score,10,5,100,50,color(0),10.0, LEFT);
  if(gameState == State.over) { 
    rectt(0,0,width,height,0,color(255,100)); 
    textt("Gameover! Click to restart", 0,height/2,width,50,color(0),30,CENTER); 
    gameOverFile.play();
    if(mousePressed) {
      gameOverFile.stop();
      restart(); 
    }
  }
  if(gameState == State.won) { 
    rectt(0,0,width,height,0,color(255,100)); 
    textt("You won! Click to restart", 0,height/2,width,50,color(0),30,CENTER); 
    cheerFile.play();
    if(mousePressed)
    {
      cheerFile.stop();
      restart(); 
    }
  }
}

//This specifies the drawing of a tile.
void rectt(float x, float y, float w, float h, float r, color c) 
{ 
  fill(c); 
  rect(x,y,w,h,r);  
}

//This specifies the drawing of the numbers in the tiles.
void textt(String t, float x, float y, float w, float h, color c, float s, int align) 
{
  fill(c); 
  textAlign(align); 
  textSize(s); 
  text(t,x,y,w,h);  
}

void mousePressed()
{
  if (undoButton.buttonPressed() && !undoStack.empty()) 
  {
    board = undoStack.pop();
    redoStack.push(board);
    draw();
  }  
  
  if (redoButton.buttonPressed() && !redoStack.empty()) 
  {
    board = redoStack.pop();
    undoStack.push(board);
    draw();
  }  
}

void keyPressed() {
  if(gameState == State.running) {
    int dy=keyCode==UP ? -1 : (keyCode==DOWN ? 1 : 0), dx=keyCode==LEFT ? -1 : (keyCode==RIGHT ? 1 : 0);
    undoStack.push(board);
    int[][] newBoard = null;
    
    if(keyCode == UP)
    {
      newBoard = moveUp();
      redoStack.clear();
    }
    else if(keyCode == DOWN)
    {
      newBoard = moveDown();
      redoStack.clear();
    }
     else if(keyCode == LEFT)
     {
      newBoard = moveLeft(); 
      redoStack.clear();
     }
    else if(keyCode == RIGHT)
    {
      newBoard = moveRight();
      redoStack.clear();
    }
    
    if (newBoard != null) {
      redoStack.clear();
      board = newBoard;
      spawn();
      for(int i = 0; i < side; i++)
      {
        for(int j = 0; j < side; j++)
        {
          if(newBoard[i][j] > highest)
            highest = newBoard[i][j];
        }
      }
    }
    if(gameover()) 
      gameState = State.over;
    if(highest == target)
      gameState = State.won;
  }
}

int[][] moveUp() {
  return go(-1, 0);
}
 
int[][] moveDown() {
   return go(1, 0);
}
 
int[][] moveLeft() {
   return go(0, -1);
}
 
int[][] moveRight() {
   return go(0, 1);
}

boolean gameover() 
{
  int[] dx = {    1, -1, 0, 0  } ;
  int[] dy = {    0, 0, 1, -1  };
  int[][][] prevbak = prev;
  boolean out = true;
  int prevscore = score;
  for (int i = 0 ; i < 4; i++) 
  {
    if (go(dy[i], dx[i]) != null) 
      out = false;
  }
 
  prev = prevbak;
  score = prevscore;
  return out;
}
int[][] go(int dy, int dx) 
{
  int[][] copyBoard = new int[4][4];
  for (int j = 0 ;j < 4; j++) 
  {
    for (int i = 0 ; i < 4; i++) 
    {
      copyBoard[j][i] = board[j][i];
    }
  }
  prev = new int[4][4][3];
  boolean moved = false; 
  if (dx != 0 || dy != 0) 
  {
    int d =  dx != 0 ? dx : dy;
    for (int perp = 0; perp < side; perp++) 
    {
      for (int along = (d > 0 ? side - 2 : 1); along != (d > 0 ? -1 : side); along-=d) 
      {
        int y = dx != 0 ? perp : along, x = dx != 0 ? along : perp, ty = y, tx = x;
        if (copyBoard[y][x]==0) continue;
        for (int i=(dx != 0 ? x : y)+d; i!= (d > 0 ? side : -1); i+=d) 
        {
          int r = dx != 0 ? y : i, c = dx != 0 ? i : x;
          if (copyBoard[r][c] != 0 && copyBoard[r][c] != copyBoard[y][x]) 
            break;
          if (dx != 0) 
            tx = i; 
          else 
            ty = i;
        }
        if ( (dx != 0 && tx == x) || (dy != 0 && ty == y)) 
          continue;
        else if (copyBoard[ty][tx]==copyBoard[y][x]) 
        {
          prev[ty][tx][0] = copyBoard[ty][tx];          
          copyBoard[ty][tx] *= 2;
          score += copyBoard[ty][tx];
          moved = true;
        }
        else if ( (dx != 0 && tx != x) || (dy != 0 && ty != y)) 
        {
          prev[ty][tx][0] = 1;
          copyBoard[ty][tx] = copyBoard[y][x];
          moved = true;
        }
      if (moved) 
      {
        prev[ty][tx][1] = y;
        prev[ty][tx][2] = x;
        copyBoard[y][x] = 0;
      }
    }
   }
  }
  if (!moved) return null;
  animStart = frameCount;
  return copyBoard;
}
