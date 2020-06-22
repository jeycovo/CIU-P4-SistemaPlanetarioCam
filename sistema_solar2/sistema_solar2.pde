
//Hashmap creado para almacenar los planetas con su información, el nombre del planeta será la clave
import java.util.Map;
ArrayList <cuerpoCeleste> sistemaSolar;
//cases
boolean caseUp = false;
boolean caseDown = false;
boolean caseRight = false;
boolean caseLeft = false;
boolean caseW = false;
boolean caseS = false;
boolean caseA = false;
boolean caseD = false;

float mov = 25;

//movidas
PVector i;
PVector j;
PVector k;

PImage bg;
PShape nave;
int vista = 0;
int indiceCuerpos = 0;

//Textos a mostrar
String t = "W -> subir nave  \nS -> bajar nave \nA -> Giro nave a la izquierda \nD -> Giro nave a la derecha ";
String t2 ="FlechaArriba\t-> Avanzar la nave \nFlechaAbajo\t-> Retroceder la nave \nFlechaDerecha\t-> Desplazarse a la derecha \nFlechaIzquierda\t-> Desplazarse a la izquierda";
String t3 ="X -> Cambiar de vista";
String t4 ="C -> Cambiar de planeta";
String v0 = "Vista General";
String v1 = "Vista Planeta";
String v2 = "Vista Nave";
      
void setup(){
  //creamos un nuevo diccionario con los planetas y sus medidas:
  //radio, velocidad de rotacion, velocidad de translación, orbita,
  sistemaSolar = new ArrayList <cuerpoCeleste>();

  //Creamos y metemos los planetas
  size(1280,1024,P3D);
  //cuerpoCeleste(PVector origen, float radio, float vRotacion, String nombre, String dirTextura){
  //cuerpoCeleste(cuerpoCeleste planetaOrigen, float radioOrbita, float radio, float vTraslacion, float vRotacion, String nombre, String dirTextura){
  
  PVector OrigenSol = new PVector(width/2, height/2, 0);
  cuerpoCeleste sol = new cuerpoCeleste(OrigenSol, 100, 2, "Sol", "2k_sun.jpg");
  sistemaSolar.add(sol);
  sistemaSolar.add(new cuerpoCeleste(sol, 500, 50, 0.3, 2,"Selenio", "2k_mercury.jpg"));
  sistemaSolar.add(new cuerpoCeleste(sol, 570,  60,   0.2,    3,    "Radon",    "2k_venus_surface.jpg"));
  sistemaSolar.add(new cuerpoCeleste(sol, 750,  70,   0.3,    2,    "Tantalio", "2k_earth_daymap.jpg"));
  
  
  cuerpoCeleste iridio = new cuerpoCeleste(sol, 900,  40,   0.5,    2,    "Iridio",   "2k_mars.jpg");
  sistemaSolar.add(iridio);
  sistemaSolar.add(new cuerpoCeleste(iridio, 120,  30,  1,    2.5,    "Helio",    "2k_jupiter.jpg"));
  sistemaSolar.add(new cuerpoCeleste(iridio, 190,  30,  1,    2.5,    "AuroraX2",    "2k_saturn.jpg"));
  
  cuerpoCeleste polonio = new cuerpoCeleste(sol, 1300, 60,  0.8,  2,    "Polonio",  "2k_saturn.jpg");
  sistemaSolar.add(polonio);
  
  sistemaSolar.add(new cuerpoCeleste(polonio, 200,  25,  1.3,   2,    "Hafnio",    "2k_neptune.jpg"));
  sistemaSolar.add(new cuerpoCeleste(polonio, 245,  20,  0.5,   2,    "Escandio",  "2k_moon.jpg"));
  sistemaSolar.add(new cuerpoCeleste(polonio, 160,  40,  2,     2,    "Galio",     "2k_mercury.jpg"));
  
  
  /*
  sistemaSolar.add(new cuerpoCeleste(sol, 500, 50, 0.3, 2,"Selenio", null));
  sistemaSolar.add(new cuerpoCeleste(sol, 570,  60,   0.2,    3,    "Radon",    "2k_venus_surface.jpg"));
  sistemaSolar.add(new cuerpoCeleste(sol, 750,  70,   0.3,    2,    "Tantalio", "2k_earth_daymap.jpg"));
  
  
  cuerpoCeleste iridio = new cuerpoCeleste(sol, 900,  30,   2,    2,    "Iridio",   "2k_mars.jpg");
  sistemaSolar.add(iridio);
  sistemaSolar.add(new cuerpoCeleste(iridio, 120,  100,  1,    2.5,    "Helio",    "2k_jupiter.jpg"));
  
  cuerpoCeleste polonio = new cuerpoCeleste(sol, 1500, 150,  2.5,  4,    "Polonio",  "2k_saturn.jpg");
  sistemaSolar.add(polonio);
  
  sistemaSolar.add(new cuerpoCeleste(polonio, 150,  15,  2.3,   2,    "Hafnio",    "2k_moon.jpg"));
  sistemaSolar.add(new cuerpoCeleste(polonio, 190,  10,  1.5,   2,    "Escandio",  "2k_neptune.jpg"));
  sistemaSolar.add(new cuerpoCeleste(polonio, 120,  20,  2,     2,    "Galio",     "2k_mercury.jpg"));
  
  */

  //Imagen de fondo
  bg = loadImage("2k_stars.jpg");
  
  //Ajustamos texto
  textSize(25);
  
  //Coordenadas camara
  i = new PVector(width/2,height/2+100, 2000);
  j = new PVector(0,0,-300);
  k = new PVector(0,1,0);
  
  //Creamos la nave
  crearNave();
}

void draw(){
//Nos situamos en medio de la pantalla
  bg.resize(width,height);
  background(bg);
  
  //Gestión de Camaras
  PVector camRelativa = PVector.add(i,j);
  if(vista == 0){
    camera(width*0.5, height*0.5, 2000, width*0.5, height*0.5, 0, 0, 1, 0);
    push();
      translate(width*0.5, height*0.5, 0);
      textAlign(CENTER);
      textSize(80);
      fill(255);
      text(v0, 0, -height,0);
      textSize(40);
      fill(color(100,200,120));
      text("Controles -", -width+30, height-520,0);
      textAlign(LEFT);
      text(t3 , -(width+60), height-450,0); 
      text("-----------------------------", -(width+60), height-420,0);
      text(t , -(width+60), height-380, 0);
      text("-----------------------------", -(width+60), height-170, 0);
      text(t2 , -(width+60), height-140, 0);
    pop();
  }else if(vista == 1){
    cuerpoCeleste c = sistemaSolar.get(indiceCuerpos);
    camRelativa = PVector.add(c.posicionActual, new PVector(0,0,800));
    camera(camRelativa.x, camRelativa.y, camRelativa.z, c.posicionActual.x, c.posicionActual.y, c.posicionActual.z, k.x, k.y, k.z);
    push();
      translate(c.posicionActual.x, c.posicionActual.y, c.posicionActual.z-200);
      textAlign(CENTER);
      textSize(80);
      fill(255);
      text(v1, 0, -height/2.0, -400);
      textSize(40);
      fill(color(100,200,120));
      text("Controles -", -550, +350, 0);
      textAlign(LEFT);
      text(t3, -650, +400, 0);
      text(t4, -650, +450, 0);
    pop();  
  } else {
    camera(i.x, i.y, i.z, camRelativa.x, camRelativa.y, camRelativa.z, k.x, k.y, k.z);
    push();
      translate(width*0.5, height*0.5, 0);
      textAlign(CENTER);
      textSize(80);
      fill(255);
      text(v2, 0, -height,0);
      textSize(40);
      fill(color(100,200,120));
      text("Controles -", -width+30, height-520,0);
      textAlign(LEFT);
      text(t3 , -(width+60), height-450,0); 
      text("-----------------------------", -(width+60), height-420,0);
      text(t , -(width+60), height-380, 0);
      text("-----------------------------", -(width+60), height-170, 0);
      text(t2 , -(width+60), height-140, 0);
    pop();
  }
  println(vista);
  //dibujo de la nave
  pushMatrix();
  translate(camRelativa.x, camRelativa.y+50, camRelativa.z);
  shape(nave);
  
  popMatrix();
  
  //Creación de la galaxia
  textAlign(CENTER);
  for(cuerpoCeleste objeto: sistemaSolar){
    push();
    objeto.traslacion();
    objeto.rotacion();
    objeto.mostrar();
    //mostramos el texto
    pop();
    fill(color(200,220,100));
    textSize(40);
    text(objeto.getName(), objeto.posicionActual.x, objeto.posicionActual.y + objeto.radio + 50, objeto.posicionActual.z);
  }
    //Movimiento camara
    //Solo lo llamamos si ha habido algúna modificación del movimiento
    if(caseUp || caseDown || caseRight || caseLeft || caseA || caseW || caseD || caseS){
      camaraController(i, j, k);
    }
} //<>// //<>//


void crearNave(){
  int h = 20;
  int w = 30;
  int d = 50;
  nave = createShape();
  nave.beginShape(TRIANGLE_STRIP);
  nave.fill(color(255,0,0));
  nave.vertex(-w*0.5, 0, 0);
  nave.vertex( w*0.5, 0, 0);
  nave.vertex( 0    , 0, d);
  nave.vertex(-w*0.5, 0, 0);
  nave.vertex( 0    , h, 0);
  nave.vertex( 0    , 0, d);
  nave.vertex( w*0.5, 0, 0);
  nave.vertex( 0    , h, 0);
  nave.vertex( 0    , 0, d);
  nave.endShape(CLOSE);
  nave.rotateY(radians(180));
}
