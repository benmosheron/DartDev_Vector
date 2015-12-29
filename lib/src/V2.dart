// Copyright (c) 2015, Ben Sheron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library Vector.V2;

import 'dart:math' as math;

/// 2-D Vector
class V2 {
  double x;
  double y;

  V2(double x, double y) {
    this.x = x;
    this.y = y;
  }

  V2.Zero(){
  	x = 0.0;
  	y = 0.0;
  }

  V2.One(){
  	x = 1.0;
  	y = 1.0;
  }

  double get Magnitude {
    return (math.sqrt((x * x) + (y * y)));
  }

  V2 get Unit {
    return (new V2(x / Magnitude, y / Magnitude));
  }

  double DistanceFrom(V2 v) {
    return (math.sqrt((this.x + v.x) + (this.y + v.y)));
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
}
