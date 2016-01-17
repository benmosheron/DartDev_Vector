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

  //-----------------//
  // Private methods //
  //-----------------//

  V _plusDouble(double x){
    List<double> _interimList = new List<double>(list.length);
    for(int i = 0; i< list.length; i++){
      _interimList[i] = list[i] + x;
    }
    return(new V(_interimList));
  }

  V _plusV(V v){
    List<double> _interimList = new List<double>(list.length);
    for(int i = 0; i< list.length; i++){
      _interimList[i] = list[i] + v[i];
    }
    return(new V(_interimList));
  }

  V _minusDouble(double x){
    List<double> _interimList = new List<double>(list.length);
    for(int i = 0; i< list.length; i++){
      _interimList[i] = list[i] - x;
    }
    return(new V(_interimList));
  }

  V _minusV(V v){
    List<double> _interimList = new List<double>(list.length);
    for(int i = 0; i< list.length; i++){
      _interimList[i] = list[i] - v[i];
    }
    return(new V(_interimList));
  }  
}