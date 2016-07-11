// Copyright (c) 2015, Ben Sheron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library generic_vector_tools.v2;

import 'dart:math';
import 'v.dart';

/// 2-D Vector. Special case vector of two doubles.
/// Use V<double> for general purposes.
/// Operator overloads are element wise.
class V2 extends V<double> {
  double get x => super[0];
  double get y => super[1];

  static List<double> GetFixedList(double x, double y) {
    List<double> _l = new List<double>(2);
    _l[0] = x;
    _l[1] = y;
    return _l;
  }

  /// Create a new V2, specifying both components.
  V2(double x, double y) : super(GetFixedList(x, y));

  /// Create a new V2 with equal components.
  V2.both(double val) : super(GetFixedList(val, val));

  /// Create a new V2 from a pair of integers, they will be converted to doubles.
  V2.int(int x, int y) : this(x.toDouble(), y.toDouble());

  /// Create a new V2 (0, 0)
  V2.zero() : this.both(0.0);

  /// Create a new V2 (1, 1)
  V2.one() : this.both(1.0);

  /// Create a new V2 with pseudo-random components, such that the magnitude
  /// of the vector equals the input value.
  V2.random(double magnitude) : super.randomNormalised(2, magnitude);

  double get magnitude {
    return (sqrt((x * x) + (y * y)));
  }

  /// Get the unit vector in the direction of this vector.
  /// If this vector is (0,0), then (0,0) will be returned.
  V2 get unit {
    if (magnitude == 0.0) return new V2.zero();
    return (new V2(x / magnitude, y / magnitude));
  }

  /// The scalar distance between this vector and another.
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

  operator +(var other) {
    if (other is V2) {
      return (new V2(x + other.x, y + other.y));
    } else if (other is double) {
      return (new V2(x + other, y + other));
    } else if (other is int) {
      return (new V2(x + other.toDouble(), y + other.toDouble()));
    } else {
      throw new Exception(
          "Invalid parameter [$other], cannot add a parameter of type [${other.runtimeType}] to a V2");
    }
  }

  operator -(var other) {
    if (other is V2) {
      return (new V2(x - other.x, y - other.y));
    } else if (other is double) {
      return (new V2(x - other, y - other));
    } else if (other is int) {
      return (new V2(x - other.toDouble(), y - other.toDouble()));
    } else {
      throw new Exception(
          "Invalid parameter [$other], cannot substract a parameter of type [${other.runtimeType}] to a V2");
    }
  }

  operator *(var other) {
    if (other is double) {
      return (new V2(x * other, y * other));
    } else if (other is int) {
      return (new V2(x * other.toDouble(), y * other.toDouble()));
    } else {
      throw new Exception(
          "Invalid parameter [$other], cannot (element wise) multiply a V2 by a parameter of type [${other.runtimeType}]");
    }
  }

  operator /(var other) {
    if (other is double) {
      return (new V2(x / other, y / other));
    } else if (other is int) {
      return (new V2(x / other.toDouble(), y / other.toDouble()));
    } else {
      throw new Exception(
          "Invalid parameter [$other], cannot (element wise) divide a V2 by a parameter of type [${other.runtimeType}]");
    }
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
