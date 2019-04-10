// Number of columns and rows in the grid
  int cols = 4;
  int rows = 4;
  
  int sizeMultiplier = 20;
  
  // Matrix consisting of Cells called gameGrid
  Cell[][] gameGrid = new Cell[cols][rows];
  void setup() {
    
  //Set size if the window
  size(640, 260);
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      gameGrid[i][j] = new Cell(i*sizeMultiplier,j*sizeMultiplier,20, 20);
    }
 }
 }
  
  void draw() {
    background(0);
    for (int i = 0; i < cols; i++) {
     for (int j = 0; j < rows; j++) {  
      gameGrid[i][j].display();
        }
    }
  }
    
    
  
