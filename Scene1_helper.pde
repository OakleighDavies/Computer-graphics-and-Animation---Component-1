/* //<>//
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

boolean movement_helper_pass_1 = true; //<>//
boolean movement_helper_pass_2 = false;

boolean hasSpawned = false;
boolean playSpawnSound = false;
boolean pacMovement = false;

boolean cameraLocked = true;

float innitZoom = 5.0f;
float currentScale = 5.0f;
float spawnStartTime;
float spawnDuration = 2000; // 2 seconds

float ghostSpawnTime;
float ghostTimer = 2500; // 2.5 seconds

int counter = 0; // counter per frame rate of 60fps, to call random chance once a second
int randJumpChance;
int randGhostSelect;

boolean blinkyJump = false;
boolean inkyJump = false;
boolean pinkyJump = false;
boolean clydeJump = false;

float blinkyJumpStartX = 0;
float inkyJumpStartX = 0;
float pinkyJumpStartX = 0;
float clydeJumpStartX = 0;

float jumpDistance = PI * 50;

private void jumpingRandom() {
  if (counter == 60) {
    randJumpChance = (int)random(0, 1000);
    randGhostSelect = (int)random(1, 5);
    counter = 0;
  } else {
    counter++;
  }
}

public void Begin_scene_1() {
  if (!hasSpawned) {

    if (spawnStartTime == 0) {
      spawnStartTime = millis();
    }

    if (ghostSpawnTime == 0) {
      ghostSpawnTime = millis();
    }

    spawnZoomOut(); // Trigger zoom out subroutine

    if (!playSpawnSound) {
      Pacman_spawnin.play();
      playSpawnSound = true;
    }
  }

  getElements_Scene1();

  if (movement_helper_pass_1) {
    movement_helper_pass_1();
  } else if (movement_helper_pass_2) {
    movement_helper_pass_2();
  }
}

// Zooming out as the program runs
private void spawnZoomOut() {
  float elapsed = millis() - spawnStartTime;
  float i = constrain(elapsed / spawnDuration, 0, 1);

  i = 1 - pow(1 - i, 3); // Placeholder float for gentle zoomout

  currentScale = lerp(5.0f, 1.0f, i);
  backdrop.setZoom(currentScale);

  if (i >= 1) {
    hasSpawned = true;
  }
}

// Moves pacman across scene 1 - pass 1
private void movement_helper_pass_1() {
  if (!Pacman_movement.isPlaying() && !Pacman_spawnin.isPlaying()) { // Can only move when pacman eating sound is playing and when not spawning in
    if (pacman.getPacmanX() < backdrop.getWidth()+25) {
      Pacman_movement.amp(0.5);
      Pacman_movement.play();
    }
  }

  // Pacman movement
  if ((pacman.getPacmanX() < backdrop.getWidth()+1040) && !Pacman_spawnin.isPlaying()) {
    float pacX = pacman.getPacmanX() + 2;
    pacman.setPositionX(pacX);
  }

  if (!Pacman_spawnin.isPlaying() && blinky.getGhostX() < backdrop.getWidth()+25) {
    float elapsed = millis() - ghostTimer;
    float b = constrain(elapsed / ghostTimer, 0, 1);
    float i = constrain(elapsed / ghostTimer, 0, 1);
    float p = constrain(elapsed / ghostTimer, 0, 1);
    float c = constrain(elapsed / ghostTimer, 0, 1);

    jumpingRandom();

    if (!blinkyJump && randJumpChance < 200) {
      switch (randGhostSelect) {
      case 1:
        blinkyJump = true;
        blinkyJumpStartX = blinky.getGhostX();
        break;
      case 2:
        inkyJump = true;
        inkyJumpStartX = inky.getGhostX();
        break;
      case 3:
        pinkyJump = true;
        pinkyJumpStartX = pinky.getGhostX();
        break;
      case 4:
        clydeJump = true;
        clydeJumpStartX = clyde.getGhostX();
        break;
      }
    }

    // Ghost movement and jumping
    if (b >= 1) { // Blinky
      blinky.setDir(1);
      blinkyJump();
      blinky.setGhostX(blinky.getGhostX() + 2);
    }
    if (i >= 1) { // Inky
      inky.setDir(1);
      inkyJump();
      inky.setGhostX(inky.getGhostX() + 2);
    }
    if (p >= 1) { // Pinky
      pinky.setDir(1);
      pinkyJump();
      pinky.setGhostX(pinky.getGhostX() + 2);
    }
    if (c >= 1) { // Clyde
      clyde.setDir(1);
      clydeJump();
      clyde.setGhostX(clyde.getGhostX() + 2);
    }
  }

  if (blinky.getGhostX() > backdrop.getWidth()+25) {
    movement_helper_pass_1 = false;
    movement_helper_pass_2 = true;
  }
}

// Moves pacman across scene 1 - pass 2
private void movement_helper_pass_2() {
  if (!(blinky.getEyeDir().equals("izike"))) {
    blinky.setEyeDir("izike");
    inky.setEyeDir("izike");
    pinky.setEyeDir("izike");
    clyde.setEyeDir("izike");
  }

  // Pacman movement
  if (pacman.getPacmanX() > -25) {
    float pacX = pacman.getPacmanX() - 3.1f;
    pacman.setPositionX(pacX);
  }

  if (!Pacman_spawnin.isPlaying() && pacman.getPacmanX() > -25) {
    float elapsed = millis() - ghostTimer;
    float b = constrain(elapsed / ghostTimer, 0, 1);
    float i = constrain(elapsed / ghostTimer, 0, 1);
    float p = constrain(elapsed / ghostTimer, 0, 1);
    float c = constrain(elapsed / ghostTimer, 0, 1);

    if (!Power_pellet_eaten.isPlaying()) {
      Power_pellet_eaten.play();
    }

    jumpingRandom();

    if (!blinkyJump && randJumpChance < 200) {
      switch (randGhostSelect) {
      case 1:
        blinkyJump = true;
        blinkyJumpStartX = blinky.getGhostX();
        break;
      case 2:
        inkyJump = true;
        inkyJumpStartX = inky.getGhostX();
        break;
      case 3:
        pinkyJump = true;
        pinkyJumpStartX = pinky.getGhostX();
        break;
      case 4:
        clydeJump = true;
        clydeJumpStartX = clyde.getGhostX();
        break;
      }
    }

    // Ghost movement and jumping
    if (b >= 1) { // Blinky
      blinky.setDir(-1);
      blinkyJump();
      blinky.setGhostX(blinky.getGhostX() - 3);
    }

    if (i >= 1) { // Inky
      inky.setDir(-1);
      inkyJump();
      inky.setGhostX(inky.getGhostX() - 3);
    }
    if (p >= 1) { // Pinky
      pinky.setDir(-1);
      pinkyJump();
      pinky.setGhostX(pinky.getGhostX() - 3);
    }
    if (c >= 1) { // Clyde
      clyde.setDir(-1);
      clydeJump();
      clyde.setGhostX(clyde.getGhostX() - 3);
    }
  } else if (pacman.getPacmanX() <= -25) {
    movement_helper_pass_2 = false;
    resetMatrix();
    Scene_1 = false;
    Scene_2 = true;

    println(movement_helper_pass_2, Scene_1, Scene_2);
  }
}

private void blinkyJump() {
  if (blinkyJump) {

    float distance = (blinky.getGhostX() - blinkyJumpStartX) * blinky.getDir();
    float progress = distance / jumpDistance;

    if (progress >= 1) {
      blinkyJump = false;
      blinky.setGhostY(blinky.getGhostOriginY());
    } else {
      float jump = 100 * abs(sin(progress * PI));
      blinky.setGhostY(blinky.getGhostOriginY() - jump);
    }
  } else {
    blinky.setGhostY(blinky.getGhostOriginY());
  }
}

private void inkyJump() {
  if (inkyJump) {

    float distance = (inky.getGhostX() - inkyJumpStartX) * inky.getDir();
    float progress = distance / jumpDistance;

    if (progress >= 1) {
      inkyJump = false;
      inky.setGhostY(inky.getGhostOriginY());
    } else {
      float jump = 100 * abs(sin(progress * PI));
      inky.setGhostY(inky.getGhostOriginY() - jump);
    }
  } else {
    inky.setGhostY(inky.getGhostOriginY());
  }
}

private void pinkyJump() {
  if (pinkyJump) {

    float distance = (pinky.getGhostX() - pinkyJumpStartX) * pinky.getDir();
    float progress = distance / jumpDistance;

    if (progress >= 1) {
      pinkyJump = false;
      pinky.setGhostY(pinky.getGhostOriginY());
    } else {
      float jump = 100 * abs(sin(progress * PI));
      pinky.setGhostY(pinky.getGhostOriginY() - jump);
    }
  } else {
    pinky.setGhostY(pinky.getGhostOriginY());
  }
}

private void clydeJump() {
  if (clydeJump) {

    float distance = (clyde.getGhostX() - clydeJumpStartX) * clyde.getDir();
    float progress = distance / jumpDistance;

    if (progress >= 1) {
      clydeJump = false;
      clyde.setGhostY(clyde.getGhostOriginY());
    } else {
      float jump = 100 * abs(sin(progress * PI));
      clyde.setGhostY(clyde.getGhostOriginY() - jump);
    }
  } else {
    clyde.setGhostY(clyde.getGhostOriginY());
  }
}
