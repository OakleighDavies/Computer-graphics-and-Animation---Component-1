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

public boolean spawning_Pacman_Scene_2 = true;
public boolean spawning_Ghosts_Scene_2 = true;
public boolean pacman_defeated = false;
public static final float PACMAN_SCALE_SCENE_2 = 0.9f;
public static final float GHOST_SCALE_SCENE_2 = 0.8f;

public static final float PACMAN_UP = 1.5 * PI;
public static final float PACMAN_DOWN = HALF_PI;
public static final float PACMAN_LEFT = PI;
public static final float PACMAN_RIGHT = 0;

public static final int MOVE_UP = 1;
public static final int MOVE_DOWN = 2;
public static final int MOVE_LEFT = 3;
public static final int MOVE_RIGHT = 4;

public float pacmanFacing;
public int pacmanMoving;

public int blinkyMoving;
public int inkyMoving;
public int pinkyMoving;
public int clydeMoving;

public static final float PELLET_STEP = 47; // Pelet Spacing
public static final float COL0_X = 375; // First pelet coloumn start pos
public static final int NUM_COLS = 20; // Columns in maze
float[] colX = new float[NUM_COLS];

public int movement_step = 0; // pacman movements

// ghost movements
public int blinky_movement_step = 0;
public int inky_movement_step = 0;
public int pinky_movement_step = 0;
public int clyde_movement_step = 0;

public boolean pacman_defeated_played = false;

public void Begin_scene_2() {
  // Getting backdrop/maze
  pacMaze.setBackdropX(326); // maze width = 860 (/2 = 430) | main width = 1512 (/2 = 756)
  pacMaze.setBackdropY(0);

  if (!Pacman_movement.isPlaying() && !pacman_defeated) {
    Pacman_movement.amp(0.5);
    Pacman_movement.play();
  }

  // Pacman entry into the maze on the right
  if (spawning_Pacman_Scene_2) {
    pacman.setPosition((1240 / PACMAN_SCALE_SCENE_2)*0.9, (459 / PACMAN_SCALE_SCENE_2)*0.9); // initial pacman position in scene 2 (0.9 for scaling)
    pacmanFacing = PACMAN_LEFT;
    pacmanMoving = MOVE_LEFT;
    movement_step++;

    spawning_Pacman_Scene_2 = false;
  }

  pacman_movement();
  ghost_movement();

  getElements_Scene2();
  exit_blocks();
  teleport_pacman();
  teleport_blinky();
}

void exit_blocks() {
  pushStyle();
  pushMatrix();
  resetMatrix();

  fill(0);
  stroke(0);
  rect(225, 429, 100, 59); // 227, 429
  rect(1183, 429, width-1183, 59); // 956, 429

  popMatrix();
  popStyle();
}

void pacman_movement() {
  if (pacman.getPacmanX() <= 892 && movement_step == 1) {
    pacmanFacing = PACMAN_DOWN;
    pacmanMoving = MOVE_DOWN;
    movement_step++;
  } else if (pacman.getPacmanY() >= 651 && movement_step == 2) {
    pacmanFacing = PACMAN_LEFT;
    pacmanMoving = MOVE_LEFT;
    movement_step++;
  } else if (pacman.getPacmanX() <= 802 && movement_step == 3) {
    pacmanFacing = PACMAN_DOWN;
    pacmanMoving = MOVE_DOWN;
    movement_step++;
  } else if (pacman.getPacmanY() >= 745 && movement_step == 4) {
    pacmanFacing = PACMAN_LEFT;
    pacmanMoving = MOVE_LEFT;
    movement_step++;
  } else if (pacman.getPacmanX() <= 524 && movement_step == 5) {
    pacmanFacing = PACMAN_UP;
    pacmanMoving = MOVE_UP;
    movement_step++;
  } else if (pacman.getPacmanY() <= 460 && movement_step == 6) {
    pacmanFacing = PACMAN_LEFT;
    pacmanMoving = MOVE_LEFT;
  } else if (pacman.getPacmanX() <= 892 && movement_step == 7) {
    pacmanFacing = PACMAN_UP;
    pacmanMoving = MOVE_UP;
    movement_step++;
  } else if (pacman.getPacmanY() <= 365 && movement_step == 8) {
    pacmanFacing = PACMAN_LEFT;
    pacmanMoving = MOVE_LEFT;
    movement_step++;
  } else if (pacman.getPacmanX() <= 618 && movement_step == 9) {
    pacmanFacing = PACMAN_DOWN;
    pacmanMoving = MOVE_DOWN;
    movement_step++;
  } else if (pacman.getPacmanY() >= 553 && movement_step == 10) {
    pacmanFacing = PACMAN_RIGHT;
    pacmanMoving = MOVE_RIGHT;
    movement_step++;
  } else if (pinkyMoving == 5) { // pacman.getPacmanX() >= 857 && movement_step == 11
    pacmanMoving = 5;
  }
}

void ghost_movement() {
  if (spawning_Ghosts_Scene_2) {
    blinky.setEyeDir("left");
    inky.setEyeDir("left");
    pinky.setEyeDir("left");
    clyde.setEyeDir("left");

    blinky.setGhostPos((1200/GHOST_SCALE_SCENE_2), (482/GHOST_SCALE_SCENE_2)); // / GHOST_SCALE_SCENE_2 to account for scaling
    inky.setGhostPos((1275/GHOST_SCALE_SCENE_2), (482/GHOST_SCALE_SCENE_2)); //                       "
    pinky.setGhostPos((1350/GHOST_SCALE_SCENE_2), (482/GHOST_SCALE_SCENE_2)); //                      "
    clyde.setGhostPos((1425/GHOST_SCALE_SCENE_2), (482/GHOST_SCALE_SCENE_2)); //                      "

    spawning_Ghosts_Scene_2 = false;
  }

  if (pacman.getPacmanX() <= 920 && blinky_movement_step == 0) {
    blinkyMoving = MOVE_LEFT;
    blinky_movement_step++;
  }

  if (blinky_movement_step == 1 && inky_movement_step == 0) {
    inkyMoving = MOVE_LEFT;
    inky_movement_step = 1;
  }

  if (inky_movement_step == 1 && pinky_movement_step == 0) {
    pinkyMoving = MOVE_LEFT;
    pinky_movement_step = 1;
  }

  if (pinky_movement_step == 1 && clyde_movement_step == 0) {
    clydeMoving = MOVE_LEFT;
    clyde_movement_step = 1;
  }

  blinky_movement();
  inky_movement();
  pinky_movement();
  clyde_movement();

  if (pinkyMoving == 5) {
    if (!Pacman_defeated.isPlaying() && !pacman_defeated_played) {
      Pacman_movement.stop();
      pacman_defeated = true;
      Pacman_defeated.play();
      pacman_defeated_played = true;
    }
  }
}

void blinky_movement() {
  // First movement (down)
  if (blinky.getGhostX() <= 867/GHOST_SCALE_SCENE_2 && blinky_movement_step == 1) {
    blinky.setEyeDir("down");
    blinkyMoving = MOVE_DOWN;
    blinky_movement_step++;
  }

  // Second movement (left)
  else if (blinky.getGhostY() >= 668/GHOST_SCALE_SCENE_2 && blinky_movement_step == 2) {
    blinky.setEyeDir("left");
    blinkyMoving = MOVE_LEFT;
    blinky_movement_step++;
  }

  // Third movement (down)
  else if (blinky.getGhostX() <= 775/GHOST_SCALE_SCENE_2 && blinky_movement_step == 3) {
    blinky.setEyeDir("down");
    blinkyMoving = MOVE_DOWN;
    blinky_movement_step++;
  }

  // Fourth movement (left)
  else if (blinky.getGhostY() >= 765/GHOST_SCALE_SCENE_2 && blinky_movement_step == 4) {
    blinky.setEyeDir("left");
    blinkyMoving = MOVE_LEFT;
    blinky_movement_step++;
  }

  // Fifth movement (up)
  else if (blinky.getGhostX() <= 501/GHOST_SCALE_SCENE_2 && blinky_movement_step == 5) {
    blinky.setEyeDir("up");
    blinkyMoving = MOVE_UP;
    blinky_movement_step++;
  }

  // Sixth movement (left)
  else if (blinky.getGhostY() <= 485/GHOST_SCALE_SCENE_2 && blinky_movement_step == 6) {
    blinky.setEyeDir("left");
    blinkyMoving = MOVE_LEFT;
    blinky_movement_step++;
  }

  // Seventh movement (up)
  else if (blinky.getGhostX() <= 867/GHOST_SCALE_SCENE_2 && blinky_movement_step == 8) {
    blinky.setEyeDir("up");
    blinkyMoving = MOVE_UP;
    blinky_movement_step++;
  }

  // Eighth movement (left)
  else if (blinky.getGhostY() <= 390/GHOST_SCALE_SCENE_2 && blinky_movement_step == 9) {
    blinky.setEyeDir("left");
    blinkyMoving = MOVE_LEFT;
    blinky_movement_step++;
  }

  // Ninth movement (down)
  else if (blinky.getGhostX() <= 593/GHOST_SCALE_SCENE_2 && blinky_movement_step == 10) {
    blinky.setEyeDir("down");
    blinkyMoving = MOVE_DOWN;
    blinky_movement_step++;
  }

  // Termination
  else if (pinkyMoving == 5) {
    blinkyMoving = 5; // stop Blinky
  }
}

void inky_movement() {
  // First movement (down)
  if (inky.getGhostX() <= 958/GHOST_SCALE_SCENE_2 && inky_movement_step == 1) {
    inky.setEyeDir("down");
    inkyMoving = MOVE_DOWN;
    inky_movement_step++;
  }

  // Second movement (right)
  else if (inky.getGhostY() >= 860/GHOST_SCALE_SCENE_2 && inky_movement_step == 2) {
    inky.setEyeDir("right");
    inkyMoving = MOVE_RIGHT;
    inky_movement_step++;
  }

  // Third movement (down)
  else if (inky.getGhostX() >= 1108/GHOST_SCALE_SCENE_2 && inky_movement_step == 3) {
    inky.setEyeDir("down");
    inkyMoving = MOVE_DOWN;
    inky_movement_step++;
  }

  // Fourth movement (left)
  else if (inky.getGhostY() >= 956/GHOST_SCALE_SCENE_2 && inky_movement_step == 4) {
    inky.setEyeDir("left");
    inkyMoving = MOVE_LEFT;
    inky_movement_step++;
  }

  // Fifth movement (up)
  else if (inky.getGhostX() <= 776/GHOST_SCALE_SCENE_2 && inky_movement_step == 5) {
    inky.setEyeDir("up");
    inkyMoving = MOVE_UP;
    inky_movement_step++;
  }

  // Sixth movement (right)
  else if (inky.getGhostY() <= 858/GHOST_SCALE_SCENE_2 && inky_movement_step == 6) {
    inky.setEyeDir("right");
    inkyMoving = MOVE_RIGHT;
    inky_movement_step++;
  }

  // Seventh movement (up)
  else if (inky.getGhostX() >= 867/GHOST_SCALE_SCENE_2 && inky_movement_step == 7) {
    inky.setEyeDir("up");
    inkyMoving = MOVE_UP;
    inky_movement_step++;
  }

  // Eighth movement (right)
  else if (inky.getGhostY() <= 768/GHOST_SCALE_SCENE_2 && inky_movement_step == 8) {
    inky.setEyeDir("right");
    inkyMoving = MOVE_RIGHT;
    inky_movement_step++;
  }

  // Ninth movement (up)
  else if (inky.getGhostX() >= 956/GHOST_SCALE_SCENE_2 && inky_movement_step == 9) {
    inky.setEyeDir("up");
    inkyMoving = MOVE_UP;
    inky_movement_step++;
  }

  // Tenth movement (right)
  else if (inky.getGhostY() <= 481/GHOST_SCALE_SCENE_2 && inky_movement_step == 10) {
    inky.setEyeDir("right");
    inkyMoving = MOVE_RIGHT;
    inky_movement_step++;
  }

  // Termination
  else if (inky.getGhostX() >= 1200/GHOST_SCALE_SCENE_2 && inky_movement_step == 11) {
    inkyMoving = 5; // stop Inky
  }
}

void pinky_movement() {
  // First movement (down)
  if (pinky.getGhostX() <= 867/GHOST_SCALE_SCENE_2 && pinky_movement_step == 1) {
    pinky.setEyeDir("down");
    pinkyMoving = MOVE_DOWN;
    pinky_movement_step++;
  }

  // Second movement (down)
  else if (pinky.getGhostY() >= 576/GHOST_SCALE_SCENE_2 && pinky_movement_step == 2) {
    pinky.setEyeDir("left");
    pinkyMoving = MOVE_LEFT;
    pinky_movement_step++;
  }

  // Third movement (down)
  else if (pinky.getGhostX() <= 593/GHOST_SCALE_SCENE_2 && pinky_movement_step == 3) {
    pinky.setEyeDir("up");
    pinkyMoving = MOVE_UP;
    pinky_movement_step++;
  }

  // Fourth movement (left)
  else if (pinky.getGhostY() <= 483/GHOST_SCALE_SCENE_2 && pinky_movement_step == 4) {
    pinky.setEyeDir("left");
    pinkyMoving = MOVE_LEFT;
    pinky_movement_step++;
  }

  // Fifth movement (up)
  else if (pinky.getGhostX() <= 501/GHOST_SCALE_SCENE_2 && pinky_movement_step == 5) {
    pinky.setEyeDir("up");
    pinkyMoving = MOVE_UP;
    pinky_movement_step++;
  }

  // Sixth movement (right)
  else if (pinky.getGhostY() <= 197/GHOST_SCALE_SCENE_2 && pinky_movement_step == 6) {
    pinky.setEyeDir("right");
    pinkyMoving = MOVE_RIGHT;
    pinky_movement_step++;
  }

  // Seventh movement (down)
  else if (pinky.getGhostX() >= 593/GHOST_SCALE_SCENE_2 && pinky_movement_step == 7) {
    pinky.setEyeDir("down");
    pinkyMoving = MOVE_DOWN;
    pinky_movement_step++;
  }

  // Eighth movement (right)
  else if (pinky.getGhostY() >= 293/GHOST_SCALE_SCENE_2 && pinky_movement_step == 8) {
    pinky.setEyeDir("right");
    pinkyMoving = MOVE_RIGHT;
    pinky_movement_step++;
  }

  // Nineth movement (down)
  else if (pinky.getGhostX() >= 687/GHOST_SCALE_SCENE_2 && pinky_movement_step == 9) {
    pinky.setEyeDir("down");
    pinkyMoving = MOVE_DOWN;
    pinky_movement_step++;
  }

  // Tenth movement (right)
  else if (pinky.getGhostY() >= 387/GHOST_SCALE_SCENE_2 && pinky_movement_step == 10) {
    pinky.setEyeDir("right");
    pinkyMoving = MOVE_RIGHT;
    pinky_movement_step++;
  }

  // Eleventh movement (down)
  else if (pinky.getGhostX() >= 866/GHOST_SCALE_SCENE_2 && pinky_movement_step == 11) {
    pinky.setEyeDir("down");
    pinkyMoving = MOVE_DOWN;
    pinky_movement_step++;
  }

  // Termination
  else if (pinky.getGhostY() >= 565/GHOST_SCALE_SCENE_2 && pinky_movement_step == 12) {
    pinkyMoving = 5; // stop Pinky
  }
}

void clyde_movement() {
  // First movement (down)
  if (clyde.getGhostX() <= 867/GHOST_SCALE_SCENE_2 && clyde_movement_step == 1) {
    clyde.setEyeDir("down");
    clydeMoving = MOVE_DOWN;
    clyde_movement_step++;
  }

  // Second movement (left)
  else if (clyde.getGhostY() >= 668/GHOST_SCALE_SCENE_2 && clyde_movement_step == 2) {
    clyde.setEyeDir("left");
    clydeMoving = MOVE_LEFT;
    clyde_movement_step++;
  }

  // Third movement (down)
  else if (clyde.getGhostX() <= 775/GHOST_SCALE_SCENE_2 && clyde_movement_step == 3) {
    clyde.setEyeDir("down");
    clydeMoving = MOVE_DOWN;
    clyde_movement_step++;
  }

  // Fourth movement (left)
  else if (clyde.getGhostY() >= 765/GHOST_SCALE_SCENE_2 && clyde_movement_step == 4) {
    clyde.setEyeDir("left");
    clydeMoving = MOVE_LEFT;
    clyde_movement_step++;
  }

  // Fifth movement (down)
  else if (clyde.getGhostX() <= 501/GHOST_SCALE_SCENE_2 && clyde_movement_step == 5) {
    clyde.setEyeDir("down");
    clydeMoving = MOVE_DOWN;
    clyde_movement_step++;
  }

  // Sixth movement (left)
  else if (clyde.getGhostY() >= 862/GHOST_SCALE_SCENE_2 && clyde_movement_step == 6) {
    clyde.setEyeDir("left");
    clydeMoving = MOVE_LEFT;
    clyde_movement_step++;
  }

  // Seventh movement (down)
  else if (clyde.getGhostX() <= 349/GHOST_SCALE_SCENE_2 && clyde_movement_step == 7) {
    clyde.setEyeDir("down");
    clydeMoving = MOVE_DOWN;
    clyde_movement_step++;
  }

  // Eighth movement (right)
  else if (clyde.getGhostY() >= 957/GHOST_SCALE_SCENE_2 && clyde_movement_step == 8) {
    clyde.setEyeDir("right");
    clydeMoving = MOVE_RIGHT;
    clyde_movement_step++;
  }

  // Termination
  else if (pinkyMoving == 5) {
    clydeMoving = 5; // stop Clyde
  }
}

void teleport_pacman() {
  if (pacman.getPacmanX() <= 295) {
    pacman.setPositionX(1240);
    movement_step++;
  }
}

void teleport_blinky() {
  if (blinky.getGhostX() <= 280/GHOST_SCALE_SCENE_2) {
    blinky.setGhostX(1200/GHOST_SCALE_SCENE_2);
    blinky_movement_step++;
  }
}

void buildColumns() {
  for (int i = 0; i < NUM_COLS; i++) {
    colX[i] = COL0_X + i * PELLET_STEP;
  }
}
