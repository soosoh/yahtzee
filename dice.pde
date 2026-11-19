public class Dice {
  public int number;
  public int x, y;
  public Dice() {
    number = (int) (Math.random() * 6 + 1);
  }
  public void rollInBox(Dice[] dices) {
    boolean overlap = true;
    while(overlap) {
      this.x = (int) (Math.random() * 580) + 350;
      this.y = (int) (Math.random() * 580) + 110;
      overlap = false;
      for(Dice dice : dices) {
        if(dice == null) break;
        if((dice.x-50 < x-50 && x-50 < dice.x+50) && (dice.y-50 < y-50 && y-50 < dice.y+50)) overlap = true;
        if((dice.x-50 < x+50 && x+50 < dice.x+50) && (dice.y-50 < y-50 && y-50 < dice.y+50)) overlap = true;
        if((dice.x-50 < x+50 && x+50 < dice.x+50) && (dice.y-50 < y+50 && y+50 < dice.y+50)) overlap = true;
        if((dice.x-50 < x-50 && x-50 < dice.x+50) && (dice.y-50 < y+50 && y+50 < dice.y+50)) overlap = true;
      }
    }
    this.roll();
  }
  public void roll() {
    number = (int) (Math.random() * 6 + 1);
  }
  public void render() {
    fill(239, 239, 239);
    rect(x, y, 50, 50, 20);
    fill(8, 15, 15);
    if (number == 1) {
      circle(x, y, 20);
    }
    else if (number == 2) {
      circle(x-30, y-30, 20);
      circle(x+30, y+30, 20);
    }
    else if (number == 3) {
      circle(x-30, y-30, 20);
      circle(x+30, y+30, 20);
      circle(x, y, 20);
    }
    else if (number == 4) {
      circle(x-30, y-30, 20);
      circle(x-30, y+30, 20);
      circle(x+30, y-30, 20);
      circle(x+30, y+30, 20);
    }
    else if (number == 5) {
      circle(x-30, y-30, 20);
      circle(x-30, y+30, 20);
      circle(x+30, y-30, 20);
      circle(x+30, y+30, 20);
      circle(x, y, 20);
    }
    else if (number == 6) {
      circle(x-30, y-30, 20);
      circle(x-30, y, 20);
      circle(x-30, y+30, 20);
      circle(x+30, y-30, 20);
      circle(x+30, y, 20);
      circle(x+30, y+30, 20);
    }
  }
}
