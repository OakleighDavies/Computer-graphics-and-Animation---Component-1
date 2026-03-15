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

Fruit[] fruits;

// Getter methods for each sprite
private void getTrees() {
  pushMatrix();
  tree1.display();
  tree2.display();
  tree3.display();
  tree4.display();
  tree5.display();
  treePacMan.display();
  tree6.display();
  tree7.display();
  popMatrix();
}

private void getGhosts() {
  pushMatrix();
  blinky.display();
  inky.display();
  pinky.display();
  clyde.display();
  popMatrix();
}

private void getPacman() {
  pushMatrix();
  pacman.display();
  popMatrix();
}

private void getPelets() {
  pushMatrix();

  for (int i = 0; i < pellets.length; i++) {
    if (pellets[i] == null) continue;

    pellets[i].getEaten(pacman);
    pellets[i].display();
  }

  popMatrix();
}

private void getScene2Pelets() {
  pushMatrix();

  for (int r = 0; r < mazePellets.length; r++) {
    for (int i = 0; i < mazePellets[r].length; i++) {
      Pellets p = mazePellets[r][i];
      if (p == null) continue;

      p.getEaten(pacman);
      p.display();
    }
  }

  popMatrix();
}

private void getFruits() {
  if (fruits == null) return;

  pushMatrix();
  for (Fruit f : fruits) {
    if (f == null) continue;
    f.getEaten(pacman);
    f.display();
  }
  popMatrix();
}

private void getCherries_Scene_2() {
  pushMatrix();

  fill(0);
  square(748, 548, 15);
  cherry.getEaten(pacman);
  cherry.display();

  popMatrix();
}

// sprite loader for scene 1
public void getElements_Scene1() {
  if (Scene_1) {
    backdrop.update(pacman.getPacmanX(), pacman.getPacmanY());
    backdrop.apply();

    backdrop.display();
    getTrees();
    shape(floor);
    getPelets();
    getFruits();
    getGhosts();
    if (movement_helper_pass_1) {
      getPacman();
    } else if (movement_helper_pass_2) {
      pushMatrix();

      translate(pacman.getPacmanX(), pacman.getPacmanY());
      rotate(PI);
      translate(-pacman.getPacmanX(), -pacman.getPacmanY());

      getPacman();

      popMatrix();
    }

    backdrop.end();
  }
}

// sprite loader for scene 2
public void getElements_Scene2() {
  if (Scene_2) {
    pacMaze.apply();
    pacMaze.display();

    getScene2Pelets();

    getCherries_Scene_2();

    pushMatrix();

    translate(pacman.getPacmanX(), pacman.getPacmanY());
    rotate(pacmanFacing);
    translate(-pacman.getPacmanX(), -pacman.getPacmanY());

    getPacman();

    popMatrix();

    pushMatrix();

    scale(0.8);
    getGhosts();

    popMatrix();

    switch (pacmanMoving) {
    case 1:
      pacman.setPositionY(pacman.getPacmanY() - 3);
      break;
    case 2:
      pacman.setPositionY(pacman.getPacmanY() + 3);
      break;
    case 3:
      pacman.setPositionX(pacman.getPacmanX() - 3);
      break;
    case 4:
      pacman.setPositionX(pacman.getPacmanX() + 3);
      break;
    case 5:
      break; // pacman movement termination
    }

    switch (blinkyMoving) {
    case 1:
      blinky.setGhostY(blinky.getGhostY() - 3.4);
      break;
    case 2:
      blinky.setGhostY(blinky.getGhostY() + 3.4);
      break;
    case 3:
      blinky.setGhostX(blinky.getGhostX() - 3.4);
      break;
    case 4:
      blinky.setGhostX(blinky.getGhostX() + 3.4);
      break;
    case 5:
      break; // movement termination
    }

    switch (inkyMoving) {
    case 1:
      inky.setGhostY(inky.getGhostY() - 3.4);
      break;
    case 2:
      inky.setGhostY(inky.getGhostY() + 3.4);
      break;
    case 3:
      inky.setGhostX(inky.getGhostX() - 3.4);
      break;
    case 4:
      inky.setGhostX(inky.getGhostX() + 3.4);
      break;
    case 5:
      break;
    }

    switch (pinkyMoving) {
    case 1:
      pinky.setGhostY(pinky.getGhostY() - 3.3);
      break;
    case 2:
      pinky.setGhostY(pinky.getGhostY() + 3.3);
      break;
    case 3:
      pinky.setGhostX(pinky.getGhostX() - 3.3);
      break;
    case 4:
      pinky.setGhostX(pinky.getGhostX() + 3.3);
      break;
    case 5:
      break; // movement termination
    }

    switch (clydeMoving) {
    case 1:
      clyde.setGhostY(clyde.getGhostY() - 3.2);
      break;
    case 2:
      clyde.setGhostY(clyde.getGhostY() + 3.2);
      break;
    case 3:
      clyde.setGhostX(clyde.getGhostX() - 3.2);
      break;
    case 4:
      clyde.setGhostX(clyde.getGhostX() + 3.2);
      break;
    case 5:
      break; // movement termination
    }

    pacMaze.end();
  }
}
