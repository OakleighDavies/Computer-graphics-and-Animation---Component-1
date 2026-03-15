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

class Pellets {
  private static final int PELET_SIZE = 10;

  private boolean powerPelet;
  private float peletPosX, peletPosY;
  private boolean eaten;

  private PShape regPelet, powPelet;

  Pellets(boolean peletType, float peletPosX, float peletPosY) {
    this.powerPelet = peletType;
    this.peletPosX = peletPosX;
    this.peletPosY = peletPosY;
    this.eaten = false;

    regPelet = regularPelet();
    powPelet = powerPelet();
  }

  public float getPeletX() {
    return peletPosX;
  }
  public float getPeletY() {
    return peletPosY;
  }
  public boolean isEaten() {
    return eaten;
  }

  public void getEaten(Pacman pos) {
    if (eaten) return;
    if (collidesWith(pos)) {
      eaten = true;
    }
  }

  // Pelet eating
  private boolean collidesWith(Pacman pos) {
    float pacLeft = pos.getPacmanX() - pos.getWidth() / 2.0f;
    float pacRight = pos.getPacmanX() + pos.getWidth() / 2.0f;
    float pacTop = pos.getPacmanY() - pos.getHeight() / 2.0f;
    float pacBottom = pos.getPacmanY() + pos.getHeight() / 2.0f;

    float pelletWidth;
    float pelletHeight;

    if (!powerPelet) {
      pelletWidth = PELET_SIZE;
      pelletHeight = PELET_SIZE;
    } else {
      pelletWidth = 90 * 0.25f;   // 22.5
      pelletHeight = 90 * 0.25f;  // 22.5
    }

    float pelletLeft = peletPosX;
    float pelletRight = peletPosX + pelletWidth;
    float pelletTop = peletPosY;
    float pelletBottom = peletPosY + pelletHeight;

    return pacRight > pelletLeft &&
      pacLeft < pelletRight &&
      pacBottom > pelletTop &&
      pacTop < pelletBottom;
  }

  // "Getter" of sorts, to draw the instance
  void display() {
    if (eaten) return;

    if (powerPelet == true) {
      pushMatrix();

      translate(peletPosX, peletPosY);
      scale(0.25f);
      shape(powPelet);

      popMatrix();
    } else {
      shape(regPelet, peletPosX, peletPosY);
    }
  }

  private PShape regularPelet() {
    PShape regularPelet = createShape(RECT, 0, 0, PELET_SIZE, PELET_SIZE);
    regularPelet.setStroke(false);
    regularPelet.setFill(color(255));
    return regularPelet;
  }

  private PShape powerPelet() {
    PShape powerPelet = createShape();

    powerPelet.beginShape();
    powerPelet.vertex(0, 20);
    powerPelet.vertex(10, 20);
    powerPelet.vertex(10, 10);
    powerPelet.vertex(20, 10);
    powerPelet.vertex(20, 0);
    powerPelet.vertex(70, 0);
    powerPelet.vertex(70, 10);
    powerPelet.vertex(80, 10);
    powerPelet.vertex(80, 20);
    powerPelet.vertex(90, 20);
    powerPelet.vertex(90, 70);
    powerPelet.vertex(80, 70);
    powerPelet.vertex(80, 80);
    powerPelet.vertex(70, 80);
    powerPelet.vertex(70, 90);
    powerPelet.vertex(20, 90);
    powerPelet.vertex(20, 80);
    powerPelet.vertex(10, 80);
    powerPelet.vertex(10, 70);
    powerPelet.vertex(0, 70);
    powerPelet.endShape(CLOSE);

    powerPelet.setStroke(false);
    powerPelet.setFill(#FAD497);

    return powerPelet;
  }
}
