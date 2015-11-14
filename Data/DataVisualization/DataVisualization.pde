//Create by willove
//seen the result in https://medium.com/@willovehe

String [] allwords;
String delimiters=" ,.?!;:[]";
IntDict concordance;
PFont f;
int n=0;

void setup() {
  size(600, 400);
  pixelDensity(2);
  //load font
  f=createFont("arial", 12, true);

  //load the tale into rawtext array
  String url = "data.txt";
  String [] rawtext=loadStrings(url);

  //join the big array together as one long string
  String everything = join(rawtext, " ");
  allwords=splitTokens(everything, delimiters);

  //make a new empty dictionary
  concordance=new IntDict();
}

void draw() {
  background(255);

  //sort by values for largest to smallest
  concordance.sortValuesReverse();

  //cllect statistics one word a circle
  String s=allwords[n].toLowerCase();
  concordance.increment(s);
  
  //Create a array of keywords
  String [] keys=concordance.keyArray();
  //Create variables stand for total length and the row
  float tl, row;
  //Create vars' x,y coordination of text and the text heigth
  float xpos, ypos, fh;
  
  //Initialize those varibales every draw
  tl=0.0;
  row=0;
  fh=0.0;
  xpos=0;
  ypos=concordance.get(keys[0])*2+5;
  
  int findex=0;
  for (int i=0; i<keys.length; i++) {
    //Get the key name and its count
    String word=keys[i];
    float count=concordance.get(word);

    fill(0, i%2*100+155);
    textFont(f, count*2+5);

    row=int(tl/width);
    
    println(ypos);
    text(word, xpos, ypos);
    
    //Increase the values of x coordinate
    tl+=textWidth(word);
    xpos+=textWidth(word);
    
    //If the text near the right side, then come to next line
    if (int(tl/width)>row) {
      findex=i;
      fh=concordance.get(keys[findex])+5;
      ypos+=fh*1.2*2;
      xpos=0;
    }
    
  }
  //Stop the draw when finish cllect the statistics
  n++;
  if (n>=allwords.length) {
    noLoop();
  }
  
  saveFrame("frames/VisualizeConcordance####.jpg");
}
