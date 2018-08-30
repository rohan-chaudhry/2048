class sprit{ 
  PImage img; 
  float xPos, yPos, xval, yval, y_start; 
  PVector location, movement; 
  
  sprit(PImage a, float xPos, float yPos, float xval, float yval){
    img = a; 
    location = new PVector(xPos, yPos);
    movement = new PVector(xval, yval); 
    y_start = yPos; 
  } 
  
   
  sprit(){
  } 
   
  
  void update(){
    this.location.x += 1; 
    //this.location.x += .5 ; 
    
    //if(abs(this.location.x) > abs(width)){
    if(abs(this.location.x) > abs(width)){
      this.location.x = 0; 
      this.location.y = y_start; 
 }
  } 
  
  void display(){ 
    image(img, this.location.x, this.location.y); 
  } 
  
}