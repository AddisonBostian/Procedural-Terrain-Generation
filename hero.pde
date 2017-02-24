class hero {
  int x, y, wood;
  String weak;
  char lastDir;
  hero(int xpos, int ypos) {
    x = xpos;
    y = ypos;
    weak = "13";
    wood = 0;

    while (weak.contains(""+c[x][y]))
      x--;
  }


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

  void drawHero() {
    fill(0);
    rect(x*size, y*size, size, size);
  }

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
    } 
    catch(ArrayIndexOutOfBoundsException e) {
      println("You died! You had " + wood +" pieces of wood");
      System.exit(0);
    }
  }

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