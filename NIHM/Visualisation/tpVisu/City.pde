class City { 
  int postalcode; 
  float x; 
  float y; 
  int iseecode;
  String name; 
  float population; 
  float surface;
  float altitude;
  float density; 
  float radius;
  boolean getSelected;
  
  City(int postalcode, float x, float y, int iseecode, String name, float population, float surface, float altitude){
    this.postalcode  = postalcode;
    this.name = name;
    this.x = x;
    this.y = y;
    this.iseecode = iseecode;
    this.population = population;
    this.surface = surface;
    this.altitude = altitude;
    this.density = (surface !=0) ? population/surface : 0;
    this.getSelected = false;
  }
  
  void draw(){
    
    if(population <= minPopulationToDisplay)
      return;
      
   color outlineColor;
   if(altitude < 50)
     outlineColor = color(0, 128, 255);
   else if(altitude < 150)
     outlineColor = color(0, 255, 0);
   else 
     outlineColor = color(153, 76, 0);
     
    color selectedColor = color(255, 255, 255);
    if (getSelected) {
      selectedColor = color(255, 0, 0);
}
    fill(selectedColor);
    radius = mapD(density) / 2;
    stroke(outlineColor);
    ellipse(mapX(x), mapY(y), radius * 2, radius * 2);
    
    if(getSelected){
      fill(255, 51, 153);
      text(name, mouseX, mouseY - 20);
    }
    
  }
  
  float mapX(float x) { 
    return map(x, minX, maxX, 0, 800); 
  }

  float mapY(float y) { 
    return map(y, minY, maxY, 800, 0); 
  }
  
  float mapD(float d){
    return map(d, 50, maxDensity, 1, 100);
  }
  
  // Ceci est la fonction de test correspondante 
  boolean contains(int px, int py) { 
   // Comme nous dessinons un cercle, on utilise ici la distance 
   // entre (px, py) et le centre du cercle, 
   // et on ajoute un pixel supplémentaire pour faciliter
   // la sélection à la souris 
   return dist(mapX(x), mapY(y), px, py) <= radius + 1; 
  }
  
  String getName(){
    return this.name;
  }
  
  void setGetSelected(boolean getSelected){
    this.getSelected = getSelected;
  }
}