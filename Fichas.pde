public class Ficha {
  private PImage image_ficha;
  private int posx, posy;
  private boolean dama = false;
  
  public Ficha (PImage fichaI, int posx, int posy) {
    image_ficha = fichaI;
    this.posx = posx;
    this.posy = posy;
  }
  
  public void Cdama (boolean aux) {
    dama = true;
    if (aux) {
      image_ficha = loadImage("DamaBlancaR.png");
    } else {
      image_ficha = loadImage("DamaRojaR.png");
    }
  }
  
  public boolean getDama() {
    return dama;
  }
  
  public int getPosx() {
    return posx;
  }
  
  public int getPosy() {
    return posy;
  }
  
  public PImage getImage() {
    return image_ficha;
  }
  
  public void setPosx(int x) {
    this.posx = x;
  }
  
  public void setPosy(int y) {
    this.posy = y;
  }
  
}

public class Fichas {
  ArrayList<Ficha> lista_fichas = new ArrayList<Ficha>();
  
  public void addFicha (PImage fichaI, int posx, int posy) {
    Ficha f = new Ficha(fichaI, posx, posy);
    lista_fichas.add(f);
  } 
  
  public Object[] hitbox (int x_mouse, int y_mouse) {
    Object vec[] = new Object[2];
    for (Ficha f : lista_fichas) {
      if (f.getPosx() < x_mouse && (f.getPosx() + 84) > x_mouse) {
          if (f.getPosy() < y_mouse && (f.getPosy() + 84) > y_mouse) {
            int hit[] = new int[2];
            hit[0] = f.getPosx();
            hit[1] = f.getPosy();
            vec[0] = hit;
            return vec;
          }
      }
    }
    return null;
  }
  
  public void hitbox (int xi, int yi, int x_mouse, int y_mouse, int x, int y) {
    int i = 0;
    for (Ficha f : lista_fichas) {
      if (f.getPosx() < x_mouse && (f.getPosx() + 84) > x_mouse) {
          if (f.getPosy() < y_mouse && (f.getPosy() + 84) > y_mouse) {
            Ficha aux = lista_fichas.get(i);
            aux.setPosx(x + x_mouse - xi);
            aux.setPosy(y + y_mouse - yi);
            lista_fichas.set(i, aux);
          }
      }
      i++;
    }
  }
  
  public void hitbox (int x, int y, int xf, int yf) {
    int i = 0;
    for (Ficha f : lista_fichas) {
      if (f.getPosx() == x) {
          if (f.getPosy() == y) {
            Ficha aux = lista_fichas.get(i);
            aux.setPosx(xf);
            aux.setPosy(yf);
            lista_fichas.set(i, aux);
          }
      }
      i++;
    }
  }
  
  public boolean fcheck (int x, int y) {
    for (Ficha f : lista_fichas) {
      if (f.getPosx() == x) {
          if (f.getPosy() == y) {
            return true;
          }
      }
    }
    return false;
  }
  
  public void eliminarf (int x, int y) {
    int i = 0;
    for (Ficha f : lista_fichas) {
      if (f.getPosx() == x) {
          if (f.getPosy() == y) {
            lista_fichas.remove(i);
            return;  
          }
      }
      i++;
    }
  }
  
  public int buscarf(int x, int y) {
    int i = 0;
    for (Ficha f : lista_fichas) {
      if (f.getPosx() == x) {
          if (f.getPosy() == y) {
            return i;  
          }
      }
      i++;
    }
    return i;
  }
  
  public void coronarF (int x, int y, boolean colorf) {
    int i = 0;
    for (Ficha f : lista_fichas) {
      if (f.getPosx() == x) {
          if (f.getPosy() == y) {
            Ficha aux = lista_fichas.get(i);
            aux.Cdama(colorf);
            lista_fichas.set(i, aux);
            return;  
          }
      }
      i++;
    }
  }
  
  public boolean coronarV (int x, int y) {
    int i = 0;
    for (Ficha f : lista_fichas) {
      if (f.getPosx() == x) {
          if (f.getPosy() == y) {
            Ficha aux = lista_fichas.get(i);
            return aux.getDama();
          }
      }
      i++;
    }
    return false;
  }
  
}  
