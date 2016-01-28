// Copyright (c) 2015, Ben Sheron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library generic_vector_tools.v2;

import 'dart:math';

/// 2-D Vector
class V2 {
  double x;
  double y;
  static final Random rand = new Random();

  V2(this.x, this.y);

  V2.both(double val) {
    x = val;
    y = val;
  }

  V2.int(int x, int y) {
    this.x = x.toDouble();
    this.y = y.toDouble();
  }

  V2.zero() {
    x = 0.0;
    y = 0.0;
  }

  V2.one() {
    x = 1.0;
    y = 1.0;
  }

  V2.random(double magnitude) {
    x = (rand.nextDouble() * 2) - 1;
    y = (rand.nextDouble() * 2) - 1;
    double scale = magnitude / this.magnitude;
    x *= scale;
    y *= scale;
  }

  double get magnitude {
    return (sqrt((x * x) + (y * y)));
  }

  V2 get unit {
    if (magnitude == 0.0) return new V2.zero();
    return (new V2(x / magnitude, y / magnitude));
  }

  double distanceFrom(V2 v) {
    return (sqrt((this.x + v.x) + (this.y + v.y)));
  }

  V2 negate() {
    return (new V2(-x, -y));
  }

  static V2 elementWiseMax(V2 v1, V2 v2) {
    return (new V2(max(v1.x, v2.x), max(v1.y, v2.y)));
  }

  static V2 elementWiseMin(V2 v1, V2 v2) {
    return (new V2(min(v1.x, v2.x), min(v1.y, v2.y)));
  }

  operator +(V2 other) {
    return (new V2(x + other.x, y + other.y));
  }

  operator -(V2 other) {
    return (new V2(x - other.x, y - other.y));
  }

  operator *(double other) {
    return (new V2(x * other, y * other));
  }

  operator /(double other) {
    return (new V2(x / other, y / other));
  }

  operator ==(V2 other) {
    return (x == other.x && y == other.y);
  }

  int get hashCode {
    int result = 17;
    result = 37 * result + x.hashCode;
    result = 37 * result + y.hashCode;
    return result;
  }
}
