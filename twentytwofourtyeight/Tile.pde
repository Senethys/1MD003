class Tile {

      //Position
      int x, y, z;
      
      //Size
      float w, h;
      
      //Initial Value
      int val = 0;
      color c = color(255, 255, 255);
      
      //Tiles will move, hold the value and change colour.
      Tile(int Ax, int Ay) {
       x = Ax;
       y = Ay;
       w = 1*sizeMultiplier;
       h = 1*sizeMultiplier;
      }
      
      //Changed value and Colour
      void setVal(int newValue) {
        val = newValue;
        //c = color(val + newValue, val + newValue, val + newValue);
      }

      //Value getter
      int getVal() {
        return val; 
      }
      
      int getY() {
        return y; 
      }
      
     int getX() {
        return x; 
      }
      
     void moveUp() {
      y = y - 1;  
    }
    
     void moveDown() {
      y = y + 1;  
    }
    
         void moveRight() {
      x = x + 1;  
    }
    
         void moveLeft() {
      x = x - 1;  
    }
      
  
      void display() {
        //https://processing.org/reference/textAlign_.html
        //From what I understand, text is trikcy to.
       stroke(101); //Add border colour
       //fill(c);
       rect(x*sizeMultiplier, y*sizeMultiplier, w, h); //Paint the rectangle
       fill(255,255,255);
       textSize(20);
       textAlign(LEFT, TOP);
       text(parseInt(this.getVal()), this.getX()*sizeMultiplier, this.getY()* sizeMultiplier);
       fill(0, 102, 155);
      }
     }