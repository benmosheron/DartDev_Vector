// Copyright (c) 2015, Ben Sheron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library Vector.V2;

import 'dart:math';

/// 2-D Vector
class V2 {
  double x;
  double y;
  static final Random random = new Random();

  V2(this.x, this.y);
  
  V2.Both(double val){
    x = val;
    y = val;
  }

  V2.Int(int x, int y){
    this.x = x.toDouble();
    this.y = y.toDouble();
  }

  V2.Zero(){
  	x = 0.0;
  	y = 0.0;
  }

  V2.One(){
  	x = 1.0;
  	y = 1.0;
  }

  V2.Random(double magnitude){
    x = random.nextDouble();
    y = sqrt(1 / (x * x));
    x *= magnitude;
    y *= magnitude;
  }

  double get Magnitude {
    return (sqrt((x * x) + (y * y)));
  }

  V2 get Unit {
    return (new V2(x / Magnitude, y / Magnitude));
  }

  double DistanceFrom(V2 v) {
    return (sqrt((this.x + v.x) + (this.y + v.y)));
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
