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
