class Block{
  int xpos, ypos, speed, theme;
  
  Block(int _x, int _y, int _s, int _t){
    this.xpos = _x;
    this.ypos = _y;
    this.speed = _s;
    this.theme = _t;
  }
  
  Block(){
  }
  
  void display(){
    fill(blockColor(this.theme)[0], blockColor(this.theme)[1], blockColor(this.theme)[2]);
    strokeWeight(0);
    rect(this.xpos, this.ypos, 100, 100);
  }
  
  void update(){
    this.ypos += this.speed;
  }
  
  void checkEdge(){
    if (this.ypos > 800){
      this.speed = 0;
    }
  }
  
  void setSpeed(int _s){
    this.speed = _s;
  }
  
  int[] blockColor(int theme){
    theme = theme - 1;
    int[][] colors = new int[][]{
    {240, 34, 34},      //theme 1 (RED)
    {112, 255, 31},     //theme 2 (GREEN)
    {34, 88, 242},     //theme 3 (BLUE)
    {254,255,67},    //theme 4 (DRAKE)
    }; 
    
    int r = colors[theme][0];
    int g = colors[theme][1];
    int b = colors[theme][2];
    int[] result = new int[] {r, g, b};
    return result;
  
  }
}