//Flappy bird

//Linnun parametrit
float korkeus = 400; //Linnun korkeus
boolean hyppy = false;
float ajastin = 0;
float liike = 1;
float cooldown = 120;

//Putkien parametrit
float leveys = 60;
float x = 500;
float ppx = 750;
float ppy = 750;
float x1 = 500;
float vali = 200; //Putkien välissä oleva väli
float ylapituus  = random(25, 600);
float ppyla = random(25, 600);
float alapituus = ylapituus + vali;
float ppala = ppyla + vali;
boolean putkix = false;

//Pelin parametrit
boolean osuma = false;
boolean peli = false;
int piste = 0;

//Grafiikat
PImage tausta;
PImage lintu;
PImage lintuy;
PImage lintua;
String end = "" + piste;


class Putki
{
  Putki (float x, float y, float leveys, float korkeus)
  {
    this.x = x;
    this.y = y;
    this.leveys = leveys;
    this.korkeus = korkeus;
  }

  void piirra ()
  {
    fill(35, 56, 66);
    rect(x, y, leveys, korkeus);
    rect(x-5,korkeus,leveys+10,10);
  }

  float x, y, leveys, korkeus;
}

class Putkiy
{
  Putkiy (float x1, float y1, float leveys1, float korkeus1)
  {
    this.x1 = x1;
    this.y1 = y1;
    this.leveys1 = leveys1;
    this.korkeus1 = korkeus1;
  }

  void piirray()
  {
    fill(35, 56, 66);
    rect(x1, y1, leveys1, korkeus1);
    rect(x1-5,korkeus1,leveys+10,10);
  }

  float x1, y1, leveys1, korkeus1;
}

void setup()
{
  size(500, 800);
  smooth();
  frameRate(60);
  background(0);
  colorMode(HSB, 100);
  textAlign(CENTER, CENTER);
  textSize(40);
  tausta = loadImage("tausta.png");
  lintu = loadImage("lintu.png");
  lintuy = loadImage("lintuy.png");
  lintua = loadImage("lintua.png");
}

void draw()
{
  if ((peli == false) && (osuma == false)) { 
    image(tausta, 0, 0);
    image(lintu, 60-30, korkeus-30);
    text("Klikkaa aloittaaksesi", width/2, 200);
  }

  if (peli == true)
  {
    image(tausta,0,0);
    image(tausta, 0, 10);
    fill(0, 0, 100);
    text(piste, width/2, 200);
    //Lintu
    point(60, korkeus);
    if ((hyppy == true) && (ajastin > 0)) {
      image(lintuy, 60-30, korkeus-30);
      liike = liike - 0.4 * ajastin;
      ajastin = ajastin - 1;
    } else {
      image(lintua, 60-30, korkeus-30);
      liike = - 0.22 * ajastin;
      ajastin = ajastin - 1;
    }
    korkeus = korkeus + liike;
    cooldown = cooldown - 10;
    println(x, x1, ppx, ppy);

    //Tekstit
    if (osuma == false) {
    }
    //Putket
    Putki p = new Putki (x, 0, leveys, ylapituus);
    Putki pp = new Putki (ppx, 0, leveys, ppyla);
    p.piirra();
    pp.piirra();

    Putkiy p2 = new Putkiy (x1, alapituus, leveys, height);
    Putkiy pp2 = new Putkiy (ppy, ppala, leveys, height * 1.5);
    p2.piirray();
    pp2.piirray();
    rect(x1-5, alapituus-5, leveys+10, 10);
    rect(ppx-5, ppala-5, leveys+10, 10);

    //Liikutetaan putkia
    x = x - 3;
    x1 = x1 -3;
    ppx = ppx - 3;
    ppy = ppy - 3;

    if (ppx <= 0 - leveys) {
      ppx = 500;
      ppy = 500;
      piste = piste + 1;
      ppyla = random(25, 600);
      ppala = ppyla + vali;
    }
    if (x <= 0 - leveys) {
      x = 500;
      x1 = 500;
      piste = piste + 1;
      ylapituus  = random(25, 600);
      alapituus = ylapituus + vali;
    }
    //Linnun ja putkien hitboxit ja hit-reg
    //Ylaputket
    if ((korkeus - 10 <= ylapituus ) && (x < 60) && (x > 0)) {
      osuma = true;
    } 
    if ((korkeus - 10 <= ppyla) && (ppx < 60) && (ppx > 0)) {
      osuma = true;
    }
    //Maa ja katto
    if ((korkeus <= -10) || (korkeus + 10 >= height)) {
      osuma = true;
    } //Alaputket
    if ((korkeus + 10 >= alapituus) && (x1 < 60) && (x > 0)) {
      osuma = true;
    }
    if ((korkeus + 10 >= ppala) && (ppy < 60) && (ppy > 0)) {
      osuma = true;
    }
    //Pysäyttää pelin
    if (osuma == true) {
      peli = false;
      end = "Game over \n Score " + piste;
      fill(0, 0, 100);
      text(end, width/2, 200);
    }
  }
}

void keyPressed()
{
  if ((key == ' ') && (cooldown <= 0))
  {
    hyppy = true;
    ajastin = 11;
    cooldown = 160;
  }
}
//Restartaus
void mousePressed()
{
  if (peli == false) {
    piste = 0;
    korkeus = 400;
    hyppy = false;
    ajastin = 0;
    cooldown = 10;
    liike = 1;
    x = 500;
    x1 = 500;
    ppx = 750;
    ppy = 750;
    ppyla = random(25, 600);
    ppala = ppyla + vali;
    ylapituus = random(25, 600);
    alapituus = ylapituus + vali;
    osuma = false;
    peli = true;
  }
}
