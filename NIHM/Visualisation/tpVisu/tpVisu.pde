//globally 
//declare the variable corresponding to the tab of City
City c[];
City printedCity;
//declare the variables corresponding to the column ids for x and y 
int X = 1; int Y = 2;
// and the tables in which the city coordinates will be stored 
float x[]; float y[];
//declare the min and max variables that you need in parseInfo 
float minX, maxX; float minY, maxY; int totalCount; 
// total number of places 
int minPopulation, maxPopulation; int minSurface, maxSurface; 
float maxDensity = 0;
int minAltitude, maxAltitude;
int minPopulationToDisplay = 10000;


 // read the header line 
void parseInfo(String line) { 
 String infoString = line.substring(2); 
 // remove the # 
 String[] infoPieces = split(infoString, ','); 
 totalCount = int(infoPieces[0]); 
 minX = float(infoPieces[1]);
 maxX = float(infoPieces[2]); 
 minY = float(infoPieces[3]); 
 maxY = float(infoPieces[4]); 
 minPopulation = int(infoPieces[5]); 
 maxPopulation = int(infoPieces[6]); 
 minSurface = int(infoPieces[7]); 
 maxSurface = int(infoPieces[8]); 
 minAltitude = int(infoPieces[9]); 
 maxAltitude = int(infoPieces[10]);
}

void setup() {
  readData();
  size(800,800); 
}
void draw() { 
  background(255); 
  fill(0, 0, 0);
   text("Afficher les populations supérieures à " + minPopulationToDisplay, 5, 40);
   text("Légende: \nbleu = altitude < 50\n vert = altitude < 150\n marron = altitude > 150", 5, 730);
   fill(255,255,255);
  for (int i = 0 ; i < totalCount - 2; ++i) {
     c[i].draw();
  }
}

void readData() {
  String[] lines = loadStrings("villes.tsv"); 
  parseInfo(lines[0]);
  x = new float[totalCount]; 
  y = new float[totalCount];
  c = new City[totalCount];
  for (int i = 2 ; i < totalCount; ++i) {
     String[] columns = split(lines[i], TAB);
     City temp = new City(int(columns[0]), float(columns[1]), float(columns[2]), int(columns[3]), columns[4], float(columns[5]), float(columns[6]), float(columns[7]));
     c[i - 2] = temp;
      maxDensity = maxDensity < temp.density ? temp.density : maxDensity;
     x[i-2] = float (columns[1]); 
     y[i-2] = float (columns[2]); 
  }
  printedCity = c[0];
}

void keyPressed(){
  if(key == CODED){
    
    int step = (int) (minPopulationToDisplay * 0.1);
    if (keyCode == UP) {
      minPopulationToDisplay -= step;
    } else if (keyCode == DOWN) {
      minPopulationToDisplay += step;
    } else return;
  
    redraw();
  }
}

void mouseMoved(){
  //println("X: " + mouseX);
  //println("Y: " + mouseY);
  City cityToPrint = pick(mouseX, mouseY);
  if(cityToPrint != printedCity){
    if(cityToPrint != null){
       println(cityToPrint.getName());
       cityToPrint.setGetSelected(true);
       printedCity.setGetSelected(false);
       printedCity = cityToPrint;
    }    
  }
  redraw();
}

City pick(int px, int py){
  City res = null;
  for (int i = totalCount - 3 ; i > 0; --i) {
   if(c[i].contains(px, py))
     res = c[i];
  }
  return res;
}