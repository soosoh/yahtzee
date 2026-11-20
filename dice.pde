public class Dice {
  public int number;
  public int x, y;
  
  public Dice() {
    roll();
    x = 0;
    y = 0;
  }
  
  public Dice(int n) {
    number = n;
    x = 0;
    y = 0;
  }
  
  public void rollInBox(Dice[] dices) {
    boolean overlap = true;
    while(overlap) {
      this.x = int(random(350, 930));
      this.y = int(random(110, 690));
      overlap = false;
      for(Dice dice : dices) {
        if(dice == null || dice == this) continue;
        if(abs(dice.x - x) <= 100 && abs(dice.y - y) <= 100) {
          overlap = true;
          break;
        }
      }
    }
    this.roll();
  }
  
  public void roll() {
    number = int(random(1, 6));
  }
  
  public boolean renderWithHover() {
    render(x, y, number);
    return abs(mouseX - x) <= 100 && abs(mouseY - y) <= 100;
  }
  
  public void render(int x, int y, int n) {
    fill(239, 239, 239);
    rect(x, y, 50, 50, 20);
    fill(8, 15, 15);
    if (n == 1) {
      circle(x, y, 20);
    }
    else if (n == 2) {
      circle(x-30, y-30, 20);
      circle(x+30, y+30, 20);
    }
    else if (n == 3) {
      circle(x-30, y-30, 20);
      circle(x+30, y+30, 20);
      circle(x, y, 20);
    }
    else if (n == 4) {
      circle(x-30, y-30, 20);
      circle(x-30, y+30, 20);
      circle(x+30, y-30, 20);
      circle(x+30, y+30, 20);
    }
    else if (n == 5) {
      circle(x-30, y-30, 20);
      circle(x-30, y+30, 20);
      circle(x+30, y-30, 20);
      circle(x+30, y+30, 20);
      circle(x, y, 20);
    }
    else if (n == 6) {
      circle(x-30, y-30, 20);
      circle(x-30, y, 20);
      circle(x-30, y+30, 20);
      circle(x+30, y-30, 20);
      circle(x+30, y, 20);
      circle(x+30, y+30, 20);
    }
  }
}
