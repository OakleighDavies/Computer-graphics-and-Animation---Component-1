// This is a multi-scene short pacman inspired animation, with 3 scenes (scene one, two and credits) //<>// //<>//
// By Oakleigh Davies (SEM2 2026)

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

import processing.sound.*;
PFont pixelated;

Fruit[] fruitsScene1;  // global cherry, strawberry, orange, apple, melon, Galaxian
Fruit cherry;
static PImage IMGCHERRY, IMGSTRAWBERRY, IMGORANGE, IMGAPPLE, IMGMELON, IMGGALAXIN; // Loading fruit .PNG's
static PImage GIT_QR;

Ghosts blinky, inky, pinky, clyde, izike;
Pacman pacman;
FractalTree tree1, tree2, tree3, tree4, tree5, treePacMan, tree6, tree7;
Pellets[] pellets = new Pellets[69];

PelletBuilder pb;

Pellets[][] mazePellets;
Pellets[] mazePellets1, mazePellets2, mazePellets3, mazePellets4, mazePellets5, mazePellets6, mazePellets7, mazePellets8,
  mazePellets9, mazePellets10, mazePellets11, mazePellets12, mazePellets13, mazePellets14, mazePellets15, mazePellets16, mazePellets17, mazePellets18, mazePellets19,
  mazePellets20, mazePellets21, mazePellets22, mazePellets23, mazePellets24, mazePellets25, mazePellets26, mazePellets27, mazePellets28, mazePellets29, mazePellets30,
  mazePellets31, mazePellets32, mazePellets33, mazePellets34, mazePellets35, mazePellets36, mazePellets37, mazePellets38, mazePellets39, mazePellets40, mazePellets41,
  mazePellets42, mazePellets43, mazePellets44, mazePellets45, mazePellets46, mazePellets47, mazePellets48, mazePellets49, mazePellets50, mazePellets51, mazePellets52,
  mazePellets53, mazePellets54, mazePellets55, mazePellets56, mazePellets57, mazePellets58, mazePellets59, mazePellets60, mazePellets61, mazePellets62, mazePellets63,
  mazePellets64, mazePellets65, mazePellets66, mazePellets67, mazePellets68, mazePellets69;

Camera_helper backdrop, pacMaze;

SoundFile Pacman_spawnin, Pacman_movement, Power_pellet_eaten, Pacman_defeated;

// Current animation starting point
boolean Scene_1 = true;
boolean Scene_2 = false;
boolean Credits = false;

private PShape floor;

String[] credits;
boolean start_credits = false;

void setup() {
  fullScreen(P2D); // using 2D pipeline
  pixelDensity(2); // if applicable

  frameRate(60);

  // Custom pixelated front
  pixelated = createFont("fonts/PublicPixel-z84yD.ttf", 16);  // (license: Public Domain. link: https://www.fontspace.com/public-pixel-font-f72305)

  Pacman_spawnin = new SoundFile(this, "audio/Pacman_spawn-in.wav");
  Pacman_movement = new SoundFile(this, "audio/Pacman_chomp.wav");
  Power_pellet_eaten = new SoundFile(this, "audio/Power_pellet_eaten.wav");
  Pacman_defeated = new SoundFile(this, "audio/Pacman_defeated.wav");

  pacman = new Pacman(40, height - 40, 50, 50); // height - 40, 50

  for (int i = 0; i < pellets.length; i++) {
    pellets[i] = new Pellets(false, (i*90)+120, height-45);
  }

  // SCENE 1 --------------------------
  backdrop = new Camera_helper("images/Night_Street_Scene.png");

  tree1 = new FractalTree(244, height-20, 140, random(QUARTER_PI/2, HALF_PI/1.5), 1.25, 0.7, false, false); // DEFAULTS: x, y, 120, random(QUARTER_PI/2, HALF_PI/1.5), 1.0, 0.66, false
  tree2 = new FractalTree(550, height-20, 200, random(QUARTER_PI/2, HALF_PI/1.5), 1.25, 0.67, false, true); // DEFAULTS: x, y, 120, random(QUARTER_PI/2, HALF_PI/1.5), 1.0, 0.66, false
  tree3 = new FractalTree(1000, height-20, 110, random(QUARTER_PI/2, HALF_PI/1.5), 1.25, 0.75, true, false); // DEFAULTS: x, y, 120, random(QUARTER_PI/2, HALF_PI/1.5), 1.0, 0.66, false
  tree4 = new FractalTree(1500, height-20, 120, random(QUARTER_PI/2, HALF_PI/1.5), 1.5, 0.66, false, true); // DEFAULTS: x, y, 120, random(QUARTER_PI/2, HALF_PI/1.5), 1.0, 0.66, false
  treePacMan = new FractalTree(1800, height-20, 200, random(QUARTER_PI/2, HALF_PI/1.5), 1.4, 0.7, true, true); // DEFAULTS: x, y, 120, random(QUARTER_PI/2, HALF_PI/1.5), 1.0, 0.66, false
  tree5 = new FractalTree(1900, height-20, 140, random(QUARTER_PI/2, HALF_PI/1.5), 1.0, 0.70, false, false); // DEFAULTS: x, y, 120, random(QUARTER_PI/2, HALF_PI/1.5), 1.0, 0.66, false
  tree6 = new FractalTree(2200, height-20, 160, random(QUARTER_PI/2, HALF_PI/1.5), 0.8, 0.70, false, true); // DEFAULTS: x, y, 120, random(QUARTER_PI/2, HALF_PI/1.5), 1.0, 0.66, false
  tree7 = new FractalTree(2500, height-20, 120, random(QUARTER_PI/2, HALF_PI/1.5), 0.66, 0.70, false, false); // DEFAULTS: x, y, 120, random(QUARTER_PI/2, HALF_PI/1.5), 1.0, 0.66, false

  floor = ground();

  // ----------------------------------

  // SCENE 2 --------------------------

  pacMaze = new Camera_helper("images/Originalpacmaze.png");

  pb = new PelletBuilder(375, 47, 20);

  // Row 1
  mazePellets1 = pb.row(0, 7, 45); // top left
  mazePellets2 = pb.row(9, 16, 45); // top right

  // Row 2
  mazePellets3 = pb.row(0, 0, 105); // 1st
  mazePellets4 = pb.row(3, 3, 105); // 2nd
  mazePellets5 = pb.row(7, 7, 105); // 3rd
  mazePellets6 = pb.row(9, 9, 105); // 4th
  mazePellets7 = pb.row(13, 13, 105); // 5th
  mazePellets8 = pb.row(16, 16, 105); // 6th pelet

  // Row 3
  mazePellets9 = pb.row(0, 16, 165);

  // Row 4
  mazePellets10 = pb.row(0, 0, 215); // 1st
  mazePellets11 = pb.row(3, 3, 215); // 2nd
  mazePellets12 = pb.row(5, 5, 215); // 3rd
  mazePellets13 = pb.row(11, 11, 215); // 4th
  mazePellets14 = pb.row(13, 13, 215); // 5th
  mazePellets15 = pb.row(16, 16, 215); // 6th pelet

  // Row 5
  mazePellets16 = pb.row(0, 3, 265); // 1st
  mazePellets17 = pb.row(5, 7, 265); // 2nd
  mazePellets18 = pb.row(9, 11, 265); // 3rd
  mazePellets19 = pb.row(13, 16, 265); // 4th group

  // Row 6
  mazePellets20 = pb.row(3, 3, 312); // 1st
  mazePellets21 = pb.row(7, 7, 312); // 2nd
  mazePellets22 = pb.row(9, 9, 312); // 3rd
  mazePellets23 = pb.row(13, 13, 312); // 4th pelet

  // Row 7
  mazePellets24 = pb.row(3, 3, 362); // 1st
  mazePellets25 = pb.row(5, 11, 362); // 2nd
  mazePellets26 = pb.row(13, 13, 362); // 3rd group

  // Row 8
  mazePellets27 = pb.row(3, 3, 407); // 1st
  mazePellets28 = pb.row(5, 5, 407); // 2nd
  mazePellets29 = pb.row(11, 11, 407); // 3rd
  mazePellets30 = pb.row(13, 13, 407); // 4th pelet

  // Row 9
  mazePellets31 = pb.row(0, 5, 455); // 1st
  mazePellets32 = pb.row(11, 16, 455); // 2nd group

  // Row 10
  mazePellets33 = pb.row(3, 3, 505); // 1st
  mazePellets34 = pb.row(5, 5, 505); // 1st
  mazePellets35 = pb.row(11, 11, 505); // 1st
  mazePellets36 = pb.row(13, 13, 505); // 2nd group

  // Row 11
  mazePellets37 = pb.row(3, 3, 550); // 1st pelet
  mazePellets38 = pb.row(5, 11, 550); // 2nd group
  mazePellets39 = pb.row(13, 13, 550); // 2nd pelet

  // Row 12
  mazePellets40 = pb.row(3, 3, 595); // 1st
  mazePellets41 = pb.row(5, 5, 595); // 1st
  mazePellets42 = pb.row(11, 11, 595); // 1st
  mazePellets43 = pb.row(13, 13, 595); // 2nd group

  // Row 13
  mazePellets44 = pb.row(0, 7, 645); // 1st
  mazePellets45 = pb.row(9, 16, 645); // 2nd group

  // Row 13
  mazePellets46 = pb.row(0, 0, 693); // 1st
  mazePellets47 = pb.row(3, 3, 693); // 2nd
  mazePellets48 = pb.row(7, 7, 693); // 3rd
  mazePellets49 = pb.row(9, 9, 693); // 4th
  mazePellets50 = pb.row(13, 13, 693); // 5th
  mazePellets51 = pb.row(16, 16, 693); // 6th pelet

  // Row 14
  mazePellets52 = pb.row(0, 1, 740); // 1st
  mazePellets53 = pb.row(3, 13, 740); // 2nd
  mazePellets54 = pb.row(15, 16, 740); // 3rd group

  // Row 15
  mazePellets55 = pb.row(1, 1, 788); // 1st
  mazePellets56 = pb.row(3, 3, 788); // 2nd
  mazePellets57 = pb.row(5, 5, 788); // 3rd
  mazePellets58 = pb.row(11, 11, 788); // 4th
  mazePellets59 = pb.row(13, 13, 788); // 5th
  mazePellets60 = pb.row(15, 15, 788); // 6th pelet

  // Row 16
  mazePellets61 = pb.row(0, 3, 835); // 1st
  mazePellets62 = pb.row(5, 7, 835); // 2nd
  mazePellets63 = pb.row(9, 11, 835); // 3rd
  mazePellets64 = pb.row(13, 16, 835); // 4th group

  // Row 17
  mazePellets65 = pb.row(0, 0, 882); // 1st
  mazePellets66 = pb.row(7, 7, 882); // 2nd
  mazePellets67 = pb.row(9, 9, 882); // 3rd
  mazePellets68 = pb.row(16, 16, 882); // 4th pelet

  // Row 18
  mazePellets69 = pb.row(0, 16, 932); // row

  mazePellets = new Pellets[][] {
    mazePellets1,
    mazePellets2,
    mazePellets3,
    mazePellets4,
    mazePellets5,
    mazePellets6,
    mazePellets7,
    mazePellets8,
    mazePellets9,
    mazePellets10,
    mazePellets11,
    mazePellets12,
    mazePellets13,
    mazePellets14,
    mazePellets15,
    mazePellets16,
    mazePellets17,
    mazePellets18,
    mazePellets19,
    mazePellets20,
    mazePellets21,
    mazePellets22,
    mazePellets23,
    mazePellets24,
    mazePellets25,
    mazePellets26,
    mazePellets27,
    mazePellets28,
    mazePellets29,
    mazePellets30,
    mazePellets31,
    mazePellets32,
    mazePellets33,
    mazePellets34,
    mazePellets35,
    mazePellets36,
    mazePellets37,
    mazePellets38,
    mazePellets39,
    mazePellets40,
    mazePellets41,
    mazePellets42,
    mazePellets43,
    mazePellets44,
    mazePellets45,
    mazePellets46,
    mazePellets47,
    mazePellets48,
    mazePellets49,
    mazePellets50,
    mazePellets51,
    mazePellets52,
    mazePellets53,
    mazePellets54,
    mazePellets55,
    mazePellets56,
    mazePellets57,
    mazePellets58,
    mazePellets59,
    mazePellets60,
    mazePellets61,
    mazePellets62,
    mazePellets63,
    mazePellets64,
    mazePellets65,
    mazePellets66,
    mazePellets67,
    mazePellets68,
    mazePellets69
  };

  // ----------------------------------

  blinky = new Ghosts(BLINKY, -500, height-20, "right", Float.NaN); // start pos: -440, height-20 (THERE IS 80px BETWEEN EACH X VALUE TO KEEP DISTANCING)
  inky = new Ghosts(INKY, -400, height-20, "right", Float.NaN); //      "      : -360, height-20
  pinky = new Ghosts(PINKY, -300, height-20, "right", Float.NaN); //    "      : -280, height-20
  clyde = new Ghosts(CLYDE, -200, height-20, "right", Float.NaN); //    "      : -200, height-20

  izike = new Ghosts(IZIKE, 500, 981, "izike", Float.NaN); // only for credits scene

  // Preloading fruit images once
  IMGCHERRY = loadImage("images/PM_Cherry.png");
  IMGSTRAWBERRY = loadImage("images/PM_Strawberry.png");
  IMGORANGE = loadImage("images/PM_Orange.png");
  IMGAPPLE = loadImage("images/PM_Apple.png");
  IMGMELON = loadImage("images/PM_Melon.png");
  IMGGALAXIN = loadImage("images/PM_Galaxian.png");

  // Making ruit array
  fruits = new Fruit[6];
  fruits[0] = new Fruit(IMGCHERRY, 150, height-65);
  fruits[1] = new Fruit(IMGSTRAWBERRY, 600, height-65);
  fruits[2] = new Fruit(IMGORANGE, 1050, height-65);
  fruits[3] = new Fruit(IMGAPPLE, 1500, height-65);
  fruits[4] = new Fruit(IMGMELON, 1860, height-65);
  fruits[5] = new Fruit(IMGGALAXIN, 2220, height-65);

  cherry = new Fruit(IMGCHERRY, 735, 535);

  // CREDITS --------------------------

  GIT_QR = loadImage("images/GIT_QR.png");
  credits = loadStrings("text/Credits.txt");

  // ----------------------------------
}

void draw() {
  background(0);

  if ((pacman_defeated_played == true && !Pacman_defeated.isPlaying() && Scene_2) || (!credits_started && Credits)) {
    Scene_2 = false;
    Credits = true;
    startCredits();
  }

  if (Scene_1) {
    // Update scene 1
    Begin_scene_1();
  } else if (Scene_2) {
    // Update scene 2
    Begin_scene_2();
  }

  if (Credits && credits_started) {
    Roll_credits();
  }

  // Mouse coordinates (DEBUGGING) - EXTENDED CODE TAKEN FROM CHATGPT FOR THE PURPOSES OF DEBUGGING ONLY
  float worldMouseX = mouseX + backdrop.camX;
  float worldMouseY = mouseY;

  String coords = int(worldMouseX) + "," + int(worldMouseY);
  fill(255);
  textSize(20);
  text(coords, 100, 100);
}

private PShape ground() {
  floor = createShape(RECT, 0, height-20, backdrop.scaledWidth, 20);
  floor.setFill(color(0));

  return floor;
}
