//Siendo la camara el centro, suponemos que hay una esfera alrededor de dicho punto,
//moviendo un punto por dicha esfera tenemos hacía donde mirara la camara.
//Variables relacionadas con el movimiento de la camara

float giro = 0.8;
float angXZ = 90.0;
float angYZ = 270.0;
float r = 20;
float ang = 0;
float vel = 20;


void camaraController(PVector i, PVector j, PVector k){
  //Flechas
  if(caseUp){
    PVector recorrido = j.copy();
    recorrido.setMag(vel);
    i.add(recorrido);
  }
  
  if(caseDown){
    PVector recorrido = j.copy();
    recorrido.setMag(vel);
    i.sub(recorrido);
  }
  
  if(caseRight){
    PVector recorrido;
    recorrido = j.cross(k);
    recorrido.setMag(vel);
    i.add(recorrido);
  }
  
  if(caseLeft){
    PVector recorrido;
    recorrido = j.cross(k);
    recorrido.setMag(vel);
    i.sub(recorrido);
  }
  
  //AWSD (Movimientos del ojo de la camara)
  if(caseW){
    PVector recorrido;
    recorrido = new PVector(0,1,0);
    recorrido.setMag(vel);
    i.sub(recorrido);
  }
  
  if(caseS){
    PVector recorrido;
    recorrido = new PVector(0,1,0);
    recorrido.setMag(vel);
    i.add(recorrido);
  }
  
  if(caseA){
    PVector v = new PVector(j.x, j.z);
    v.rotate(radians(-1.5));
    nave.rotateY(radians(1.5));
    j.set(v.x, j.y, v.y);
  }
  if(caseD){
    PVector v = new PVector(j.x, j.z);
    v.rotate(radians(1.5));
    nave.rotateY(radians(-1.5));
    j.set(v.x, j.y, v.y);
  }
}
