// Number of columns and rows in the grid
  int cols = 4;
  int rows = 4;
  int sizeMultiplier = 40;
  
  // Matrix consisting of Cells called gameGrid
  Tile[][] gameGrid = new Tile[cols][rows];
  ArrayList<Tile> existingTiles = new ArrayList<Tile>(); 
  ArrayList<Tile> emptyTiles = new ArrayList<Tile>(); 
  
  void setup() {  
  //Set size if the window
  size(400, 260);
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      gameGrid[i][j] = new Tile(i,j);
    }
   }
   game();
 }
  
  void draw() {
    //background(0);
    for (int i = 0; i < cols; i++) {
     for (int j = 0; j < rows; j++) {  
      gameGrid[i][j].display();
      }
    }
    movementListener();
  }
  
   void randomstartingTiles() {
    int randomXOne = int(random(0, cols));
    int randomYOne = int(random(0, cols));
    int randomXTwo = int(random(0, cols));
    int randomYTwo = int(random(0, cols));
    
    if(randomXOne == randomXTwo && randomYTwo == randomYOne) {
      randomstartingTiles();
    }
    
    gameGrid[randomXOne][randomYOne].setVal(2);
    gameGrid[randomXTwo][randomYTwo].setVal(2);
    
  }
  
  void movementListener() {      
    if (keyPressed) {
      if(key == CODED) {
        if(keyCode == UP) {
          moveUp();
        } else if(keyCode == DOWN) {
          moveDown();
        } else if(keyCode == LEFT) {
          moveLeft();
        } else if(keyCode == RIGHT) {
          moveRight();
        }
      }
    }
}
  
  void game() {
    int score = 0;
    int turns = 0;
    boolean gameOver = false;

    randomstartingTiles();
    while(!gameOver) {
     move() {
     
     }
    } 
  }
  
  
    void moveUp() {
      for(int i = 0; i < existingTiles.size();i++) {
        //While there is nothing in the way, move the tile
        //but if there is, combine
        existingTiles[i].moveUp
      }
  }
    void moveDown() {
  }
    void moveLeft() {
  }
    void moveRight() {
  }
