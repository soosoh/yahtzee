//TODO: optimize using processing builtin //<>//
//DRY
//remove all constants
//remove unneccesary
//add comments
//change variable names
//change function names

boolean keyhold = false;
boolean mousehold = false;
boolean hover = false;

int turn = 1;
int rolls = 1;
boolean order = false;
boolean over = false;

Dice[] dices = new Dice[5];
ArrayList<Dice> hold = new ArrayList<>();
ArrayList<Integer> removed = new ArrayList<>();

final String[] labels = {"aces", "deuces", "threes", "fours", "fives", "sixes", "subtotal", "bonus", "choice", "4 of a kind", "full house", "small straight", "long straight", "yahtzee", "total"};
int[][] scores = {{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}};
boolean[][] open = {{true, true, true, true, true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true, true, true, true, true}};

final color white = color(239, 239, 239);
final color brown = color(152, 102, 52);
final color black = color(8, 15, 15);
final color red = color(184, 12, 9);
final color yellow = color(250, 169, 22);

final int half = 400;
final int holdhorizontal = 140;
final int holdgap = 130;
final int boardhorizontal = 640;
final int cardheight = 360;
final int gap = 20;
final int round = 30;
final int toptext = 80;
final int score1 = 1240;
final int score2 = 1400;

void setup() {
  size(1600, 800);

  resetDice();

  noStroke();

  rectMode(RADIUS);

  textSize(28);
}

void draw() {
  hover = false;

  renderBackground();

  hold();

  dices();

  rolls();

  scores();

  labels();

  if (hover) cursor(HAND);
  else cursor(ARROW);

  if (over) gameOver();
}

void resetDice() {
  for (int i = 0; i < dices.length; i++) {
    dices[i] = new Dice(false);
  }
}

void renderBackground() {
  background(brown);

  fill(black);
  rect(holdhorizontal, half, 100, cardheight, round);

  rect(boardhorizontal, half, cardheight, cardheight, round);
  fill(red);
  rect(boardhorizontal, half, cardheight - gap, cardheight - gap, round - gap);

  fill(white);
  rect(1300, half, 260, cardheight, round);
}

void hold() {
  for (int i = 0; i < hold.size(); i++) {
    int x = holdhorizontal;
    int y = holdhorizontal + holdgap * i;

    Dice holding = hold.get(i);
    int removedindex = removed.get(i);

    boolean hoverhold = holding.hover(x, y);

    holding.render(x, y, holding.number);

    if (hoverhold) hover = true;

    if (hover && mousePressed && !mousehold) {
      dices[removedindex] = new Dice(holding.number);
      dices[removedindex].scatter(dices);

      hold.remove(i);
      removed.remove(i);

      mousehold = true;
    }
  }
}

void dices() {
  for (int i = 0; i < dices.length; i++) {
    Dice dice = dices[i];

    if (dice.hover(dice.x, dice.y)) hover = true;

    if (dice.renderWithHover() && mousePressed && !mousehold) {
      if (hold.size() < dices.length) {
        dice.visible = false;

        hold.add(new Dice(dice.number, false));
        removed.add(i);
      }

      mousehold = true;
    }
  }
}

void rolls() {
  textAlign(CENTER);
  fill(white);

  text(rolls > 3 ? "All rolls used" : rolls + "/3", holdhorizontal, toptext);
}

void scores() {
  textAlign(LEFT);
  fill(yellow);

  text(turn + "/12", 1060, toptext);

  if (!order) fill(yellow);
  else fill(black);
  text("player 1", score1, toptext);
  displayScore(score1, 0);

  if (order) fill(yellow);
  else fill(black);
  text("player 2", score2, toptext);
  displayScore(score2, 1);
}

void displayScore(int x, int p) {
  int total = 0;

  for (int i = 0; i < 6; i++) {
    total += scores[p][i];

    if ((!order && p == 0 && open[0][i]) || (order && p == 1 && open[1][i])) {
      fill(yellow);
      text(count(i), x, 120 + 44 * i);
    } else {
      fill(black);
      text(scores[p][i], x, 120 + 44 * i);
    }
  }
  fill(black);
  text(total + "/63", x, 120 + 44 * 6);
  text(((total >= 63) ? "35" : "0") + "/35", x, 120 + 44 * 7);

  for (int i = 6; i < 12; i++) {
    total += scores[p][i];

    if ((!order && p == 0 && open[0][i]) || (order && p == 1 && open[1][i])) {
      fill(yellow);
      text(count(i+2), x, 120 + 44 * (i + 2));
    } else {
      fill(black);
      text(scores[p][i], x, 120 + 44 * (i + 2));
    }
  }
  fill(black);
  text(total, x, 120 + 44 * 14);
}

void labels() {
  for (int i = 0; i < 15; i++) {
    fill(8, 15, 15);
    if ((i != 6 && i != 7 && i != 14) && (1040 < mouseX && mouseX < 1560) && ((mouseY - 80) / 45 == i) && open[order ? 1 : 0][(i > 5) ? i - 2 : i]) {
      hover = true;
      fill(250, 169, 22);
      if (mousePressed && !mousehold) {
        scores[order ? 1 : 0][(i > 5) ? i - 2 : i] = count(i);
        open[order ? 1 : 0][(i > 5) ? i - 2 : i] = false;
        if (order) turn++;
        if (turn == 13) over = true;
        order = !order;

        for (int j = hold.size() - 1; j >= 0; j--) {
          hold.remove(j);
          removed.remove(j);
        }
        for (int j = 0; j < 5; j++) {
          dices[j] = new Dice();
          dices[j].visible = false;
        }
        rolls = 1;
        mousehold = true;
        return;
      }
    }
    text(labels[i], 1060, 120 + 44 * i);
  }
}

void gameOver() {
  background(184, 12, 9);
  int total1 = 0;
  for (int score : scores[0]) {
    total1 += score;
  }
  int total2 = 0;
  for (int score : scores[1]) {
    total2 += score;
  }
  textAlign(CENTER);
  textSize(60);
  fill(white);
  if (total1 != total2) {
    text(((total1 > total2) ? "player 1" : "player 2") +" wins", width/2, 200);
  } else {
    text("a tie", width/2, 200);
  }
  textSize(120);
  text(total1, width/2 - 300, 500);
  text(total2, width/2 + 300, 500);
}

int count(int type) {
  int count = 0;
  if (type == 0) {
    for (Dice dice : dices) {
      if (dice.visible && dice.number == 1) count++;
    }
    for (int i = 0; i < hold.size(); i++) {
      if (hold.get(i).number == 1) count++;
    }
    return count;
  } else if (type == 1) {
    for (Dice dice : dices) {
      if (dice.visible && dice.number == 2) count+=2;
    }
    for (int i = 0; i < hold.size(); i++) {
      if (hold.get(i).number == 2) count+=2;
    }
    return count;
  } else if (type == 2) {
    for (Dice dice : dices) {
      if (dice.visible && dice.number == 3) count+=3;
    }
    for (int i = 0; i < hold.size(); i++) {
      if (hold.get(i).number == 3) count+=3;
    }
    return count;
  } else if (type == 3) {
    for (Dice dice : dices) {
      if (dice.visible && dice.number == 4) count+=4;
    }
    for (int i = 0; i < hold.size(); i++) {
      if (hold.get(i).number == 4) count+=4;
    }
    return count;
  } else if (type == 4) {
    for (Dice dice : dices) {
      if (dice.visible && dice.number == 5) count+=5;
    }
    for (int i = 0; i < hold.size(); i++) {
      if (hold.get(i).number == 5) count+=5;
    }
    return count;
  } else if (type == 5) {
    for (Dice dice : dices) {
      if (dice.visible && dice.number == 6) count+=6;
    }
    for (int i = 0; i < hold.size(); i++) {
      if (hold.get(i).number == 6) count+=6;
    }
    return count;
  } else if (type == 8) {
    for (Dice dice : dices) {
      if (dice.visible) count+=dice.number;
    }
    for (int i = 0; i < hold.size(); i++) {
      count+=hold.get(i).number;
    }
    return count;
  } else if (type == 9) {
    for (Dice dice1 : dices) {
      int same = 0;
      for (Dice dice2 : dices) {
        if (dice2.visible && dice1.number == dice2.number) same++;
      }
      for (int i = 0; i < hold.size(); i++) {
        if (hold.get(i).number == dice1.number) same++;
      }
      if (same >= 4) return dice1.number * 4;
    }
    return 0;
  } else if (type == 10) {
    int empty = 0;
    for (int n = 1; n <= 6; n++) {
      boolean lonely = true;
      for (Dice dice2 : dices) {
        if (dice2.visible && n == dice2.number) lonely = false;
      }
      for (int i = 0; i < hold.size(); i++) {
        if (hold.get(i).number == n) lonely = false;
      }
      if (lonely) empty++;
    }
    if (empty == 4 && count(9) == 0) return count(8);
    return 0;
  } else if (type == 11) {
    int[] numbers = new int[5];
    int d = 0;
    for (Dice dice : dices) {
      if (dice.visible) {
        numbers[d] = dice.number;
        d++;
      }
    }
    for (int h = 0; h < hold.size(); h++) {
      numbers[d] = hold.get(h).number;
      d++;
    }
    int[] sorted = sort(numbers);
    int max = 1;
    int streak = 1;
    for (int i = 1; i < 5; i++) {
      if (sorted[i] == sorted[i - 1] + 1) {
        streak++;
        max = max(streak, max);
      } else if (sorted[i] != sorted[i - 1]) {
        streak = 1;
      }
    }
    if (max >= 4) return 15;
  } else if (type == 12) {
    int[] numbers = new int[5];
    int d = 0;
    for (Dice dice : dices) {
      if (dice.visible) {
        numbers[d] = dice.number;
        d++;
      }
    }
    for (int h = 0; h < hold.size(); h++) {
      numbers[d] = hold.get(h).number;
      d++;
    }
    int[] sorted = sort(numbers);
    int max = 1;
    int streak = 1;
    for (int i = 1; i < 5; i++) {
      if (sorted[i] == sorted[i - 1] + 1) {
        streak++;
        max = max(streak, max);
      } else if (sorted[i] != sorted[i - 1]) {
        streak = 1;
      }
    }
    if (max == 5) return 30;
  } else if (type == 13) {
    for (Dice dice1 : dices) {
      int same = 0;
      for (Dice dice2 : dices) {
        if (dice2.visible && dice1.number == dice2.number) same++;
      }
      for (int i = 0; i < hold.size(); i++) {
        if (hold.get(i).number == dice1.number) same++;
      }
      if (same == 5) return 50;
    }
    return 0;
  }
  return 0;
};

void keyPressed() {
  if (key != ' ') return;
  if (keyhold) return;
  if (rolls > 3) return;
  rolls++;
  for (Dice dice : dices) {
    if (rolls > 2 && !dice.visible) continue;
    dice.rollInBox(dices);
  }
  keyhold = true;
}

void keyReleased() {
  keyhold = false;
}

void mouseReleased() {
  mousehold = false;
}
