// Copyright (c) 2015, Ben Sheron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library generic_vector_tools.v2;

import 'dart:math';
import 'v.dart';

/// 2-D Vector
class V2 extends V<double> {
  double get x => super[0];
  double get y => super[1];

  static List<double> GetFixedList(double x, double y) {
    List<double> _l = new List<double>(2);
    _l[0] = x;
    _l[1] = y;
    return _l;
  }

  V2(double x, double y) : super(GetFixedList(x, y));

  V2.both(double val) : super(GetFixedList(val, val));

  V2.int(int x, int y) : this(x.toDouble(), y.toDouble());

  V2.zero() : this.both(0.0);

  V2.one() : this.both(1.0);

  V2.random(double magnitude) : super.randomNormalised(2, magnitude);

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
