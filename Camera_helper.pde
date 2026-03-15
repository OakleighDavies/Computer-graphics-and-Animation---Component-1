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

class Camera_helper {

  private PImage backdrop;

  private float posX = 0;
  private float posY = 0;

  private float camX = 0;
  private float camY = 0;
  private float zoom = 1.0f;

  private float scaledWidth;
  private float scaledHeight;

  Camera_helper(String filename) {
    this.posX = posX;
    this.posY = posY;
    backdrop = loadImage(filename);

    float scaleFactor = (float) height / backdrop.height;
    scaledWidth = backdrop.width * scaleFactor;
    scaledHeight = backdrop.height * scaleFactor;
  }

  public float getBackdropX() {
    return this.posX;
  }

  public float getBackdropY() {
    return this.posY;
  }

  public void setBackdropX(float x) {
    this.posX = x;
  }

  public void setBackdropY(float y) {
    this.posY = y;
  }

  private void update(float targetX, float targetY) {

    // Follow target smoothly
    float visibleWorldWidth = width / zoom;

    camX = targetX - visibleWorldWidth * 0.6f;
    camX = constrain(camX, 0, scaledWidth - visibleWorldWidth);

    camY = 0; // lock vertical for now
  }

  private void apply() {
    pushMatrix();
    scale(zoom);
    translate(-camX, -camY);
  }

  private void display() {
    image(backdrop, posX, posY, scaledWidth, scaledHeight);
  }

  private void end() {
    popMatrix();
  }

  // Setter for camera zoom
  public void setZoom(float z) {
    zoom = z;
  }

  // Getter for scene one width
  float getWidth() {
    return scaledWidth;
  }
}
