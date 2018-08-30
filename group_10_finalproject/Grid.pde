class Grid{
  int theme;
  
  // for grid measure  
  int x1 = 150;
  int y1 = 200; 
  int x2 = 750;
  int y2 = 800;

  int counter = 0; // loop counter 
  boolean appear = false; // make new tile appear 
  
  Grid(int _t){
    
    this.theme = _t;
    
    //draw grid boundary lines  
    fill(255);
    rect(x1, y1, 600, 600);
    
    for (int i = 150; i<=750; i+=150) {
    smooth();
    stroke(255);
    strokeWeight(6);
    line(150, i + 50, 750, i +50);
    line(i, 200, i, 800);
    }
    
    
    int x = x1;
    int y = y1;
    
    for (int row = 0; row < cells.length; row++){
      for (int col = 0; col < cells[0].length; col++){
        cells[row][col] = new Cell(x, y, row, col, theme);
        x += 150;
      }
      x = x1;
      y += 150;
    }  
  }
  
  //returns the cells that have a numeric value either from bottom-up or up-bottom
  public ArrayList<Cell> returnOccupied(boolean bottom_up) {
    ArrayList<Cell> cellsList = new ArrayList<Cell>();
    if (bottom_up) {
      for (int r = cells.length-1; r>=0; r--) {
        for (int c = cells[0].length-1; c>=0; c--) {
          if (cells[r][c].isFilled) {
            cellsList.add(cells[r][c]);
          }
        }
      }
    } 
    else 
    {
      for (int r = 0; r<cells.length; r++) {
        for (int c =0; c<cells[0].length; c++) {
          if (cells[r][c].isFilled) {
            cellsList.add(cells[r][c]);
          }
        }
      }
    }
    return cellsList;
  }
  
  //adds a 2|4 tile randomly to grid
  void generate(){
    int i = 0;
    while (i < 1) {
      int r = (int)random(0, 4);
      int c = (int)random(0, 4);
      if (!cells[r][c].isFilled){
        cells[r][c].isFilled = true;
        cells[r][c].number *= (int)random(0, 2) + 1;
        i++;
      }
    }
  }
  
  boolean check() { // check if additional moves can be made 
    for (int r = 0; r < cells.length; r++) {
      for (int c = 0; c < cells[0].length; c++) {
        if (!grid.canMerge(r, c)) {
          return false;
        }
      }
    }
    return true;
  }
  
  boolean canMerge(int rp, int cp) { //if 2 tiles can merge, then merge; else, dont merge and leave side by side 
    if (returnOccupied(true).size() >= 16) {
      for (int r = rp- 1; r <= rp + 1; r++) {
        for (int c = cp - 1; c <= cp + 1; c++) {
          if (r>=0 && r<=3 && c>=0 && c<=3  && (rp != r || cp != c) && (rp == r || cp == c)) {
            if (cells[rp][cp].number == cells[r][c].number) {
              return false;
            }
          }
        }
      }
      return true;
    }
    return false;
    
  }
  
  boolean xLine(int xC){
    boolean atLine = false;
    if ((xC == 150) || (xC == 300) || (xC == 450) || (xC == 600)){
      atLine = true;
    }
    return atLine;
  }
  
  boolean yLine(int yC){
    boolean atLine = false;
    if ((yC == 200) || (yC == 350) || (yC == 500) || (yC == 650)){
      atLine = true;
    }
    return atLine;
  }
  
  void moveTiles() {
    if ((keyCode == UP || keyCode == LEFT)) {
      if (counter < 10 && keyCode != 0) {
        for (Cell c : returnOccupied (false)) {
          if (keyCode == UP  && c.yC > 100 && c.row !=0) {//checks if key and new position of tile is valid
            if (!cells[c.row-1][c.col].isFilled) {//moves tile if cell above it has no numeric value
              c.yC -= 150;
              if (yLine(c.yC)) {//position of tile is changed when tile moves to another cell location
                c.changeCell(c.row-1, c.col);
                
              }
              appear = true;
            } else if (yLine(c.yC) && cells[c.row-1][c.col].number == c.number && c.merge) {//merges tile if tile above it has the same number
              c.merge = false;
              cells[c.row-1][c.col].merge = false;
              c.yC -= 150;
              c.number *= 2;
              score += c.number;
              c.changeCell(c.row-1, c.col);
              if (this.theme == 4){
                drakeBitFile.play();
              }else{
                levelup_noise.play();  /////////////////////////////////////////added this 
              }
              appear = true;
            }
          } else if (keyCode == LEFT && c.xC > 150 && c.col !=0) {
            if (!cells[c.row][c.col-1].isFilled) {
              c.xC -= 150;
              if (xLine(c.xC)) {
                c.changeCell(c.row, c.col-1);
              
              }
              appear = true;
            } else if (xLine(c.xC) && cells[c.row][c.col-1].number == c.number && c.merge) {
              c.merge = false;
              cells[c.row][c.col-1].merge = false;
              c.xC -= 150;
              c.number *= 2;
              score += c.number;
              c.changeCell(c.row, c.col-1);
              if (this.theme == 4){
                drakeBitFile.play();
              }else{
                levelup_noise.play();  /////////////////////////////////////////added this 
              } 
              appear = true;
            }
          }
        }
      } else {//resets loop, keyCode, cell's merge state, and appears a tile
        counter = -1;
        keyCode = 0;
        for (Cell c : returnOccupied(false)) {
          c.merge = true;
        }
        if (returnOccupied(false).size() < 16 && appear) {
          grid.generate();
        }
        appear = false;
      }
      counter++;
    } else if ((keyCode == RIGHT || keyCode == DOWN)) {
      if (counter < 10 && keyCode != 0) {
        for (Cell c : returnOccupied (true)) { 
          if (keyCode == RIGHT && c.xC < 750 && c.col !=3) {
            if (!cells[c.row][c.col+1].isFilled) {
              c.xC += 150;
              if (xLine(c.xC)) {
                c.changeCell(c.row, c.col+1);
                
              }
              appear = true;
            } else if (xLine(c.xC) && cells[c.row][c.col+1].number == c.number && c.merge) {
              c.merge = false;
              cells[c.row][c.col+1].merge = false;
              c.xC += 150;
              c.number *= 2;
              score += c.number;
              c.changeCell(c.row, c.col+1);
              if (this.theme == 4){
                drakeBitFile.play();
              }else{
                levelup_noise.play();  /////////////////////////////////////////added this 
              }
              appear = true;
            }
          } else if (keyCode == DOWN && c.yC < 800 && c.row != 3) {
            if (!cells[c.row+1][c.col].isFilled) {
              c.yC += 150;
              if (yLine(c.yC)) {
                c.changeCell(c.row+1, c.col);
               
              }
              appear = true;
            } else if (yLine(c.yC) && cells[c.row+1][c.col].number == c.number && c.merge) {
              c.merge = false;
              cells[c.row+1][c.col].merge = false;
              c.yC += 150;
              c.number *= 2;
              score += c.number;
              c.changeCell(c.row+1, c.col);
              if (this.theme == 4){
                drakeBitFile.play();
              }else{
                levelup_noise.play();  /////////////////////////////////////////added this 
              } 
              
              appear = true;
            }
          }
        }
      } else {
        counter = -1;
        keyCode = 0;
        for (Cell c : returnOccupied(true)){
          c.merge = true;
        }
        if (returnOccupied(true).size() < 16 && appear){
          grid.generate();
        }
        appear = false;
      }
      counter++;
    }
  }

}