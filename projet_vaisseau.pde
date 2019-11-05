
boolean isKey;
boolean vaisseauKill;
boolean shoot;

int a;
int vaisseauX;
int vaisseauY;
int vitesseX;
int vitesseY;

float[] AbscisseStarX;
float[] CoorStarY;

int vitesseC;
int canonX;
int canonY1;
int canonY2;
int canonYT1;
int canonYT2;

int vitesseTir;

int cpt;
int cptDestroy;
int cptFrame;
int cptFrameStar;

color rouge = color(255, 0, 0);
color vert = color(0, 255, 0);
color blanc = color(255, 255, 255);
color bleu = color(0, 0, 255);
color valeur;
int o;

void initVariable() {
  o=0;
  vaisseauKill=false;
  isKey=false;
  shoot=false;

  background(0);
  frameRate(120);
  vitesseC=5;
  AbscisseStarX = new float[100];
  CoorStarY = new float[100];

  for (int i=0; i<100; i++) {
    AbscisseStarX[i] =random(800);
    CoorStarY[i] = random(800);
  }

  cptDestroy = 0;
  cptFrameStar = 20;
  vitesseX = 2;
  vitesseY = 2;

  canonX = width/2;
  canonY1 = height-10;
  canonY2 = height-25;
  canonYT1 = height-26;
  canonYT2 = height-32;

  vitesseTir = -3;

  vaisseauX = 130;
  vaisseauY = 100;
}


void setup() {
  initVariable();
  size(800, 600);

  cptDestroy = 0;
  cptFrameStar = 20;
  vitesseX = 2;
  vitesseY = 2;

  canonX = width/2;
  canonY1 = height-10;
  canonY2 = height-25;

  vitesseTir = -3;

  vaisseauX = 130;
  vaisseauY = 100;
}

void isKeyPressed() {
  if (key == CODED) {
    if (keyCode==RIGHT) {
      if (canonX<width) {
        canonX+=vitesseC;
      } else {
        canonX=width;
      }
    } else if (keyCode==LEFT) {
      if (canonX>0) {
        canonX -= vitesseC;
      } else {
        canonX=0;
      }
    } else if (keyCode==UP) {
      shoot = true;
      if(cptFrame>0) {
        cptFrame--;
      }
    }
  }
}

void createCanon() {
  strokeWeight(25);
  stroke(255, 255, 255);
  line(canonX, height, canonX, height);
  strokeWeight(4);
  stroke(255, 255, 255);
  line(canonX, canonY1, canonX, canonY2);
}

void createTir() {
  strokeWeight(5);
  stroke(255, 255, 255);
  line(canonX, canonYT1, canonX, canonYT2);
  canonYT1+=vitesseTir;
  canonYT2-=3;

  if (canonX>vaisseauX-25 && canonX<vaisseauX+25) {
    cptDestroy++;
     canonYT1 = height-26;
    canonYT2 = height-32;
    shoot=false;
  }
  if (canonYT2<=0) {
     canonYT1 = height-26;
  canonYT2 = height-32;
    shoot=false;
  }
}


void afficheVaisseau() {
  if (cptDestroy>=0 && cptDestroy<3 ) {
    ellipse(vaisseauX, vaisseauY, 50, 20);
    fill(bleu);
  } else if (cptDestroy>=3 && cptDestroy<6) {
    ellipse(vaisseauX, vaisseauY, 50, 20);
    fill(rouge);
  } else if (cptDestroy>=6 && cptDestroy<10) {
    ellipse(vaisseauX, vaisseauY, 50, 20);
    fill(vert);
  } else if (cptDestroy==10) {
    ellipse(vaisseauX, vaisseauY, 50, 20);
    fill(blanc);
    vaisseauKill=true;
    vitesseY = 10;
    vitesseX = 0;
  }
}

void gereRebond() {
  if (vaisseauX-25<0) {
    vitesseX =-vitesseX;
    cpt++;
  }
  if (vaisseauX+25>width ) {
    vitesseX = -vitesseX;
    cpt++;
  }
  if (vaisseauY-10<0 ) {
    vitesseY = -vitesseY;
    cpt++;
  }
  if (vaisseauY+10>height-100 && vaisseauKill==false) {
    vitesseY = -vitesseY;
    cpt++;
  }
}


void deplaceVaisseau() {
  vaisseauX += vitesseX;
  vaisseauY += vitesseY;
  noStroke();
}

void createStar() {
  if (cptFrameStar<1) {
    cptFrameStar=(int)random(50, 120);
  } else if (cptFrameStar<70 && cptFrameStar>1) {
    for (int i=0; i<15; i++) {
      strokeWeight(7);
      stroke(0, random(155, 255), 255);
      point(AbscisseStarX[i], CoorStarY[i]);
    }
    for (int i=15; i<35; i++) {
      strokeWeight(2);
      stroke(0, 255, random(155, 255));
      point(AbscisseStarX[i], CoorStarY[i]);
    }
  }

  if (cptFrameStar>0) {
    for (int i=0; i<15; i++) {
      strokeWeight(2);
      stroke(0, random(155, 255), 255);
      point(AbscisseStarX[i], CoorStarY[i]);
    }
    for (int i=15; i<35; i++) {
      strokeWeight(7);
      stroke(0, 255, random(155, 255));
      point(AbscisseStarX[i], CoorStarY[i]);
    }
    cptFrameStar--;
  }
} 

void draw() {
  background(0);
  createStar();
  text(cpt, width -50, height -20);
  text(cptDestroy, width -150, height -20);
  if (cptDestroy>=10) {
    text("YOU WIN", width/2, height/2);
    textSize(25);
  }

  afficheVaisseau();
  deplaceVaisseau();
  gereRebond();
  createCanon();
  if (isKey==true) 
    isKeyPressed();
  if (shoot==true) {  
    /*print("tir");//Problème toujours en true*/
    createTir();
  }
}

void mousePressed() {
  vitesseX=-vitesseX;
  vitesseY=-vitesseY;
}

/*void mouseDragged() {
 vaisseauX = mouseX;
 vaisseauY = mouseY;
 }*/

void keyReleased() {
  isKey=false;
}

void keyPressed() {
  isKey=true;
  shoot = false;

  cptFrame=10;
}
