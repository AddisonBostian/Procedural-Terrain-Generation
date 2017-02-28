class hero {
  int x, y, wood;
  String weak; //list of blocks the hero is not allowed to walk on, integers 1-9 denote block types.
  char lastDir; //tracks the last direction the hero was traveling
  hero(int xpos, int ypos) {
    x = xpos;
    y = ypos;
    weak = "13"; //sets weak blocks to block type 1 and 3
    wood = 0;

    //ensures hero does not spawn on a block it is not allowed to walk on.
    while (weak.contains(""+c[x][y]))
      x--;
  }

/**following four functions move the hero in the direction of the key pressed, not allowing movement if the 
block to be moved onto is a block type contained in the hero's weak variable. Does not allow movement off screen.**/
  void moveL() {
    if (x-1 >=0 && !weak.contains(""+c[x-1][y]))
      x--;
    lastDir = 'L';
  }

  void moveR() {
    if (x+1 < c.length && !weak.contains(""+c[x+1][y]))
      x++;
    lastDir = 'R';
  }

  void moveU() {
    if (y-1 >=0 && !weak.contains(""+c[x][y-1]))
      y--;
    lastDir = 'U';
  }

  void moveD() {
    if (y+1 <c[0].length && !weak.contains(""+c[x][y+1]))
      y++;
    lastDir = 'D';
  }

//shows the hero on th screen
  void drawHero() {
    fill(0);
    rect(x*size, y*size, size, size);
  }
  
  /** allows the hero to jump over a group of blocks he is not allowed to walk on. Moves player in the last direction moved
  until a block is found that the hero can stand on. Allows hero to go off screen, resulting in death.
  void jump() {
    try {
      switch(lastDir) {

      case 'R':
        x++;
        while (weak.contains(""+c[x][y]))
          x++;
        break;
        
        
      case 'L':
        x--;
        while (weak.contains(""+c[x][y]))
          x--;
        break;
        
        
      case 'U':
        y--;
        while (weak.contains(""+c[x][y]))
          y--;
        break;
        
        
      case 'D':
        y++;
        while (weak.contains(""+c[x][y]))
          y++;
      }
    } //the case where the player moved off of the screen
    catch(ArrayIndexOutOfBoundsException e) {
      println("You died! You had " + wood +" pieces of wood");
      System.exit(0);
    }
  }
//removes wood from landscape and adds it to hero's inventory
  void mine() {
    try {
      switch(lastDir) {

      case 'R':
        x++;
        //gets wood
        if (c[x][y] == 3) {
          println("Wood: "+ ++wood);
          c[x][y] = 0;
        }
        x--;
        break;


      case 'L':
        x--;

        if (c[x][y] == 3) {
          println("Wood: "+ ++wood);
          c[x][y] = 0;
        } 
        x++;
        break;


      case 'U':
        y--;

        if (c[x][y] == 3) {
          println("Wood: "+ ++wood);
          c[x][y] = 0;
        }
        y++;
        break;


      case 'D':
        y++;
        if (c[x][y] == 3) {
          println("Wood: "+ ++wood);
          c[x][y] = 0;
        }
        y--;
        
      }
    } 
    catch(Exception e) {
      println("You Died! You had "+wood+" pieces of wood");
      System.exit(0);
    }
  }
}
