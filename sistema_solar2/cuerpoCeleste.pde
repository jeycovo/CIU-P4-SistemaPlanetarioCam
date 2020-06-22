
class cuerpoCeleste{
  PVector origen;
  PVector localizacion;
  PVector posicionActual;
  PShape formaPlaneta;
  PImage texturaPlaneta;
  String nombre;
  float vRotacion, vTraslacion, radio;
  cuerpoCeleste planetaOrigen;
  //int angT = 5;
  int angR = 0;
  
  //Creador de soles
  cuerpoCeleste(PVector origen, float radio, float vRotacion, String nombre, String dirTextura){
   this.nombre = nombre;
   this.origen = origen.copy();
   this.localizacion = new PVector(0,0,0);
   this.radio = radio;
   this.vRotacion = vRotacion;
   this.posicionActual = PVector.add(this.origen, this.localizacion);
   crearForma(dirTextura);
  }
   
  //Creador de cuerpos celestes que orbitan alrededor de algo
  cuerpoCeleste(cuerpoCeleste planetaOrigen, float radioOrbita, float radio, float vTraslacion, float vRotacion, String nombre, String dirTextura){
   this.nombre = nombre;
   this.localizacion = new PVector(radioOrbita, random(-radioOrbita,radioOrbita), random(-radioOrbita, radioOrbita));
   this.radio = radio;
   this.vRotacion = vRotacion;
   this.vTraslacion = vTraslacion;
   this.origen = planetaOrigen.posicionActual;
   this.planetaOrigen = planetaOrigen;
   this.posicionActual = PVector.add(this.origen, this.localizacion);
   crearForma(dirTextura);
  }
  
  //Crear forma del planeta
  void crearForma(String dirTextura){
    if (dirTextura != null){
      PImage img = loadImage(dirTextura);
      formaPlaneta = createShape(SPHERE, radio);
      formaPlaneta.setTexture(img);
      formaPlaneta.setStroke(0); 
    }else{
      fill(color(random(0,255),random(0,255),random(0,255)));
      formaPlaneta = createShape(SPHERE, radio); 
      formaPlaneta.setStroke(0); 
    }
  }
  
  //mostrar en el plano el objeto
  void mostrar(){
    shape(formaPlaneta);
  }
  
  //Movimiento del cuerpo celeste
  void traslacion(){
    if(planetaOrigen != null){
      this.localizacion.rotate(radians(this.vTraslacion));  
      this.origen = this.planetaOrigen.posicionActual;
    }
    this.posicionActual = PVector.add(this.origen, this.localizacion);
    translate(posicionActual.x, posicionActual.y, posicionActual.z);
  }
  
  void rotacion(){
    rotateX(-radians(75));
    rotateY(radians(angR));
    angR+= vRotacion;
    if(angR>360){ angR = 0; }
  }
  
  String getName(){
    return this.nombre;
  }
}
