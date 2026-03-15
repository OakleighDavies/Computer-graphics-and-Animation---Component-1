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

// set values for blossom colours, immutable, but used multiple places
public static final color[] PACMAN_BLOSSOM_COLOURS = {
  #FDC6D6, // cherryBlossom
  #FFDADF, // blush
  #FDC5D6, // cottonCandy
  #FEACC4, // rose
  #FF779E, // peony
  #EF3167 // raspberry
};

class FractalTree {
  // Fractal tree param' setups
  private float baseAngle, baseLen;
  private int seed;
  private float[] noiseOffsets, randAngle1, randAngle2;
  private float positionX, positionY;
  private float scale, hHeight;

  // Colours
  private color dark = #433707;
  private color lighterDark = #5D4F18;
  private color medium = #71642E;
  private color medLight = #8B7B3B;
  private color light = #867C55;

  private color[] branchColour = new color[] {dark, lighterDark, medium, medLight, light};

  // Wind
  private float windStrength = 0.2;
  private float windSpeed = 0.01;
  private float windOffset;

  // Tree instace
  private PShape trunkShape, treeMain;
  private float thicknessScale;

  // animated tree
  private boolean anim;
  private boolean pacManTree;

  // Pac-Man leaf caching
  private Pacman pacHelper;
  private PShape pacLeaf;
  private float pacMinSize = 12;
  private float pacMaxSize = 15;

  // Overload constructor
  FractalTree(float x, float y, float scale) {
    this(x, y, 120, Float.NaN, scale, Float.NaN, false, false);
  }

  // Main constructor
  FractalTree(float x, float y, float baseLen, float baseAngle, float scale, float h, boolean anim, boolean pacManTree) { // x, y, 120, random(QUARTER_PI/2, HALF_PI/1.5), 1.0, 0.66
    this.seed = (int)(System.nanoTime() & 0x7fffffff); // time based seed, for variation and is never the same
    randomSeed(seed);

    // Fractal tree param' setups
    this.positionX = x;
    this.positionY = y;
    this.scale = scale;
    this.windOffset = random(1000);
    this.anim = anim;
    this.pacManTree = pacManTree;

    this.thicknessScale = random(1.0, 5.0);

    // Param' logic
    if (Float.isNaN(baseLen)) { // defaults if nothing chosen
      this.baseLen = 120; // default 120
    } else {
      this.baseLen = baseLen;
    }
    if (Float.isNaN(baseAngle)) { // defaults if nothing chosen
      this.baseAngle = random(QUARTER_PI/2, HALF_PI/1.5); // angle on rad pi; // defualt h = 0.66
    } else {
      this.baseAngle = baseAngle;
    }
    if (Float.isNaN(h)) {
      this.hHeight = 0.66;
    } else {
      this.hHeight = h;
    }

    // giving every branch a unique noise offset
    noiseOffsets = new float[50];
    randAngle1 = new float[50];
    randAngle2 = new float[50];
    for (int i = 0; i < noiseOffsets.length; i++) {
      noiseOffsets[i] = random(1000);
      randAngle1[i] = random(-0.3, 0.3);
      randAngle2[i] = random(-0.3, 0.3);
    }

    // Pacman helper + build ONE prototype (unit size, we'll scale per leaf)
    pacHelper = new Pacman(0, 0, 10, 10);
    pacLeaf = pacHelper.createManLeaf(1, this.pacManTree, this.anim); // 1 = unit diameter
    pacLeaf.setStroke(false);

    // Tree instance methods
    trunkShape = trunk();
    treeMain = fracTree(baseLen, 1, -HALF_PI); // cancels out h*=0.66 (for my self drawing trunk)
  }

  // "Getter" of sorts, to draw the instance
  void display() {
    pushMatrix();

    translate(positionX, positionY);
    scale(scale);

    // small trunk sway
    if (anim == true) {
      float trunkWind = sin((millis() / 10 * windSpeed) + windOffset) * windStrength * 0.2;
      rotate(trunkWind);
    }

    shape(trunkShape);

    pushMatrix();
    translate(0, -baseLen);

    // Rebuild tree each frame so wind updates
    if (anim == true) {
      pushMatrix();
      drawTreeAnimated(baseLen, 1, -HALF_PI);
      popMatrix();
    } else {
      shape(treeMain);
    }

    popMatrix();
    popMatrix();
  }


  // Drawing the thick part of the trunk
  private PShape trunk() {
    float wTrunk = 14;

    PShape trunk = createShape(LINE, 0, 0, 0, -baseLen);
    trunk.setStroke(color(100, 70, 55));
    trunk.setStrokeWeight(wTrunk);

    return trunk;
  }

  // Building the main tree
  private PShape fracTree(float h, int depth, float heading) {
    PShape treeMajor = createShape(GROUP);
    h *= hHeight;

    float heightFactor = h / baseLen;
    float branchWind = (sin((millis() / 10 * windSpeed) + windOffset + noiseOffsets[depth])* windStrength * heightFactor) * 0.2;

    if (h > 6) {
      // Weights for branches
      float w = max(0.8, map(h, baseLen * 0.66, 2, 10, 1));

      // Branch angles
      float angleLeft  = baseAngle + randAngle1[depth];
      float angleRight = baseAngle + randAngle2[depth];

      // Branch shape
      PShape branch = createShape(LINE, 0, 0, 0, -h);
      branch.setStrokeWeight(w);

      // Roation/animation logic for sides of tree, if animated or not
      float leftTurn  = anim ? (-angleLeft  + 2 * branchWind) : (-angleLeft);
      float rightTurn = anim ? ( angleRight + 2 * branchWind) : ( angleRight);

      // Left side of the tree
      PShape leftSide = fracTree(h, depth + 1, heading);
      leftSide.rotate(leftTurn);
      leftSide.translate(0, -h);

      // Right side of the tree
      PShape rightSide = fracTree(h, depth + 1, heading);
      rightSide.rotate(rightTurn);
      rightSide.translate(0, -h);

      // Applying colours for branches
      int colorIndex = min(depth, branchColour.length - 1);
      branch.setStroke(branchColour[colorIndex]);

      treeMajor.addChild(branch);
      treeMajor.addChild(leftSide);
      treeMajor.addChild(rightSide);
    } else {
      PShape leafGroup = createShape(GROUP);

      float c = noise(h * 5.0 + depth * 0.3);

      if (pacManTree && h > 1) {
        float size = lerp(pacMinSize, pacMaxSize, constrain(c, 0, 1));
        float rotation = heading;

        // Build a fresh static leaf (runs once during tree build)
        PShape pacLeafInstance = pacHelper.createManLeaf(1, this.pacManTree, this.anim);
        pacLeafInstance.setStroke(false);
        pacLeafInstance.rotate(heading);
        pacLeafInstance.scale(size);

        leafGroup.addChild(pacLeafInstance);
      } else {
        PShape pink = createShape(ELLIPSE, 0, 0, c*20, c*20);
        pink.setFill(PACMAN_BLOSSOM_COLOURS[(int)random(0, 5)]);
        pink.setStroke(false);
        leafGroup.addChild(pink);

        PShape white = createShape(ELLIPSE, 0, 0, c*10, c*10);
        white.setFill(color(255));
        white.setStroke(false);
        leafGroup.addChild(white);
      }

      leafGroup.setStroke(false);
      treeMajor.addChild(leafGroup);
    }

    return treeMajor;
  }

  // animated tree method, to prevent FPS thrashing
  private void drawTreeAnimated(float h, int depth, float heading) {
    h *= hHeight;

    float heightFactor = h / baseLen;
    float branchWind = (sin((millis() / 10 * windSpeed) + windOffset + noiseOffsets[depth]) * windStrength * heightFactor) * 0.2;

    if (h > 6) {
      float w = max(0.8, map(h, baseLen * 0.66, 2, 10, 1));
      float angleLeft  = baseAngle + randAngle1[depth];
      float angleRight = baseAngle + randAngle2[depth];

      int colorIndex = min(depth, branchColour.length - 1);

      pushStyle();
      stroke(branchColour[colorIndex]);
      strokeWeight(w);
      line(0, 0, 0, -h);
      popStyle();

      // Left
      pushMatrix();
      translate(0, -h);
      rotate(-angleLeft + 2 * branchWind);
      drawTreeAnimated(h, depth + 1, heading);
      popMatrix();

      // Right
      pushMatrix();
      translate(0, -h);
      rotate(angleRight + 2 * branchWind);
      drawTreeAnimated(h, depth + 1, heading);
      popMatrix();
    } else {
      float c = noise(h * 5.0 + depth * 0.3);

      if (pacManTree) {
        float size = lerp(pacMinSize, pacMaxSize, constrain(c, 0, 1));

        pushMatrix();
        rotate(heading);
        scale(size);
        noStroke();
        shape(pacLeaf);
        popMatrix();
      } else {
        // original petals
        float c20 = c * 20.0;
        float c10 = c * 10.0;

        pushStyle();
        noStroke();
        fill(PACMAN_BLOSSOM_COLOURS[4]);
        ellipse(0, 0, c20, c20);
        fill(255);
        ellipse(0, 0, c10, c10);
        popStyle();
      }
    }
  }
}
