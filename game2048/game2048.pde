import java.util.Stack;
import processing.sound.*;

SoundFile cheerFile;
SoundFile gameOverFile;

int score = 0;
int side = 4;
int [][] tiles = new int [side][side];
int pad = 20, bs = 100; 
int len = pad*(side+1)+bs*side;
int target = 2048;
int highest = 2;

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
//Default processing function 
void setup() {
  size(500, 500); //size(len, len);
  undoButton = new Button("Undo", undoButtonX, undoButtonY, undoButtonWidth, undoButtonHeight);
  redoButton = new Button("Redo", redoButtonX, redoButtonY, redoButtonWidth, redoButtonHeight);
  restart();
  surface.setResizable(true);
  textFont(createFont("Courier", 40));
  cheerFile = new SoundFile(this, "Cheering.mp3");
  gameOverFile = new SoundFile(this, "GameOver.mp3");
}
// Set the score and tiles to initial state.
void restart() {
  tiles = new int[side][side];
  spawn();
  spawn();
  undoStack.push(tiles);
  score = 0;
  highest = 2;
  gameState = State.running;
}
//This cretes a new tile and puts it in a random empty spot on the board
void spawn() 
{
  ArrayList<Integer> xs = new ArrayList<Integer>(), ys = new ArrayList<Integer>();
  for (int j = 0 ; j < side; j++) 
  {
    for (int i = 0 ; i < side; i++) 
    {
      if (tiles[j][i]==0) 
      {
        xs.add(i);
        ys.add(j);
      }
    }
  }
  int rand = (int)random(0, xs.size());
  int y = ys.get(rand);
  int x = xs.get(rand);
  tiles[y][x] = random(0, 1) < .9 ? 2 : 4;
}
//This is a default Processing function that continiously draws - paints items on the board.
void draw() {
  background(255);
  noStroke();
  //rectt(undoButtonX,undoButtonY,undoButtonWidth, undoButtonHeight,10, color(gridColor));
  
  rectt(0,0,width,height,10,color(gridColor));
  for (int j = 0 ; j < side; j++) 
    for (int i = 0 ; i < side; i++) {
      fill(color(emptyColor));
      rect(pad+(pad+bs)*i, pad+(pad+bs)*j, bs, bs, 5);
    }
  for (int j = 0 ; j < side; j++) 
    for (int i = 0 ; i < side; i++) {
      float x = pad+(pad+bs)*i, y=pad+(pad+bs)*j;
      if (tiles[j][i] > 0) {
        rectt(x, y, bs, bs, 5, colorTable[(int) (Math.log(tiles[j][i]) / Math.log(2)) + 1]);
        textt(""+tiles[j][i], x, y + 22, bs, bs, color(0), 40, CENTER);
      }
    }
    
  if (undoButton.buttonPressed() && !undoStack.empty()) 
  {
    tiles = undoStack.pop();
    redoStack.push(tiles);
    //if(!undoStack.empty())
    //  tiles = undoStack.pop();
    for(int i = 0; i < 4; i++)
    {
      for(int j = 0; j < 4; j++)
      {
        print(tiles[i][j]);
      }
    } 
    draw();
  }  
  
  if (redoButton.buttonPressed() && !redoStack.empty()) 
  {
    tiles = redoStack.pop();
    undoStack.push(tiles);
    draw();
  }  
    
  undoButton.Draw();
  redoButton.Draw();
  
  textt("score: "+score,10,5,100,50,color(0),10.0, LEFT);
  if(gameState == State.over) { 
    rectt(0,0,width,height,0,color(255,100)); 
    textt("Gameover! Click to restart", 0,height/2,width,50,color(0),30,CENTER); 
    gameOverFile.play();
    if(mousePressed) restart(); 
  }
  if(gameState == State.won) { 
    rectt(0,0,width,height,0,color(255,100)); 
    textt("You won! Click to restart", 0,height/2,width,50,color(0),30,CENTER); 
    cheerFile.play();
    if(mousePressed) restart(); 
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

//detects the key presses on the keyboard
void keyPressed() {
  if (gameState == State.running) {
    //int dy=keyCode==UP ? -1 : (keyCode==DOWN ? 1 : 0), dx=keyCode==LEFT ? -1 : (keyCode==RIGHT ? 1 : 0); 
    undoStack.push(tiles);
    int[][] newb = null ;
    if(keyCode == UP)
    {
      newb = moveUp();
      redoStack.clear();
    }
    else if(keyCode == DOWN)
    {
      newb = moveDown();
      redoStack.clear();
    }
     else if(keyCode == LEFT)
     {
      newb = moveLeft(); 
      redoStack.clear();
     }
    else if(keyCode == RIGHT)
    {
      newb = moveRight();
      redoStack.clear();
    }
    if (newb != null) 
    {
      tiles = newb;
      spawn();
      for(int i = 0; i < side; i++)
      {
        for(int j = 0; j < side; j++)
        {
          if(newb[i][j] > highest)
            highest = newb[i][j];
        }
      }
    }
    if(gameover()) 
      gameState = State.over;
    if(highest == target)
      gameState = State.won;
  }
}

//checks if there is any move available
boolean gameover() {
  int[] dx = {1, -1, 0, 0}, dy = {0, 0, 1, -1};
  boolean out = true;
  for (int i = 0 ; i < 4; i++) 
  {
    if (go(dy[i], dx[i], false) != null) 
      out = false;
  }
  return out;
}


int[][] moveUp() {
  return go(-1, 0, true);
}
 
int[][] moveDown() {
   return go(1, 0, true);
}
 
int[][] moveLeft() {
   return go(0, -1, true);
}
 
int[][] moveRight() {
   return go(0, 1, true);
}

//Algortihm for movement. 
int[][] go(int dy, int dx, boolean updatescore) 
{
     int[][] copyBoard = new int[4][4];
     for (int j = 0 ; j < 4; j++) 
     {
       for (int i = 0 ; i < 4; i++) 
       {
         copyBoard[j][i] = tiles[j][i];
       }
     }
     boolean moved = false; 
     if (dx != 0 || dy != 0) 
     {
        int d =  dx != 0 ? dx : dy;
        for (int perp = 0; perp < side; perp++) 
        {
          for (int tang = (d > 0 ? side - 2 : 1); tang != (d > 0 ? -1 : side); tang-=d) 
          {
              int y = dx != 0 ? perp : tang, x = dx != 0 ? tang : perp, ty = y, tx = x;
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
                copyBoard[ty][tx] *= 2;
                if(updatescore) score += copyBoard[ty][tx];
                  moved = true;
              }
              else if ( (dx != 0 && tx != x) || (dy != 0 && ty != y)) 
              {
                copyBoard[ty][tx] = copyBoard[y][x];
                moved = true;
              }
              if (moved) 
                copyBoard[y][x] = 0;
           } 
        }
      }
  
  return moved ? copyBoard : null;
 }
 
