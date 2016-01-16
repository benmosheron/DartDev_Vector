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
    list = new List<double>(size);
    list.fillRange(0, size, val);
  }

  // V2.Zero(){
  //   x = 0.0;
  //   y = 0.0;
  // }

  // V2.One(){
  //   x = 1.0;
  //   y = 1.0;
  // }

  // Operator overloads
  operator [](int i) => list[i];
  operator []=(int i, double value) => list[i] = value;
}