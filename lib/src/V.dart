// Copyright (c) 2015, Ben Sheron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library Vector.V;

import 'dart:math';
import 'M.dart';

/// Vector with n elements
class V{
  static final Random random = new Random();
  List<double> list;

  List<double> get Elements => list;
  int get length => list.length;

  //--------------//
  // Constructors //
  //--------------//

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
  
  //---------//
  // Methods //
  //---------//

  V ElementWiseMultiply(V v){
    return(this._zip(v, (v1, v2) => v1 * v2));
  }

  V ElementWiseDivide(V v){
    return(this._zip(v, (v1, v2) => v1 / v2));
  }

  // void Print(){
  //   Elements.forEach((e) => print("$e, "));
  // }

  //--------------------//
  // Operator overloads //
  //--------------------//

  operator [](int i) => list[i];
  operator []=(int i, double value) => list[i] = value;

  operator +(var x){
    if(x is V) return _plusV(x);
    else if(x is double) return _plusDouble(x);
    else if(x is int) return _plusDouble(x.toDouble());
  }

  operator -(var x){
    if(x is V) return _minusV(x);
    else if(x is double) return _minusDouble(x);
    else if(x is int) return _minusDouble(x.toDouble());
  }

  operator *(var x){
    if(x is double) return _multiplyByScalar(x);
    else if(x is int) return _multiplyByScalar(x.toDouble());
    else if(x is V) return _multiplyByVector(x);
  }

  operator /(double s){
    return(new V(list.map((e) => e / s).toList()));
  }

  //-----------------//
  // Private methods //
  //-----------------//

    V _zip(V v, Function f){
    if(this.length != v.length) throw("Vectors have different lengths: [${this.length}], [${v.length}].");
    V _interimV = new V.Zero(length);
    for(int i = 0; i<length; i++){
      _interimV[i] = f(this[i], v[i]);
    }
    return(_interimV);
  }

  V _plusDouble(double x){
    return(new V(list.map((e) => e + x).toList()));
  }

  V _plusV(V v){
    return(this._zip(v, (v1, v2) => v1 + v2));
  }

  V _minusDouble(double x){
    return(new V(list.map((e) => e - x).toList()));
  }

  V _minusV(V v){
    return(this._zip(v, (v1, v2) => v1 - v2));
  }

  //-----------------//
  // Mulitiplication //
  //-----------------//

  V _multiplyByScalar(double x){
    return(new V(list.map((i) => i * x).toList()));
  }

  M _multiplyByVector(V v){
    // this = t
    // M = { t0 * v } = { t0v0, t0v1, t0v2 }
    //     { t1 * v } = { t1v0, t1v1, t1v2 }
    //     { t2 * v } = { t2v0, t2v1, t2v2 }
    return(new M(list.map((i) => v * i).toList()));
  }
}