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

public static final color PACMAN_YELLOW = #FFFF00;

class Pacman {
  // Coordinate position
  private float pacXPos, pacYPos;

  // Instance 2D size
  private float pacW, pacH;
  private PShape Pac_man;

  Pacman(float pacXPos, float pacYPos, float pacW, float pacH) {
    this.pacXPos = pacXPos;
    this.pacYPos = pacYPos;
    this.pacW = pacW;
    this.pacH = pacH;

    Pac_man = createShape();
  }

  public float getPacmanX() {
    return pacXPos;
  }
  public float getPacmanY() {
    return pacYPos;
  }

  public Pacman setPosition(float updX, float updY) {
    this.pacXPos = updX;
    this.pacYPos = updY;
    return this;
  }

  public Pacman setPositionX(float updX) {
    this.pacXPos = updX;
    return this;
  }

  public Pacman setPositionY(float updY) {
    this.pacYPos = updY;
    return this;
  }

  // "Getter" of sorts, to draw the instance
  void display() {
    updatePacMan();
    pushMatrix();
    translate(pacXPos, pacYPos);
    shape(Pac_man);
    popMatrix();
  }

  void updatePacMan() {
    float mouth = abs(sin(millis()/130.0f));

    Pac_man = createShape();
    Pac_man.beginShape();
    Pac_man.fill(255, 255, 0);
    Pac_man.noStroke();

    // Center at origin
    Pac_man.vertex(0, 0);

    int detail = 40;
    for (int i = 0; i <= detail; i++) {
      float angle = map(i, 0, detail, mouth, TWO_PI - mouth);
      float x = cos(angle) * (pacW * 0.5f);
      float y = sin(angle) * (pacH * 0.5f);
      Pac_man.vertex(x, y);
    }

    Pac_man.endShape(CLOSE);
  }

  void updatePacMan(float rotation) {
    pushMatrix();

    float mouth = abs(sin(millis()/130.0f));

    Pac_man = createShape();
    Pac_man.beginShape();
    Pac_man.fill(255, 255, 0);
    Pac_man.noStroke();

    // Center at origin
    Pac_man.vertex(0, 0);

    int detail = 40;
    for (int i = 0; i <= detail; i++) {
      float angle = map(i, 0, detail, mouth, TWO_PI - mouth);
      float x = cos(angle) * (pacW * 0.5f);
      float y = sin(angle) * (pacH * 0.5f);
      Pac_man.vertex(x, y);
    }

    rotate(rotation);

    Pac_man.endShape(CLOSE);

    popMatrix();
  }

  // PShape helper for the pacmen leaves on the trees applicable
  PShape createManLeaf(float size, boolean pacManTree, boolean anim) {
    float mouth = HALF_PI;
    float radius = size; // size * 0.5f;

    PShape pac = createShape(ARC, 0, 0, radius, radius, mouth, TWO_PI-mouth);

    if (pacManTree && !anim) {
      pac.setFill(PACMAN_BLOSSOM_COLOURS[(int)random(0, 5)]);
    } else {
      pac.setFill(PACMAN_YELLOW);
    }

    return pac;
  }

  public float getRadius() {
    return min(pacW, pacH) * 0.5f;
  }

  public float getWidth() {
    return pacW;
  }

  public float getHeight() {
    return pacH;
  }
}
