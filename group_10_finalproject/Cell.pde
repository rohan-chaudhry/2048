class Cell{
  int number, xC, yC, row, col, theme;
  boolean isFilled = false; //does the grid have a number in it 
  boolean merge = true;
  
  //RGB values for each numeric tile
  //each tile has a differing color 
  int[][] colors = new int[][]{
               //tile val:   index:
    {5, 51, 108},      //2    -0
    {19, 71, 137},     //4    -1
    {47, 94, 155},     //8    -2
    {62, 120, 193},    //16   -3
    {101, 146, 203},   //32   -4
    {119, 164, 222},   //64   -5
    {94, 160, 245},    //128  -6
    {54, 138, 245},    //256  -7
    {13, 119, 255},    //512  -8
    {0, 153, 252},     //1024 -9
    {41, 5, 252},      //2048 -10
  };
  
  
  Cell(int _x, int _y, int _r, int _c, int _t){
    xC = _x;
    yC = _y;
    row = _r;
    col = _c;
    number = 2; // start at base of 2 
    this.theme = _t;
  }
   
  // drawing tile based on tile value
  void drawTile(){
    
    if (number == 2){
      fill(getColor(this.theme, this.number)[0], getColor(this.theme, this.number)[1], getColor(this.theme, this.number)[2]);
      rect(xC, yC, 150, 150);
      fill(255);
      textSize(130);
      text("" + number, xC + 45, yC + 120);
    }
    if (number == 4){
      fill(getColor(this.theme, this.number)[0], getColor(this.theme, this.number)[1], getColor(this.theme, this.number)[2]);
      rect(xC, yC, 150, 150);
      fill(255);
      textSize(130);
      text("" + number, xC + 45, yC + 120);
    }
    if (number == 8){
      fill(getColor(this.theme, this.number)[0], getColor(this.theme, this.number)[1], getColor(this.theme, this.number)[2]);
      rect(xC, yC, 150, 150);
      fill(255);
      textSize(130);
      text("" + number, xC + 45, yC + 120);
    }
    if (number == 16){
      fill(getColor(this.theme, this.number)[0], getColor(this.theme, this.number)[1], getColor(this.theme, this.number)[2]);
      rect(xC, yC, 150, 150);
      fill(255);
      textSize(120);
      text("" + number, xC + 15, yC + 115);
    }
    if (number == 32){
      fill(getColor(this.theme, this.number)[0], getColor(this.theme, this.number)[1], getColor(this.theme, this.number)[2]);
      rect(xC, yC, 150, 150);
      fill(255);
      textSize(120);
      text("" + number, xC + 15, yC + 115);
    }
    if (number == 64){
      fill(getColor(this.theme, this.number)[0], getColor(this.theme, this.number)[1], getColor(this.theme, this.number)[2]);
      rect(xC, yC, 150, 150);
      fill(255);
      textSize(120);
      text("" + number, xC + 15, yC + 115);
    }
    if (number == 128){
      fill(getColor(this.theme, this.number)[0], getColor(this.theme, this.number)[1], getColor(this.theme, this.number)[2]);
      rect(xC, yC, 150, 150);
      fill(255);
      textSize(90);
      text("" + number, xC + 7, yC + 105);
    }
    if (number == 256){
      fill(getColor(this.theme, this.number)[0], getColor(this.theme, this.number)[1], getColor(this.theme, this.number)[2]);
      rect(xC, yC, 150, 150);
      fill(255);
      textSize(90);
      text("" + number, xC + 10, yC + 105);
    }
    if (number == 512){
      fill(getColor(this.theme, this.number)[0], getColor(this.theme, this.number)[1], getColor(this.theme, this.number)[2]);
      rect(xC, yC, 150, 150);
      fill(255);
      textSize(90);
      text("" + number, xC + 10, yC + 105);
    }
    if (number == 1024){
      fill(getColor(this.theme, this.number)[0], getColor(this.theme, this.number)[1], getColor(this.theme, this.number)[2]);
      rect(xC, yC, 150, 150);
      fill(255);
      textSize(70);
      text("" + number, xC +5, yC + 100);
    }
    if (number == 2048){
      fill(getColor(this.theme, this.number)[0], getColor(this.theme, this.number)[1], getColor(this.theme, this.number)[2]);
      rect(xC, yC, 150, 150);
      fill(255);
      textSize(70);
      text("" + number, xC +5, yC + 100);
    }
    
  }
  
  void changeCell(int r, int c){
    cells[r][c].merge = this.merge;
    this.isFilled = false;
    if (this.row == r) {
      this.xC -= 150 * (c-this.col);
    } else if (this.col == c) {
      this.yC -= 150 * (r-this.row);
    }
    cells[r][c].number = this.number;
    this.number = 2;
    cells[r][c].isFilled = true;
  }
  
  int[] getColor(int theme, int number){
    
    int[][] blue = new int[][]{
               //tile val:   index:
    {5, 51, 108},      //2    -0
    {19, 71, 137},     //4    -1
    {47, 94, 155},     //8    -2
    {62, 120, 193},    //16   -3
    {101, 146, 203},   //32   -4
    {119, 164, 222},   //64   -5
    {94, 160, 245},    //128  -6
    {54, 138, 245},    //256  -7
    {13, 119, 255},    //512  -8
    {0, 153, 252},     //1024 -9
    {41, 5, 252},      //2048 -10
    };
    
    int[][] green = new int[][]{
               //tile val:   index:
    {70, 131, 52},      //2    -0
    {80, 165, 55},     //4    -1
    {55, 147, 28},     //8    -2
    {50, 173, 14},    //16   -3
    {75, 209, 36},   //32   -4
    {95, 224, 57},   //64   -5
    {74, 237, 26},    //128  -6
    {74, 255, 21},    //256  -7
    {113, 255, 21},    //512  -8
    {137, 255, 13},     //1024 -9
    {178, 255, 0},      //2048 -10
    };
    
    int[][] red = new int[][]{
               //tile val:   index:
    {142, 54, 54},      //2    -0
    {170, 36, 36},     //4    -1
    {201, 65, 65},     //8    -2
    {227, 50, 50},    //16   -3
    {245, 40, 40},   //32   -4
    {255, 18, 18},   //64   -5
    {255, 54, 18},    //128  -6
    {255, 74, 3},    //256  -7
    {255, 104, 3},    //512  -8
    {255, 133, 3},     //1024 -9
    {255, 197, 3},      //2048 -10
    };
    
    int[][] drake = new int[][]{
               //tile val:   index:
    {206, 171, 44},      //2    -0
    {224, 181, 25},     //4    -1
    {240, 190, 7},     //8    -2
    {240, 205, 7},    //16   -3
    {235, 240, 7},   //32   -4
    {238, 255, 10},   //64   -5
    {197, 255, 10},    //128  -6
    {148, 255, 10},    //256  -7
    {38, 255, 10},    //512  -8
    {10, 255, 118},     //1024 -9
    {10, 249, 255},      //2048 -10
    };
    
    if (theme == 1){
      int r = red[powerCounter(number)][0];
      int g = red[powerCounter(number)][1];
      int b = red[powerCounter(number)][2];
      int[] result = new int[] {r, g, b};
      return result;
    }else if (theme == 2){
      int r = green[powerCounter(number)][0];
      int g = green[powerCounter(number)][1];
      int b = green[powerCounter(number)][2];
      int[] result = new int[] {r, g, b};
      return result;
    }else if (theme == 3){
      int r = blue[powerCounter(number)][0];
      int g = blue[powerCounter(number)][1];
      int b = blue[powerCounter(number)][2];
      int[] result = new int[] {r, g, b};
      return result;
    }else{
      int r = drake[powerCounter(number)][0];
      int g = drake[powerCounter(number)][1];
      int b = drake[powerCounter(number)][2];
      int[] result = new int[] {r, g, b};
      return result;
    }
  }
  
  int powerCounter(int number){
    int count = 0;
    
    while (number > 1){
      number = number/2;
      count++;
    }
    
    return (count - 1);
  }
  
}