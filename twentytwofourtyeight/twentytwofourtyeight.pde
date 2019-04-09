       //Cell calss responsible for holding tiles
       class Cell {
    
        int x, y;
        float w, h;

        Cell(int ax, int ay, float aw, float ah) {
         x = ax;
         y = ay;
         w = aw;
         h = ah;
        }

        void display() {
         stroke(123); //Add border colour
         rect(x, y, w, h); //Create the rectangle
        }
       }

       class Tile {

        int x, y, z;
        float w, h;
        int val = 2;
        String colour;
        
        //Tiles will move, hold the value and change colour.
        Tile(int ax, int ay, float aw, float ah, String clr) {
         x = ax;
         y = ay;
         w = aw;
         h = ah;
         colour = clr;

        }
    
        void display() {
         stroke(101); //Add border colour
         rect(x, y, w, h); //Paint the rectangle
        }
       }

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
      
      
    
