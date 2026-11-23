public class Dice {
  public int number;
  public int x, y;
  public boolean visible;

  public Dice() {
    roll();
    x = 0;
    y = 0;
    visible = true;
  }

  public Dice(boolean v) {
    roll();
    x = 0;
    y = 0;
    visible = v;
  }

  public Dice(int n) {
    number = n;
    x = 0;
    y = 0;
    visible = true;
  }

  public Dice(int n, boolean v) {
    number = n;
    x = 0;
    y = 0;
    visible = v;
  }

  public void rollInBox(Dice[] dices) {
    scatter(dices);
    roll();
    visible = true;
  }

  public void scatter(Dice[] dices) {
    boolean overlap = true;
    while (overlap) {
      this.x = int(random(350, 930));
      this.y = int(random(110, 690));
      overlap = false;
      for (Dice dice : dices) {
        if (dice == null || dice == this) continue;
        if (abs(dice.x - x) <= 100 && abs(dice.y - y) <= 100) {
          overlap = true;
          break;
        }
      }
    }
  }

  public void roll() {
    number = int(random(1, 7));
  }

  public boolean renderWithHover() {
    if (!visible) return false;
    render(x, y, number);
    return hover(x, y);
  }

  public void render(int x, int y, int n) {
    fill(239, 239, 239);
    rect(x, y, 50, 50, 20);
    fill(8, 15, 15);
    if (n == 1) {
      circle(x, y, 20);
    } else if (n == 2) {
      circle(x-30, y-30, 20);
      circle(x+30, y+30, 20);
    } else if (n == 3) {
      circle(x-30, y-30, 20);
      circle(x+30, y+30, 20);
      circle(x, y, 20);
    } else if (n == 4) {
      circle(x-30, y-30, 20);
      circle(x-30, y+30, 20);
      circle(x+30, y-30, 20);
      circle(x+30, y+30, 20);
    } else if (n == 5) {
      circle(x-30, y-30, 20);
      circle(x-30, y+30, 20);
      circle(x+30, y-30, 20);
      circle(x+30, y+30, 20);
      circle(x, y, 20);
    } else if (n == 6) {
      circle(x-30, y-30, 20);
      circle(x-30, y, 20);
      circle(x-30, y+30, 20);
      circle(x+30, y-30, 20);
      circle(x+30, y, 20);
      circle(x+30, y+30, 20);
    }
  }

  public boolean hover(int x, int y) {
    return abs(mouseX - x) <= 100 && abs(mouseY - y) <= 100;
  }
}
