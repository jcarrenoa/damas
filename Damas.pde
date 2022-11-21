PImage tablero, damaBlanca, damaRoja;
Fichas negras = new Fichas();
Fichas blancas = new Fichas();
int xi, yi, x, y, xf, yf;
boolean selected = false;
int intcolor = 0;
boolean intcolorb = false;
//Falso para rojas y verdadero para blancas
boolean ficha_selected = false, ficha_selected_D = false;
int turno = 0;
PImage cabum[] = new PImage[7];
boolean cabumb = false;
int x_fire = 0, y_fire = 0, animacion_fire = 0;
int shake = 12, shakef, signo = 1;
boolean shakeb = false;

void setup() {
  size(1024, 700);
  background(255);
  frameRate(35);
  tablero = loadImage("Tablero.png");
  damaBlanca = loadImage("DamaBlanca.png");
  damaRoja = loadImage("DamaRoja.png");
  for (int i = 0; i < 7; i++) {
    cabum[i] = loadImage("cabum" + i + ".png");
  }
  image(tablero, 0, 0);
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 4; j++) {
      if (i % 2 == 0) {
        blancas.addFicha(damaBlanca, 14 + (j * 84 * 2), 14 + ((i) * 84));
        image(damaBlanca, 14 + (j * 84 * 2), 14 + ((i) * 84));
      } else {
        blancas.addFicha(damaBlanca, 98 + (j * 84 * 2), 14 + ((i) * 84));
        image(damaBlanca, 98 + (j * 84 * 2), 14 + ((i) * 84));
      }
    }
  }
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 4; j++) {
      if (i % 2 == 0) {
        negras.addFicha(damaRoja, 98 + (j * 84 * 2), 602 - ((i) * 84));
        image(damaRoja, 98 + (j * 84 * 2), 602 - ((i) * 84));
      } else {
        negras.addFicha(damaRoja, 14 + (j * 84 * 2), 602 - ((i) * 84));
        image(damaRoja, 14 + (j * 84 * 2), 602 - ((i) * 84));
      }
    }
  }
}
 
void draw() {
    image(tablero, 0, 0);
    if (selected) {
      noStroke();
      if (intcolor == 50) {
        intcolorb = true;
      } else if (intcolor == 0) {
        intcolorb = false;
      }
      fill(125, 255, 144 + intcolor);
      rect(x, y, 84, 84);
      fill(95 + intcolor);
      if (!ficha_selected) {
        if (ficha_selected_D) {
          int i = 1;
          while ((x +(i * 84)) < 680) {
            rect(x + (i * 84), y + (i * 84), 84, 84);
            i++;
          }
          i = 1;
          while ((x - (i * 84)) > 0) {
            rect(x - (i * 84), y + (i * 84), 84, 84);
            i++;
          }
        } else {
            if (y - 84 < 0) {
          } else {
            if (x - 84 < 0) {
            } else {
              rect(x - 84, y - 84, 84, 84);
            }
            if (x + 84 > 680) {
            } else {
              rect(x + 84, y - 84, 84, 84);
            }
          }
        }
      } else {
        if (ficha_selected_D) {
          int i = 1;
          while ((x + (i * 84)) < 680) {
            rect(x + (i * 84), y - (i * 84), 84, 84);
            i++;
          }
          i = 1;
          while ((x - (i * 84)) > 0) {
            rect(x - (i * 84), y - (i * 84), 84, 84);
            i++;
          }
        } else {
          if (y + 84 > 680) {
          } else {
            if (x - 84 < 0) {
            } else {
              rect(x - 84, y + 84, 84, 84);
            }
            if (x + 84 > 680) {
            } else {
              rect(x + 84, y + 84, 84, 84);
            }
          }
        }
      }
      if (intcolorb){
        intcolor--;
      } else {
        intcolor++;
      }
    }
    int i = 0;
    for (Ficha f : blancas.lista_fichas) {
      if (i == shakef && shakeb && ficha_selected) {
        image(f.getImage(), f.getPosx() + (signo * shake), f.getPosy());
        signo = signo * -1;
        shake--;
        if (shake == 0) {
          shakeb = false;
          shake = 12;
        }
      } else {      
        image(f.getImage(), f.getPosx(), f.getPosy());
      }
      i++;
    }
    i = 0;
    for (Ficha f : negras.lista_fichas) {
      if (i == shakef && shakeb && !ficha_selected) {
        image(f.getImage(), f.getPosx() + (signo * shake), f.getPosy());
        signo = signo * -1;
        shake--;
        if (shake == 0) {
          shakeb = false;
          shake = 12;
        }
      } else {
        image(f.getImage(), f.getPosx(), f.getPosy());
      }
      i++;
    }
    if (cabumb) {
      image(cabum[animacion_fire], x_fire, y_fire);
      animacion_fire++;
      animacion_fire = animacion_fire % 7;
      if (animacion_fire == 0) {
        cabumb = false;
        x_fire = 0;
        y_fire = 0;
      }
    }
    //Mover fichas arrastrando el mouse
  /*if (mousePressed == true) {
    blancas.hitbox(xi, yi, mouseX, mouseY, x, y);
    negras.hitbox(xi, yi, mouseX, mouseY, x, y);
  }*/
}

//Mover fichas arrastrando el mouse
/*public void mouseMoved() {
  xi = mouseX;
  yi = mouseY;
  int aux[] = blancas.hitbox(mouseX, mouseY);
  if (aux == null) {
    aux = negras.hitbox(mouseX, mouseY);
  }
  if (aux != null) {
    x = aux[0];
    y = aux[1];
  }
}*/

//Mover fichas designando una posicion
public void mousePressed() {
  if (selected) {
    if (ficha_selected) {
      int hit[] = hitmoved(x, y, mouseX, mouseY, ficha_selected);
      if (hit != null) {
        boolean auxn2 = false;
        boolean auxn = negras.fcheck(hit[0], hit[1]);
        if (x > hit[0]) {
          auxn2 = negras.fcheck(hit[0] - 84, hit[1] + 84);
          if (!auxn2) {
            auxn2 = blancas.fcheck(hit[0] - 84, hit[1] + 84);
          }
        } else { 
          auxn2 = negras.fcheck(hit[0] + 84, hit[1] + 84);
          if (!auxn2) {
            auxn2 = blancas.fcheck(hit[0] + 84, hit[1] + 84);
          }
        }
        boolean aux = blancas.fcheck(hit[0], hit[1]);
        if (!aux && hit[0] > 0 && hit[0] < 680 && hit[1] > 0 && hit[1] < 680) {
          if (auxn) {
            if (auxn2 || hit[0] - 84 < 0 || hit[0] + 84 > 680 || hit[1] - 84 < 0 || hit[1] + 84 > 680) {
              shakef = blancas.buscarf(x, y);
              shakeb = true;
            } else {
              if (hit[1] + 84 == 602 && !blancas.coronarV(x, y)) {
                blancas.coronarF(x, y, true);
              }
              if (x > hit[0]) {
                blancas.hitbox(x, y, hit[0] - 84, hit[1] + 84);
              } else { 
                blancas.hitbox(x, y, hit[0] + 84, hit[1] + 84);
              }
              negras.eliminarf(hit[0], hit[1]);
              x_fire = hit[0];
              y_fire = hit[1];
              cabumb = true;
              turno = 1;
            }
          } else {
            if (hit[1] == 602 && !blancas.coronarV(x, y)) {
              blancas.coronarF(x, y, true);
            }
            blancas.hitbox(x, y, hit[0], hit[1]);
            turno = 1;
          }
        } else {
          shakef = blancas.buscarf(x, y);
          shakeb = true;
        }
      } else {
        shakef = blancas.buscarf(x, y);
        shakeb = true;
      }
    } else {
      int hit[] = hitmoved(x, y, mouseX, mouseY, ficha_selected);
      if (hit != null) {
        boolean auxn2 = false;
        boolean auxn = blancas.fcheck(hit[0], hit[1]);
        boolean aux = negras.fcheck(hit[0], hit[1]);
        if (x > hit[0]) {
          auxn2 = blancas.fcheck(hit[0] - 84, hit[1] - 84);
          if (!auxn2) {
            auxn2 = negras.fcheck(hit[0] - 84, hit[1] - 84);
          }
        } else { 
          auxn2 = blancas.fcheck(hit[0] + 84, hit[1] - 84);
          if (!auxn2) {
            auxn2 = negras.fcheck(hit[0] + 84, hit[1] - 84);
          }
        }
        if (!aux && hit[0] > 0 && hit[0] < 680 && hit[1] > 0 && hit[1] < 680) {
          if (auxn) {
            if (auxn2 || hit[0] - 84 < 0 || hit[0] + 84 > 680 || hit[1] - 84 < 0 || hit[1] + 84 > 680) {
              shakef = negras.buscarf(x, y);
              shakeb = true;
            } else {
              if (hit[1] - 84 == 14 && !negras.coronarV(x, y)) {
                negras.coronarF(x, y, false);
              }
              if (x > hit[0]) {
                negras.hitbox(x, y, hit[0] - 84, hit[1] - 84);
              } else { 
                negras.hitbox(x, y, hit[0] + 84, hit[1] - 84);
              }
              blancas.eliminarf(hit[0], hit[1]);
              x_fire = hit[0];
              y_fire = hit[1];
              cabumb = true;
              turno = 0;
            }
          } else {
            if (hit[1] == 14 && !negras.coronarV(x, y)) {
              negras.coronarF(x, y, false);
            }
            negras.hitbox(x, y, hit[0], hit[1]);
            turno = 0;
          }
        } else {
          shakef = negras.buscarf(x, y);
          shakeb = true;
        }
      } else {
        shakef = negras.buscarf(x, y);
        shakeb = true;
      }
    }  
    selected = false;
  } else {
    int aux[] = null;
    if (blancas.hitbox(mouseX, mouseY) != null && turno == 0) {
      aux = (int[]) blancas.hitbox(mouseX, mouseY)[0];
      ficha_selected = true;
      ficha_selected_D = blancas.coronarV(aux[0], aux[1]);
    } else if (negras.hitbox(mouseX, mouseY) != null && turno == 1) {
       aux = (int[]) negras.hitbox(mouseX, mouseY)[0];
       ficha_selected = false;
       ficha_selected_D = negras.coronarV(aux[0], aux[1]);
    }
    if (aux != null) {
      x = aux[0];
      y = aux[1];
      selected = true;
    } else {
      selected = false;
    }
  }
}

/*public void mouseDragged() {
  System.out.println(xi);
  xi = mouseX;
  yi = mouseY;
}*/

public int[] moved () {
  int pos[] = (int[])blancas.hitbox(mouseX, mouseY)[0];
  return pos;
}

public int[] hitmoved(int x, int y, int xm, int ym, boolean ficha) {
  int hit[] = new int[2];
  if (ficha) {
    if (x + 84 < xm && x + 168 > xm) {
      if (y + 84 < ym && y + 168 > ym) {
        hit[0] = x + 84;
        hit[1] = y + 84;
        return hit;
      }
    }
    if (x > xm && x - 84 < xm) {
      if (y + 84 < ym && y + 168 > ym) {
        hit[0] = x - 84;
        hit[1] = y + 84;
        return hit;
      }
    }
  } else {
    if (x + 84 < xm && x + 168 > xm) {
      if (y > ym && y - 84 < ym) {
        hit[0] = x + 84;
        hit[1] = y - 84;
        return hit;
      }
    }
    if (x > xm && x - 84 < xm) {
      if (y > ym && y - 84 < ym) {
        hit[0] = x - 84;
        hit[1] = y - 84;
        return hit;
      }
    }
  }  
  return null;
}
