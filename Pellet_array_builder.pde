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

class PelletBuilder {
  float[] colX;

  PelletBuilder(float startX, float step, int cols) {
    colX = new float[cols];
    for (int c = 0; c < cols; c++) colX[c] = startX + c * step;
  }

  Pellets[] row(int fromCol, int toCol, float y) {
    int n = toCol - fromCol + 1;
    Pellets[] r = new Pellets[n];
    int k = 0;
    for (int c = fromCol; c <= toCol; c++) {
      r[k++] = new Pellets(false, colX[c], y);
    }
    return r;
  }
}
