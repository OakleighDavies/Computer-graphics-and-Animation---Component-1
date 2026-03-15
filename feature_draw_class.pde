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

class Eyes {
  private String lookDirection;

  // Cached Ghost bodies and eyes, built once
  private PShape eyesUpShape, eyesDownShape, eyesLeftShape, eyesRightShape;
  private PShape vulnerableStateShape;

  Eyes(String lookDirection) {
    this.lookDirection = lookDirection;

    eyesUpShape = eyesUp();
    eyesDownShape = eyesDown();
    eyesLeftShape = eyesLeft();
    eyesRightShape = eyesRight();
    vulnerableStateShape = vulnerableState();
  }

  public void setLookDirection(String dir) {
    this.lookDirection = dir;
  }

  public String getLookDirection() {
    return lookDirection;
  }

  // "Getter" of sorts, to draw the instance
  void display() {
    if (lookDirection.equals("up")) {
      shape(eyesUpShape);
    } else if (lookDirection.equals("down")) {
      shape(eyesDownShape);
    } else if (lookDirection.equals("left")) {
      shape(eyesLeftShape);
    } else if (lookDirection.equals("right")) {
      shape(eyesRightShape);
    } else if (lookDirection.equals("izike")) {
      shape(vulnerableStateShape);
    }
  }

  private PShape eyesUp() {
    PShape eyesUp = createShape(GROUP);

    // Left eye outline and fill
    PShape leftEye = createShape();

    leftEye.setFill(color(0xDE, 0xDE, 0xFF));
    leftEye.setStroke(true);
    leftEye.setStrokeWeight(2);
    leftEye.beginShape();
    leftEye.vertex(28, -110);
    leftEye.vertex(45, -110);
    leftEye.vertex(45, -101);
    leftEye.vertex(54, -101);
    leftEye.vertex(54, -74);
    leftEye.vertex(45, -74);
    leftEye.vertex(45, -65);
    leftEye.vertex(28, -65);
    leftEye.vertex(28, -74);
    leftEye.vertex(19, -74);
    leftEye.vertex(19, -101);
    leftEye.vertex(28, -101);
    leftEye.endShape(CLOSE);

    // Left iris
    PShape leftIris = createShape(RECT, 29, -109, 16, 16);
    leftIris.setFill(color(0, 0, 255)); // blue
    leftIris.setStroke(false);

    // Right eye outline and fill
    PShape rightEye = createShape();

    rightEye.setFill(color(0xDE, 0xDE, 0xFF));
    rightEye.setStroke(true);
    rightEye.setStrokeWeight(2);
    rightEye.beginShape();
    rightEye.vertex(85, -110);
    rightEye.vertex(102, -110);
    rightEye.vertex(102, -101);
    rightEye.vertex(111, -101);
    rightEye.vertex(111, -74);
    rightEye.vertex(102, -74);
    rightEye.vertex(102, -65);
    rightEye.vertex(85, -65);
    rightEye.vertex(85, -74);
    rightEye.vertex(76, -74);
    rightEye.vertex(76, -101);
    rightEye.vertex(85, -101);
    rightEye.endShape(CLOSE);

    // Right iris
    PShape rightIris = createShape(RECT, 86, -109, 16, 16);
    rightIris.setFill(color(0, 0, 255)); // blue
    rightIris.setStroke(false);

    // Grouping
    eyesUp.addChild(leftEye);
    eyesUp.addChild(leftIris);
    eyesUp.addChild(rightEye);
    eyesUp.addChild(rightIris);

    return eyesUp;
  }

  private PShape eyesDown() {
    PShape eyesDown = createShape(GROUP);

    // Left eye outline and fill
    PShape leftEye = createShape();

    leftEye.setFill(color(0xDE, 0xDE, 0xFF));
    leftEye.setStroke(true);
    leftEye.setStrokeWeight(2);
    leftEye.beginShape();
    leftEye.vertex(30, -83);
    leftEye.vertex(47, -83);
    leftEye.vertex(47, -74);
    leftEye.vertex(56, -74);
    leftEye.vertex(56, -47);
    leftEye.vertex(47, -47);
    leftEye.vertex(47, -38);
    leftEye.vertex(30, -38);
    leftEye.vertex(30, -47);
    leftEye.vertex(21, -47);
    leftEye.vertex(21, -74);
    leftEye.vertex(30, -74);
    leftEye.endShape(CLOSE);

    // Left iris
    PShape leftIris = createShape(RECT, 31, -54, 16, 16);
    leftIris.setFill(color(0, 0, 255)); // blue
    leftIris.setStroke(false);

    // Right eye outline and fill
    PShape rightEye = createShape();

    rightEye.setFill(color(0xDE, 0xDE, 0xFF));
    rightEye.setStroke(true);
    rightEye.setStrokeWeight(2);
    rightEye.beginShape();
    rightEye.vertex(87, -83);
    rightEye.vertex(104, -83);
    rightEye.vertex(104, -74);
    rightEye.vertex(113, -74);
    rightEye.vertex(113, -47);
    rightEye.vertex(104, -47);
    rightEye.vertex(104, -38);
    rightEye.vertex(87, -38);
    rightEye.vertex(87, -47);
    rightEye.vertex(78, -47);
    rightEye.vertex(78, -74);
    rightEye.vertex(87, -74);
    rightEye.endShape(CLOSE);

    // Right iris
    PShape rightIris = createShape(RECT, 88, -54, 16, 16);
    rightIris.setFill(color(0, 0, 255)); // blue
    rightIris.setStroke(false);

    // Grouping
    eyesDown.addChild(leftEye);
    eyesDown.addChild(leftIris);
    eyesDown.addChild(rightEye);
    eyesDown.addChild(rightIris);

    return eyesDown;
  }

  private PShape eyesLeft() {
    PShape eyesLeft = createShape(GROUP);

    // Left eye outline and fill
    PShape leftEye = createShape();

    leftEye.setFill(color(0xDE, 0xDE, 0xFF));
    leftEye.setStroke(true);
    leftEye.setStrokeWeight(2);
    leftEye.beginShape();
    leftEye.vertex(19, -92);
    leftEye.vertex(36, -92);
    leftEye.vertex(36, -85);
    leftEye.vertex(45, -85);
    leftEye.vertex(45, -56);
    leftEye.vertex(36, -56);
    leftEye.vertex(36, -47);
    leftEye.vertex(19, -47);
    leftEye.vertex(19, -56);
    leftEye.vertex(10, -56);
    leftEye.vertex(10, -83);
    leftEye.vertex(19, -83);
    leftEye.endShape(CLOSE);

    // Left iris
    PShape leftIris = createShape(RECT, 11, -74, 18, 18);
    leftIris.setFill(color(0, 0, 255)); // blue
    leftIris.setStroke(false);

    // Right eye outline and fill
    PShape rightEye = createShape();

    rightEye.setFill(color(0xDE, 0xDE, 0xFF));
    rightEye.setStroke(true);
    rightEye.setStrokeWeight(2);
    rightEye.beginShape();
    rightEye.vertex(76, -92);
    rightEye.vertex(93, -92);
    rightEye.vertex(93, -85);
    rightEye.vertex(102, -85);
    rightEye.vertex(102, -56);
    rightEye.vertex(93, -56);
    rightEye.vertex(93, -47);
    rightEye.vertex(76, -47);
    rightEye.vertex(76, -56);
    rightEye.vertex(67, -56);
    rightEye.vertex(67, -83);
    rightEye.vertex(76, -83);
    rightEye.endShape(CLOSE);

    // Right iris
    PShape rightIris = createShape(RECT, 68, -74, 18, 18);
    rightIris.setFill(color(0, 0, 255)); // blue
    rightIris.setStroke(false);

    // Grouping
    eyesLeft.addChild(leftEye);
    eyesLeft.addChild(leftIris);
    eyesLeft.addChild(rightEye);
    eyesLeft.addChild(rightIris);

    return eyesLeft;
  }

  private PShape eyesRight() {
    PShape eyesRight = createShape(GROUP);

    // Left eye outline and fill
    PShape leftEye = createShape();

    leftEye.setFill(color(0xDE, 0xDE, 0xFF));
    leftEye.setStroke(true);
    leftEye.setStrokeWeight(2);
    leftEye.beginShape();
    leftEye.vertex(37, -92);
    leftEye.vertex(54, -92);
    leftEye.vertex(54, -83);
    leftEye.vertex(63, -83);
    leftEye.vertex(63, -56);
    leftEye.vertex(54, -56);
    leftEye.vertex(54, -47);
    leftEye.vertex(37, -47);
    leftEye.vertex(37, -56);
    leftEye.vertex(28, -56);
    leftEye.vertex(28, -83);
    leftEye.vertex(37, -83);
    leftEye.endShape(CLOSE);

    // Left iris
    PShape leftIris = createShape(RECT, 45, -74, 18, 18);
    leftIris.setFill(color(0, 0, 255)); // blue
    leftIris.setStroke(false);

    // Right eye outline and fill
    PShape rightEye = createShape();

    rightEye.setFill(color(0xDE, 0xDE, 0xFF));
    rightEye.setStroke(true);
    rightEye.setStrokeWeight(2);
    rightEye.beginShape();
    rightEye.vertex(94, -92);
    rightEye.vertex(111, -92);
    rightEye.vertex(111, -83);
    rightEye.vertex(120, -83);
    rightEye.vertex(120, -56);
    rightEye.vertex(111, -56);
    rightEye.vertex(111, -47);
    rightEye.vertex(94, -47);
    rightEye.vertex(94, -56);
    rightEye.vertex(85, -56);
    rightEye.vertex(85, -83);
    rightEye.vertex(94, -83);
    rightEye.endShape(CLOSE);

    // Right iris
    PShape rightIris = createShape(RECT, 102, -74, 18, 18);
    rightIris.setFill(color(0, 0, 255)); // blue
    rightIris.setStroke(false);

    // Grouping
    eyesRight.addChild(leftEye);
    eyesRight.addChild(leftIris);
    eyesRight.addChild(rightEye);
    eyesRight.addChild(rightIris);

    return eyesRight;
  }

  private PShape vulnerableState() {
    PShape vunrableState = createShape(GROUP);

    // Eyes
    PShape leftEye = createShape(RECT, 37, -73, 18, 18); // left eye
    leftEye.setFill(#DFDFF0); // eye "white"
    leftEye.setStroke(true);
    leftEye.setStrokeWeight(2);

    PShape rightEye = createShape(RECT, 74, -73, 18, 18); // right eye
    rightEye.setFill(#DFDFF0); // eye "white"
    rightEye.setStroke(true);
    rightEye.setStrokeWeight(2);

    // Mouth
    PShape mouth = createShape(GROUP);

    PShape mouth_1 = createShape(RECT, 9.5, -27, 9, 9);
    mouth_1.setFill(#DFDFF0);
    mouth_1.setStroke(true);
    mouth_1.setStrokeWeight(2);
    mouth.addChild(mouth_1);

    PShape mouth_2 = createShape(RECT, 18.5, -36, 18, 9);
    mouth_2.setFill(#DFDFF0);
    mouth_2.setStroke(true);
    mouth_2.setStrokeWeight(2);
    mouth.addChild(mouth_2);

    PShape mouth_3 = createShape(RECT, 36.5, -27, 18, 9);
    mouth_3.setFill(#DFDFF0);
    mouth_3.setStroke(true);
    mouth_3.setStrokeWeight(2);
    mouth.addChild(mouth_3);

    PShape mouth_4 = createShape(RECT, 54.5, -36, 20, 9);
    mouth_4.setFill(#DFDFF0);
    mouth_4.setStroke(true);
    mouth_4.setStrokeWeight(2);
    mouth.addChild(mouth_4);

    PShape mouth_5 = createShape(RECT, 74.5, -27, 18, 9);
    mouth_5.setFill(#DFDFF0);
    mouth_5.setStroke(true);
    mouth_5.setStrokeWeight(2);
    mouth.addChild(mouth_5);

    PShape mouth_6 = createShape(RECT, 92.5, -36, 18, 9);
    mouth_6.setFill(#DFDFF0);
    mouth_6.setStroke(true);
    mouth_6.setStrokeWeight(2);
    mouth.addChild(mouth_6);

    PShape mouth_7 = createShape(RECT, 110.5, -27, 9, 9);
    mouth_7.setFill(#DFDFF0);
    mouth_7.setStroke(true);
    mouth_7.setStrokeWeight(2);
    mouth.addChild(mouth_7);

    // Grouping
    vunrableState.addChild(leftEye);
    vunrableState.addChild(rightEye);
    vunrableState.addChild(mouth);

    return vunrableState;
  }
}
