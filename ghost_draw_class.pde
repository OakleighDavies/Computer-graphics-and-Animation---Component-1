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
 * along with this program. If not, see <https://www.gnu.org/lsicenses/>.
 */

public static final color BLINKY = #EA3323;
public static final color INKY = #75FBFD;
public static final color PINKY = #F4BBFB;
public static final color CLYDE = #F4BB64;
public static final color IZIKE = #2121F5; // FUN FACT: "IZIKE" is derived from a Japanese term for "someone who has become fearful"! (https://pacman.fandom.com/wiki/Vulnerable_Ghost)(08/02/2026)

class Ghosts {
  // Ghost setup
  private float ghostStartX, ghostStartY;
  private float ghostOriginalY;
  private int ghostColour;
  private int baseColour;
  Eyes eyes;

  private int dir;

  private PShape gb_1, gb_2;
  private boolean bodyStyle;

  // Class constructor
  public Ghosts(int ghostColour, float ghostStartX, float ghostStartY, String eyeDir, float scale) { // String bodyType
    this.baseColour = ghostColour;
    this.ghostColour = ghostColour;
    this.ghostStartX = ghostStartX;
    this.ghostStartY = ghostStartY;
    this.ghostOriginalY = ghostStartY;
    this.eyes = new Eyes(eyeDir);

    gb_1 = ghostBody1();
    gb_2 = ghostBody2();
  }

  public float getGhostX() {
    return ghostStartX;
  }
  public float getGhostY() {
    return ghostStartY;
  }
  public float getGhostOriginY() {
    return ghostOriginalY;
  }
  public int getDir() {
    return dir;
  }
  public String getEyeDir() {
    return eyes.getLookDirection();
  }

  // "Getter" of sorts, to draw the instance
  void display() {
    pushMatrix();
    pushStyle();

    translate(ghostStartX, ghostStartY);
    scale(0.5f);

    colour();

    applyColourToBodies();

    // simple animation toggle
    if (Scene_1 || Scene_2) {
      bodyStyle = frameCount % 20 < 10;
    }

    shape(bodyStyle ? gb_1 : gb_2);

    eyes.display();

    popStyle();
    popMatrix();
  }

  private void colour() {
    if (eyes.getLookDirection().equals("izike")) {
      ghostColour = IZIKE;
    } else {
      ghostColour = baseColour;
    }
  }

  // Ghost frills 1
  private PShape ghostBody1() {
    PShape ghostBody1 = createShape();
    ghostBody1.beginShape();
    ghostBody1.stroke(2);

    if (eyes.equals("izike")) {
      ghostColour = IZIKE;
    }

    ghostBody1.fill(ghostColour);
    ghostBody1.vertex(0, 0);
    ghostBody1.vertex(0, -65);
    ghostBody1.vertex(9, -65);
    ghostBody1.vertex(9, -92);
    ghostBody1.vertex(18, -92);
    ghostBody1.vertex(18, -101);
    ghostBody1.vertex(27, -101);
    ghostBody1.vertex(27, -110);
    ghostBody1.vertex(45, -110);
    ghostBody1.vertex(45, -119);
    ghostBody1.vertex(84, -119);
    ghostBody1.vertex(84, -110);
    ghostBody1.vertex(102, -110);
    ghostBody1.vertex(102, -101);
    ghostBody1.vertex(111, -101);
    ghostBody1.vertex(111, -92);
    ghostBody1.vertex(120, -92);
    ghostBody1.vertex(120, -65);
    ghostBody1.vertex(130, -65);

    ghostBody1.vertex(130, 9);
    ghostBody1.vertex(121, 9);
    ghostBody1.vertex(121, 0);
    ghostBody1.vertex(112, 0);
    ghostBody1.vertex(112, -9);
    ghostBody1.vertex(103, -9);
    ghostBody1.vertex(103, 0);
    ghostBody1.vertex(94, 0);
    ghostBody1.vertex(94, 9);
    ghostBody1.vertex(76, 9);
    ghostBody1.vertex(76, -9);
    ghostBody1.vertex(57, -9);
    ghostBody1.vertex(57, -9);
    ghostBody1.vertex(57, 9);
    ghostBody1.vertex(39, 9);
    ghostBody1.vertex(39, 0);
    ghostBody1.vertex(28, 0);
    ghostBody1.vertex(28, -9);
    ghostBody1.vertex(19, -9);
    ghostBody1.vertex(19, 0);
    ghostBody1.vertex(10, 0);
    ghostBody1.vertex(10, 9);
    ghostBody1.vertex(0, 9);
    ghostBody1.vertex(0, 0);
    ghostBody1.endShape(CLOSE);

    return ghostBody1;
  }

  // Ghost frills 2
  private PShape ghostBody2() {
    PShape ghostBody2 = createShape();
    ghostBody2.beginShape();
    ghostBody2.stroke(2);
    ghostBody2.fill(ghostColour);
    ghostBody2.vertex(0, 0);
    ghostBody2.vertex(0, -65);
    ghostBody2.vertex(9, -65);
    ghostBody2.vertex(9, -92);
    ghostBody2.vertex(18, -92);
    ghostBody2.vertex(18, -101);
    ghostBody2.vertex(27, -101);
    ghostBody2.vertex(27, -110);
    ghostBody2.vertex(45, -110);
    ghostBody2.vertex(45, -119);
    ghostBody2.vertex(84, -119);
    ghostBody2.vertex(84, -110);
    ghostBody2.vertex(102, -110);
    ghostBody2.vertex(102, -101);
    ghostBody2.vertex(111, -101);
    ghostBody2.vertex(111, -92);
    ghostBody2.vertex(120, -92);
    ghostBody2.vertex(120, -65);
    ghostBody2.vertex(130, -65);

    ghostBody2.vertex(130, 0);
    ghostBody2.vertex(121, 0);
    ghostBody2.vertex(121, 9);
    ghostBody2.vertex(103, 9);
    ghostBody2.vertex(103, 0);
    ghostBody2.vertex(94, 0);
    ghostBody2.vertex(94, -9);
    ghostBody2.vertex(85, -9);
    ghostBody2.vertex(85, 0);
    ghostBody2.vertex(76, 0);
    ghostBody2.vertex(76, 9);
    ghostBody2.vertex(58, 9);
    ghostBody2.vertex(58, 0);
    ghostBody2.vertex(49, 0);
    ghostBody2.vertex(49, -9);
    ghostBody2.vertex(40, -9);
    ghostBody2.vertex(40, 0);
    ghostBody2.vertex(31, 0);
    ghostBody2.vertex(31, 9);
    ghostBody2.vertex(13, 9);
    ghostBody2.vertex(13, 0);
    ghostBody2.endShape(CLOSE);

    return ghostBody2;
  }

  private void applyColourToBodies() {
    gb_1.setFill(ghostColour);
    gb_2.setFill(ghostColour);
  }

  public void setGhostX(float x) {
    ghostStartX = x;
  }

  public void setGhostY(float y) {
    ghostStartY = y;
  }

  public void setGhostPos(float x, float y) {
    ghostStartX = x;
    ghostStartY = y;
  }

  public void setDir(int dir) {
    this.dir = dir;
  }

  public void setEyeDir(String eyeDir) {
    eyes.setLookDirection(eyeDir);
  }
}
