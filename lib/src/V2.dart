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
    x = (random.nextDouble() * 2) - 1;
    y = (random.nextDouble() * 2) - 1;
    double scale = magnitude / Magnitude;
    x *= scale;
    y *= scale;
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

  V2 Negate(){
    return(new V2(-x, -y));
  }

  static V2 ElementWiseMax(V2 v1, V2 v2){
    return(new V2(max(v1.x, v2.x), max(v1.y, v2.y)));
  }

  static V2 ElementWiseMin(V2 v1, V2 v2){
    return(new V2(min(v1.x, v2.x), min(v1.y, v2.y)));
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
