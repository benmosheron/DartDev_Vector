// Copyright (c) 2015, Ben Sheron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library Vector.V;

import 'V.dart';

/// Matrix with n (rows) * m (cols) elements
class M{

  // A = { a00 a01 a02 }
  //     { a10 a11 a12 }
  //     { a20 a21 a22 }
  List<V> _m;

  M(List<V> vals){
    _m = vals;
  }

  M.All(int n, int m, double val){
    _m = new List<V>(n);
    for(int i = 0; i < n; i++){
      _m[i] = new V.All(m, val);
    }
  }

  M.Zero(int n, int m):this.All(n, m, 0.0);

  M.One(int n, int m):this.All(n, m, 1.0);

  M.Random(int n, int m){
    _m = new List<V>(n);
    for(int i = 0; i < n; i++){
      _m[i] = new V.Random(m);
    }
  }

  // Operator overloads
  operator [](int i) => _m[i];
  operator []=(int i, V v) => _m[i] = v;

  // operator +(V other){
  //   List<double> _interimList = new List<double>(list.length);
  //   for(int i = 0; i< list.length; i++){
  //     _interimList[i] = list[i] + other[i];
  //   }
  //   return(new V(_interimList));
  // }

  // operator -(V other){
  //   List<double> _interimList = new List<double>(list.length);
  //   for(int i = 0; i< list.length; i++){
  //     _interimList[i] = list[i] - other[i];
  //   }
  //   return(new V(_interimList));
  // }

  // operator *(double s){
  //   List<double> _interimList = new List<double>(list.length);
  //   for(int i = 0; i< list.length; i++){
  //     _interimList[i] = list[i] * s;
  //   }
  //   return(new V(_interimList));
  // }

  // operator /(double s){
  //   List<double> _interimList = new List<double>(list.length);
  //   for(int i = 0; i< list.length; i++){
  //     _interimList[i] = list[i] / s;
  //   }
  //   return(new V(_interimList));
  // }
}