class head extends sprit{
  float x_move; 
  
  PImage img; 
  float xPos, yPos, xval, yval, y_bod; 
  PVector location, movement; 
  
  head(PImage a, float xPos, float yPos, float xval, float yval){
    img = a; 
    location = new PVector(xPos, yPos);
    movement = new PVector(xval, yval); 
    y_bod = yPos; 
    
  } 
  
  head(){
  } 
  
  void update(float xVal, float yVal){ 
       
 
    if(this.location.x >=  xVal){
      this.movement.x = -1 ;
    } 
    if(this.location.x <=  xVal){
      this.movement.x = 1;
    } 
   
    if(abs(this.location.x ) > abs(width- 3)){
    this.location.x = 0; 
    this.location.y = y_bod ; 
 }
 
    if(this.location.y >=  yVal +10){
      this.movement.y = -2;
    }     
    if(this.location.y <=  yVal - 10){
      this.movement.y = 2;
    }    
    
    this.location.add(this.movement);

    
  } 
  
  void display(){
    image(img, this.location.x, this.location.y); 
  } 
  
  
  
}