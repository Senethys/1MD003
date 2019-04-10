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
