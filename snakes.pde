float x, y;
float xSpeed, ySpeed;
FloatList xTail, yTail;

float foodX, foodY;

int scl, total;

IntList scores;
boolean endScreen;

void setup() {
  size(800, 800);
  frameRate(10);
  textAlign(CENTER, CENTER);
  textSize(40);
  endScreen = false;
  x = 0;
  y = 0;
  xSpeed = 1;
  ySpeed = 0;
  total = 0;
  scl = 20;

  xTail = new FloatList();
  yTail = new FloatList();
  scores = new IntList();

  pickLocation();
}

void draw() {
  background(0);
  if (!endScreen) {
    eat();
    update();
    show();
    death();

    fill(255, 0, 0);
    rect(foodX, foodY, scl, scl);
  } else {
    int position = 100;
    for (int score : scores) {
      text(score, width / 2, position);
      position += 100;
    }
  }
}

void pickLocation() {
  foodX = floor(random(1, width / scl - 1));
  foodY = floor(random(1, height / scl - 1));
  foodX *= scl;
  foodY *= scl;
}

void show() {
  fill(#097E15);
  for (int i = 0; i < xTail.size(); i +=1) {
    rect(xTail.get(i), yTail.get(i), scl, scl);
  }

  rect(x, y, scl, scl);
}

void update() {
  if (total > 0) {
    if (total == xTail.size() && xTail.size() > 0) {
      xTail.remove(0);
      yTail.remove(0);
    }
    xTail.append(x);
    yTail.append(y);
  }



  x += xSpeed * scl;
  y += ySpeed * scl;
  x = constrain(x, 0, width - scl);
  y = constrain(y, 0, height - scl);
}

void death() {
  for (int i = 0; i < xTail.size(); i += 1) { 
    float d = dist(x, y, xTail.get(i), yTail.get(i));
    if ( d < 1) {
      scores.append(total);
      total = 0;
      xTail.clear();
      yTail.clear();
    }
  }
}

void eat() {
  float d = dist(x, y, foodX, foodY);
  if (d < 1) {
    total +=1;
    pickLocation();
  }
}

void keyPressed() {
  switch(keyCode) {
  case UP:
    xSpeed = 0;
    ySpeed = -1;
    break;
  case DOWN:
    xSpeed = 0;
    ySpeed = 1;
    break;
  case LEFT:
    xSpeed = -1;
    ySpeed = 0;
    break;
  case RIGHT:
    xSpeed = 1;
    ySpeed = 0;
    break;
  }
  if (key == ' ') {
    endScreen = true;
  }
}
