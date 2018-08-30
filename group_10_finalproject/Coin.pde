class Coin {
  PImage[] images;
  int imageCount;
  int frame;
  
  Coin(String imagePrefix, int count) {
    imageCount = count;
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      // Use nf() to number format 'i' into certain number of digits
      String filename = imagePrefix + nf(i, 2) + ".png";
      images[i] = loadImage(filename);
      images[i].resize(50,50);
    }
  }

  void display(float xpos, float ypos) {
    frame = (frame+1) % imageCount;
    image(images[frame], xpos, ypos);
  }
  
  int getWidth() {
    return images[0].width;
  }
}