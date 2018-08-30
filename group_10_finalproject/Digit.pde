class Digit extends Block{
  int xpos, ypos, xspeed, yspeed, theme, value;
  
  Digit(int _x, int _y, int _xs, int _ys, int _t, int _v){
    this.xpos = _x;
    this.ypos = _y;
    this.xspeed = _xs;
    this.yspeed = _ys;
    this.theme = _t; 
    this.value = _v;
  }
  
  void display(){
    textSize(30);
    fill(textColor(this.theme)[0], textColor(this.theme)[1], textColor(this.theme)[2]);
    text("" + value, this.xpos, this.ypos);
  }
  
  void update(){
    this.xpos += this.xspeed;
    this.ypos += this.yspeed;
  }
  
  void changeValue(int newval){
    this.value = newval;
  }
  
  void setxspeed(int speed){
    this.xspeed = speed;
  }
  
  void setyspeed(int speed){
    this.yspeed = speed;
  }
  
  void checkEast(int xline){
    if (this.xpos >= xline){
      this.xspeed = -(this.xspeed);
    }
  }
  
  void checkWest(int xline){
    if (this.xpos <= xline){
      this.xspeed = -(this.xspeed);
    }
  }
   
  int[] textColor(int theme){
    theme = theme - 1;
    int[][] colors = new int[][]{
    {255, 255, 255},      //theme 1 (RED)
    {255, 255, 255},     //theme 2 (GREEN)
    {255, 255, 255},     //theme 3 (BLUE)
    {255, 255, 255},     //theme 4 (DRAKE)
    }; 
    
    int r = colors[theme][0];
    int g = colors[theme][1];
    int b = colors[theme][2];
    int[] result = new int[] {r, g, b};
    return result;
  
  }
}