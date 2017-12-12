//globally 
//declare the min and max variables that you need in parseInfo 
float minX, maxX; 
float minY, maxY; 
int X = 1, Y = 2;
int totalCount; // total number of places 
float minPopulation, maxPopulation; 
float minSurface, maxSurface; 
float minAltitude, maxAltitude;
float x[], y[];
City ci[];

void setup() { 
  size(900,900); 
  readData();
} 

void draw(){ 
  background(255);
  for(int i = 2; i < totalCount; ++i){
    ci[i-2].draw();
  }
}

void readData() {
  String[] lines = loadStrings("villes.tsv"); 
  parseInfo(lines[0]); // read the header line
  x = new float[totalCount];
  y = new float[totalCount];
  ci = new City[totalCount];
  
  for (int i = 2 ; i < totalCount ; ++i) { 
    String[] columns = split(lines[i], TAB); 
    x[i-2] = float (columns[1]); 
    y[i-2] = float (columns[2]); 
    ci[i-2] = new City();
    ci[i-2].postalcode = int (columns[0]);
    ci[i-2].x = float (columns[1]);
    ci[i-2].y = float (columns[2]);
    ci[i-2].name = columns[4];
    ci[i-2].population = int (columns[5]);
    ci[i-2].density = float (columns[6]) * 1000 / ci[i-2].population; //columns[6] = surface en km
    ci[i-2].altitude = float (columns[7]);
  }
}

void parseInfo(String line) { 
  String infoString = line.substring(2); 
  String[] infoPieces = split(infoString, ','); 
  totalCount = int(infoPieces[0]); 
  minX = float(infoPieces[1]);
  maxX = float(infoPieces[2]); 
  minY = float(infoPieces[3]); 
  maxY = float(infoPieces[4]); 
  minPopulation = float(infoPieces[5]); 
  maxPopulation = float(infoPieces[6]); 
  minSurface = float(infoPieces[7]); 
  maxSurface = float(infoPieces[8]); 
  minAltitude = float(infoPieces[9]); 
  maxAltitude = float(infoPieces[10]); 
}