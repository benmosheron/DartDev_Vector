// Copyright (c) 2015, Ben Sheron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library Vector.V;

import 'dart:math';
import 'M.dart';

/// Vector with n elements
class V<T>{
  static final Random random = new Random();
  List<T> list;

  //------------//
  // Properties //
  //------------//

  List<T> get Elements => list;

  int get length => list.length;

  dynamic get Magnitude => sqrt(list.map((e) => e * e).fold(0.0, (p, n) => p + n));

  //--------------//
  // Constructors //
  //--------------//

  V(List<T> vals){
    list = vals;
  }

  V.All(int size, T val){
    list = new List<T>.filled(size, val);
  }

  V.Zero(int size):this.All(size, 0.0 as T);

  V.One(int size):this.All(size, 1.0 as T);

  V.Random(int size){
    list = new List<T>();
    for(int i = 0; i<size; i++){
      list.add(random.nextDouble() as T);
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

  void Print({bool round: false}){
    String row = "";
    if(round){
      Elements.forEach((e) => row += "${e.round()} ");
    }
    else{
      Elements.forEach((e) => row += "$e ");
    }
    print(row);
  }

  /// Create matrix of function results applied over two vectors
  M Resolve(V v2, Function f){
    // R = { f(t0, v0), f(t0, v1) }
    //     { f(t1, v0), f(t1, v1) }
    return(new M(list.map((e) => new V((v2.Elements.map((e2) => f(e, e2)).toList() ))).toList()));
  }

  V MapF(Function f){
    return new V(Elements.map((e) => f(e)).toList());
  }

  //--------------------//
  // Operator overloads //
  //--------------------//

  operator [](int i) => list[i];
  operator []=(int i, double value) => list[i] = value as T;

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

  operator ==(V other){
    bool same = true;
    for(int i=0; i<length; i++){
      if(this[i] != other[i])
        same = false;
    }
    return(same);
  }

  int get hashCode {
    int result = 17;
    for(int i=0; i<length; i++){
      result = 37 * result + this[i].hashCode;
    }
    return result;
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