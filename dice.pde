class Dice {
  int number;
  int x, y;
  public Dice(int x, int y) {
    number = (int) (Math.random() * 6 + 1);
    this.x = x;
    this.y = y;
  }
  public void transform(int x, int y) {
    this.x = x;
    this.y = y;
  }
  public void roll() {
    number = (int) (Math.random() * 6 + 1);
  }
  public void render() {
    rect(x, y, 50, 50, 20);
    if(number == 1) {
      
    }
    if(number == 2) {
      
    }
    if(number == 1) {
      
    }
    if(number == 2) {
      
    }
  }
}
