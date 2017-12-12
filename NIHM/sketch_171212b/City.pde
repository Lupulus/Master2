class City {
  int postalcode; 
  String name; 
  float x; 
  float y; 
  float population; 
  float density; 
  float altitude;
  // put a drawing function in here and call from main drawing loop } 
  
  void draw(){
    //if(density > 50)
      //ellipse((int) mapX(x), (int) mapY(y), density/100, density/100);
    stroke(0);
    if(population > 5000)
      ellipse((int) mapX(x), (int) mapY(y), population/20000, population/20000);
    if(altitude > 200) 
      set((int) mapX(x), (int) mapY(y), color(88, 41, 0));
    else if(altitude < 50)
      set((int) mapX(x), (int) mapY(y), color(44, 117, 255));
    else
      set((int) mapX(x), (int) mapY(y), color(31, 160, 85));
    if(name.equals("Lille")){
      stroke(237, 0, 0);
      rect(mapX(x - 0.002), mapY(y + 0.002), 20.0, 20.0);
    }
  }
  
  float mapX(float x) {
  return map(x, minX, maxX, 0, 900); 
  }

  float mapY(float y) {
    return map(y, minY, maxY, 900, 0); 
  }
}