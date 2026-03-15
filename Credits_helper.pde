/*
* Copyright (C) 2026 Oakleigh Davies.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 */

float creditsY;
float creditScrollAccumulator = 0;

PShape tint_layer;

boolean credits_started = false;

void startCredits() {
  frameRate(120);
  
  creditsY = height; // init for height of credits page

  blinky.setGhostPos(-100/5, 420/5);
  inky.setGhostPos(218/5, 861/5);
  pinky.setGhostPos(1310/5, 232/5);
  clyde.setGhostPos(1182/5, 791/5);
  izike.setGhostPos(600/5, 1600/5);

  fruits[0].setFruitPos(900/5, 3300/5);
  fruits[1].setFruitPos(100/5, 1800/5);
  fruits[2].setFruitPos(1400/5, 1950/5);
  fruits[3].setFruitPos(400/5, 2300/5);
  fruits[4].setFruitPos(700/5, 2600/5);
  fruits[5].setFruitPos(200/5, 2950/5);

  pacman.setPosition(600/5, 5500/5);

  izike.setEyeDir("izike");

  // Defenitions for dimming layer
  tint_layer = createShape(RECT, 0, 0, width, height);
  tint_layer.setFill(color(0, 50));
  tint_layer.setStroke(false);

  credits_started = true;
}

void Roll_credits() {
  background(0);
  textAlign(CENTER, TOP);

  drawGhosts();

  // Dimming layer
  shape(tint_layer);

  for (int l = 0; l < credits.length; l++) {
    float y = creditsY + 50 * l;
    drawStyledLine(credits[l], width/2, y);
  }

  creditScrollAccumulator += 0.4;

  while (creditScrollAccumulator >= 1) {
    creditsY -= 1;
    creditScrollAccumulator -= 1;
  }
}

void drawStyledLine(String line, float x, float y) {
  fill(255);

  if (line.startsWith("<h1>") && line.endsWith("</h1>")) {
    String content = line.replace("<h1>", "").replace("</h1>", "");
    textFont(pixelated);
    textSize(20);
    text(content, x, y);
  } else if (line.startsWith("<b>") && line.endsWith("</b>")) {
    String content = line.replace("<b>", "").replace("</b>", "");
    textFont(pixelated);
    textSize(16);
    drawFakeBold(content, x, y);
  } else if (line.startsWith("<i>") && line.endsWith("</i>")) {
    String content = line.replace("<i>", "").replace("</i>", "");
    textFont(pixelated);
    textSize(14);
    drawFakeItalic(content, x, y);
  } else if (line.startsWith("<p>") && line.endsWith("</p>")) {
    String content = line.replace("<p>", "").replace("</p>", "");
    textFont(pixelated);
    textSize(14);
    text(content, x, y);
  } else {
    textFont(pixelated);
    textSize(14);
    text(line, x, y);
  }
}

// Bold text
void drawFakeBold(String content, float x, float y) {
  text(content, x, y);
  text(content, x + 1, y); // redraw over to make it look bold
}

// Italic text
void drawFakeItalic(String content, float x, float y) {
  pushMatrix();
  translate(x, y);
  shearX(-0.25); // a shear in drawing to falsify italic
  text(content, 0, 0);
  popMatrix();
}

void drawGhosts() {
  pushMatrix();

  // Enlargen ghosts
  scale(5);

  // Draw ghosts on credit scene
  blinky.display();
  inky.display();
  pinky.display();
  clyde.display();
  izike.display();

  fruits[0].display();
  fruits[1].display();
  fruits[2].display();
  fruits[3].display();
  fruits[4].display();
  fruits[5].display();

  pacman.display();

  // Slow upwards scrolling, parallax scrolling
  blinky.setGhostY(blinky.getGhostY() - 0.25/5);
  inky.setGhostY(inky.getGhostY() - 0.25/5);
  pinky.setGhostY(pinky.getGhostY() - 0.25/5);
  clyde.setGhostY(clyde.getGhostY() - 0.25/5);
  izike.setGhostY(izike.getGhostY() - 0.25/5);

  fruits[0].setFruitY(fruits[0].getFruitY() - 0.25/5);
  fruits[1].setFruitY(fruits[1].getFruitY() - 0.25/5);
  fruits[2].setFruitY(fruits[2].getFruitY() - 0.25/5);
  fruits[3].setFruitY(fruits[3].getFruitY() - 0.25/5);
  fruits[4].setFruitY(fruits[4].getFruitY() - 0.25/5);
  fruits[5].setFruitY(fruits[5].getFruitY() - 0.25/5);

  pacman.setPositionY(pacman.getPacmanY() - 0.5/5);

  popMatrix();
}
