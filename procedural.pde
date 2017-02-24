import javax.swing.JOptionPane;
int size = 5;
int screen = 500;
final color LAND = color(0, 255, 0);
final color WATER = color(0, 0, 255);
final color BEACH = #EABA1A;
final color TREE = #654321;
color[] colors = {LAND, WATER, BEACH, TREE};
int[][] c = new int[screen/size][screen/size];
final int landPercent = 54;
final int treePercent = 15;

hero a;
void settings() {
  size(screen, screen); 
  long seed = System.currentTimeMillis();
  randomSeed(seed);
  println("Seed: " + seed);
}

void setup() {
  //generates random terrain
  JOptionPane.showMessageDialog(null, "'WASD' to move, 'M' to mine wood, Space to jump over obstacles.");
  noStroke();
  for (int i = 0; i<c.length; i++) {
    for (int j = 0; j<c[0].length; j++) {
      c[i][j] = (int)random(0, 100) >landPercent ? 1 : 0;
      fill(c[j][i] >= 1 ? color(0, 0, 255) : color(0, 255, 0));
      rect(i*size, j*size, size, size);
    }
  }

  //smooths the generated terrain
  int smoothFactor = 5;
  for (int i = 0; i<smoothFactor; i++) {
    smooth();
  }
  
  //adds beaches
  beaches();
  trees();


  //constructor ensures hero is not places in element it cannot traverse.
  a = new hero(c.length/2, c[0].length/2);
}

void trees() {
  for (int i = 0; i<c.length; i++) {
    for (int j = 0; j<c[0].length; j++) {
      if(c[i][j] == 0){
        int r = (int)random(0,1000);
        c[i][j] = r > treePercent ? 0 : 3;
      }
    }
  }
}
void beaches() {
  for (int i = 0; i<c.length; i++) {
    for (int j = 0; j<c[0].length; j++) {
      if (isBeach(c, i, j)) {
        c[i][j] = 2;
      }
    }
  }
}


boolean isBeach(int[][] c, int index, int indey) {
  int L = index - 1 < 0 ? 0 : index-1;
  int R = index+1 >= c.length ? c.length-1 : index+1;
  int A = indey-1 < 0 ? 0 : indey-1;
  int B = indey+1 >= c[0].length ? c[0].length-1 : indey+1;
  if (c[index][indey] == 0) {
    if (c[L][indey] == 1)
      return true;
    if (c[R][indey] == 1)
      return true;

    if (c[index][A] == 1)
      return true;

    if (c[index][B] == 1)
      return true;
  }
  return false;
}

void smooth() {

  for (int i = 0; i<c.length; i++) {
    for (int j = 0; j<c[0].length; j++) {
      if (!isSame(c, i, j)) {
        c[i][j] = c[i][j] >= 1 ? 0 : 1;
      }
    }
  }
}



boolean isSame(int[][] c, int indey, int index) {
  int left = index-1>= 0 ? index-1 : index;
  int right = index+1 < c[0].length ? index+1 : index;
  int above = indey-1 >= 0 ? indey-1 : indey;
  int below = indey+1 < c.length ? indey+1 : indey;

  int count = 0;

  if (c[indey][index] == c[indey][left])
    count++;

  if (c[indey][index] == c[indey][right])
    count++;

  if (c[indey][index] == c[above][index])
    count++;

  if (c[indey][index] == c[below][index])
    count++;

  return count>2;
}


void draw() {
  for (int i = 0; i<c.length; i++) {
    for (int j = 0; j<c[0].length; j++) {
      fill(colors[c[i][j]]);
      rect(i*size, j*size, size, size);
    }
  }

  fill(0);
  a.drawHero();
}

void keyPressed() {
  if (key == 'w')
    a.moveU();
  if (key == 's')
    a.moveD();
  if (key == 'a')
    a.moveL();
  if (key == 'd')
    a.moveR();

  if (key == ' ')
    a.jump();
    
   if(key == 'm')
     a.mine();
     
}