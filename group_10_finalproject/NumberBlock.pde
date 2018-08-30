class numberBlock extends Block{
  int xpos, ypos, speed, theme;
  int number, numSpeed, numx, numy;
  
  numberBlock(int _x, int _y, int _s, int _t, int _n){
    this.xpos = _x;
    this.ypos = _y;
    this.speed = _s;
    this.theme = _t; 
    this.number = _n;
    this.numy = _y;
    this.numx = _x;
  }
  
  void displayNum(){
    fill(255);
    textSize(40);
    text("" + this.number, numx, numy);
  }
  
  void updateNum(){
    this.numx += numSpeed;
  }
  
  void checkNumEdge(){
    if ((this.numx > (this.xpos + 100)) || (this.numx < this.xpos)){
      this.numSpeed = -(this.numSpeed);
    }
  }
}