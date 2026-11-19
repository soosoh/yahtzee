Dice[] dices = new Dice[5];
boolean hold = false;
int turn = 0;
boolean order = false;
boolean gameOver = false;

void setup() {
  size(1600, 800);
  for(int i = 0; i < 5; i++) {
    dices[i] = new Dice();
    dices[i].rollInBox(dices);
  }
}

void draw() {
  if(gameOver) {
    background(184, 12, 9);
    return;
  }
  background(152, 102, 52);
  noStroke();
  rectMode(RADIUS);
  fill(8, 15, 15);
  rect(140, 400, 100, 360, 30);
  fill(8, 15, 15);
  rect(640, 400, 360, 360, 30);
  fill(184, 12, 9);
  rect(640, 400, 340, 340, 10);
  fill(239, 239, 239);
  rect(1300, 400, 260, 360, 30);
  fill(239, 239, 239);
  rect(140, 140, 50, 50, 20);
  rect(140, 270, 50, 50, 20);
  rect(140, 400, 50, 50, 20);
  rect(140, 530, 50, 50, 20);
  rect(140, 660, 50, 50, 20);
  for(Dice dice : dices) {
    dice.render();
  }
  textAlign(LEFT);
  textSize(28);
  fill(250, 169, 22);
  text("player 1", 1240, 80);
  fill(8, 15, 15);
  text("player 2", 1400, 80);
  textAlign(LEFT);
  fill(250, 169, 22);
  text(turn + "/12", 1060, 80);
  fill(8, 15, 15);
  text("aces", 1060, 120);
  text("deuces", 1060, 165);
  text("threes", 1060, 210);
  text("fours", 1060, 255);
  text("fives", 1060, 300);
  text("sixes", 1060, 345);
  text("subtotal", 1060, 390);
  text("bonus", 1060, 435);
  text("choice", 1060, 480);
  text("4 of a kind", 1060, 525);
  text("full house", 1060, 570);
  text("small straight", 1060, 615);
  text("long straight", 1060, 660);
  text("yahtzee", 1060, 705);
  text("total", 1060, 745);
  fill(250, 169, 22);
  text("0", 1240, 120);
  text("0", 1240, 165);
  text("0", 1240, 210);
  text("0", 1240, 255);
  text("0", 1240, 300);
  text("0", 1240, 345);
  text("0", 1240, 390);
  text("0", 1240, 435);
  text("0", 1240, 480);
  text("0", 1240, 525);
  text("0", 1240, 570);
  text("0", 1240, 615);
  text("0", 1240, 660);
  text("0", 1240, 705);
  text("0", 1240, 745);
  fill(8, 15, 15);
  text("0", 1400, 120);
  text("0", 1400, 165);
  text("0", 1400, 210);
  text("0", 1400, 255);
  text("0", 1400, 300);
  text("0", 1400, 345);
  text("0", 1400, 390);
  text("0", 1400, 435);
  text("0", 1400, 480);
  text("0", 1400, 525);
  text("0", 1400, 570);
  text("0", 1400, 615);
  text("0", 1400, 660);
  text("0", 1400, 705);
  text("0", 1400, 745);
}

void keyPressed() {
  if(hold) return;
  if(!order) {
    turn++;
  }
  if(turn == 13) {
    gameOver = true;
  }
  order = !order;
  for(Dice dice : dices) {
    dice.rollInBox(dices);
  }
  hold = true;
}

void keyReleased() {
  hold = false;
}
