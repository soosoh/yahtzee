void setup() {
  size(1600, 800);
}

void draw() {
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
  textAlign(CENTER);
  textSize(28);
  fill(250, 169, 22);
  text("player 1", 1300, 80);
  fill(8, 15, 15);
  text("player 2", 1460, 80);
  textAlign(LEFT);
  fill(8, 15, 15);
  text("aces", 1060, 120);
  text("deuces", 1060, 160);
  text("threes", 1060, 200);
  text("fours", 1060, 240);
  text("fives", 1060, 280);
  text("sixes", 1060, 320);
  text("subtotal", 1060, 360);
  text("bonus", 1060, 400);
  text("choice", 1060, 440);
  text("4 of a kind", 1060, 480);
  text("full house", 1060, 520);
  text("small straight", 1060, 560);
  text("long straight", 1060, 600);
  text("yacht", 1060, 640);
  text("total", 1060, 680);
}
