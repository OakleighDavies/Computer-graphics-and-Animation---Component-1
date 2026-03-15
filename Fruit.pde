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

class Fruit {
  private static final int FRUIT_SIZE = 40;

  private float fruitPosX, fruitPosY;
  private boolean eaten;

  private PImage fruitImage;

  Fruit(PImage fruit, float fruitPosX, float fruitPosY) {
    this.fruitImage = fruit;
    this.fruitPosX = fruitPosX;
    this.fruitPosY = fruitPosY;
    this.eaten = false;
  }

  void display() {
    if (!eaten) {
      image(fruitImage, fruitPosX, fruitPosY, FRUIT_SIZE, FRUIT_SIZE);
    }
  }

  public float getFruitX() {
    return fruitPosX;
  }
  public float getFruitY() {
    return fruitPosY;
  }
  public boolean isFruitEaten() {
    return eaten;
  }

  public void getEaten(Pacman pos) {
    if (eaten) return;
    if (collidesWith(pos)) {
      eaten = true;

      // ADD SCORING HERE LATER, JUST FOR EFFECTS
    }
  }

  public void setFruitX(float x) {
    fruitPosX = x;
  }

  public void setFruitY(float y) {
    fruitPosY = y;
  }

  public void setFruitPos(float x, float y) {
    fruitPosX = x;
    fruitPosY = y;
  }

  private boolean collidesWith(Pacman pos) {
    float pacPosX = pos.getPacmanX();
    float pacPosY = pos.getPacmanY();
    float pacRad = pos.getRadius();

    float collisonX = pacPosX - fruitPosX;
    float collisionY = pacPosY - fruitPosY;
    float sizes = pacRad + FRUIT_SIZE / 6.0f;

    return collisonX*collisonX + collisionY*collisionY <= sizes*sizes;  // Circle-circle collider overlap
  }
}
