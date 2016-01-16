// Copyright (c) 2015, Ben Sheron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library Vector.V;

import 'dart:math';

/// Vector with n elements
class V{
  static final Random random = new Random();
  List<double> list;

  V(List<double> vals){
    list = vals;
  }

  V.All(int size, double val){
    list = new List<double>.filled(size, val);
  }

  V.Zero(int size):this.All(size, 0.0);

  V.One(int size):this.All(size, 1.0);

  V.Random(int size){
    list = new List<double>();
    for(int i = 0; i<size; i++){
      list.add(random.nextDouble());
    }
  }

  // Operator overloads
  operator [](int i) => list[i];
  operator []=(int i, double value) => list[i] = value;

  operator +(V other){
    List<double> _interimList = new List<double>(list.length);
    for(int i = 0; i< list.length; i++){
      _interimList[i] = list[i] + other[i];
    }
    return(new V(_interimList));
  }

  operator -(V other){
    List<double> _interimList = new List<double>(list.length);
    for(int i = 0; i< list.length; i++){
      _interimList[i] = list[i] - other[i];
    }
    return(new V(_interimList));
  }

  operator *(double s){
    List<double> _interimList = new List<double>(list.length);
    for(int i = 0; i< list.length; i++){
      _interimList[i] = list[i] * s;
    }
    return(new V(_interimList));
  }

  operator /(double s){
    List<double> _interimList = new List<double>(list.length);
    for(int i = 0; i< list.length; i++){
      _interimList[i] = list[i] / s;
    }
    return(new V(_interimList));
  }

  // operator -(V2 other) {
  //   return (new V2(x - other.x, y - other.y));
  // }

  // operator *(double other) {
  //   return (new V2(x * other, y * other));
  // }

  // operator /(double other) {
  //   return (new V2(x / other, y / other));
  // }
}