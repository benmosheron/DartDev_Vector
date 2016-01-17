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

  List<V> get Columns {
   var c = new List<V>(nCols);
   for(int i = 0; i < nCols; i++){
      c[i] = new V(_m.map((r) => r[i]).toList());
   }
   return(c);
 }

  int get nRows => _m.length;

  int get nCols => _m[0].length;

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

  M.FromArray(int n, int m, List<double> vals){
    if(vals.length != n * m) throw("Number of values provided (${vals.length}) does not match input size ($n * $m).");
    _m = new List<V>(n);
    for(int i = 0; i < n; i++){
      _m[i] = new V.Zero(m);
      for(int j = 0; j < m; j++){
        _m[i][j] = vals[(i * m) + j];
      }
    }
  }

  //---------//
  // Methods //
  //---------//

  M ElementWiseMultiply(M A){
    return(_zip(A, (t, a) => t.ElementWiseMultiply(a)));
  }

  M ElementWiseDivide(M A){
    return(_zip(A, (t, a) => t.ElementWiseDivide(a)));
  }

  void Print({bool round: false}){
     _m.forEach((v) => v.Print(round: round));
  }

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

  operator -(var x){
    if(x is M) return _minusMatrix(x);
    else if (x is double) return _minusScalar(x);
    else if (x is int) return _minusScalar(x.toDouble());
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
    return(this._zip(A, (t, a) => t - a));
  }

}