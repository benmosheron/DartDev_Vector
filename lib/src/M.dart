// Copyright (c) 2015, Ben Sheron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library Vector.M;

import 'V.dart';

/// Matrix with n (rows) * m (cols) elements
class M{

  // A = { a00 a01 a02 }
  //     { a10 a11 a12 }
  //     { a20 a21 a22 }
  List<V> _m;

  List<V> get Rows => _m;

  //--------------//
  // Constructors //
  //--------------//

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

  //---------//
  // Methods //
  //---------//

  // M ElementWiseMultiply(M A){
  //   return(new M(_m.map((v) => v.ElementWiseMultiply(V v))))
  // }

  // M ElementWiseDivide(M A){
    
  // }

  //--------------------//
  // Operator Overloads //
  //--------------------//

  operator [](int i) => _m[i];
  operator []=(int i, V v) => _m[i] = v;

  operator +(var x){
    if(x is M) return _plusMatrix(x);
    else if (x is double) return _plusScalar(x);
    else if (x is int) return _plusScalar(x.toDouble());
  }

  //-----------------//
  // Private Methods //
  //-----------------//

  M _zip(M A, Function f){
    M _interimM = new M.Zero(_m.length, this[0].length);
    for(int i = 0; i<_m.length; i++){
      _interimM[i] = f(this[i], A[i]);
    }
    return(_interimM);
  }

  M _plusScalar(double c){
    return(new M(_m.map((v) => v + c).toList()));
  }

  M _plusMatrix(M A){
    return(this._zip(A, (t, a) => t + a));
  }

  M _minusScalar(double c){
    return(new M(_m.map((v) => v - c).toList()));
  }

  M _minusMatrix(M A){
    M _interimM = new M.Zero(_m.length, this[0].length);
    for(int i = 0; i<_m.length; i++){
      _interimM[i] = _m[i] - A[i];
    }
    return(_interimM);
  }

}