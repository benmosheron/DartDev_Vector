// Copyright (c) 2015, Ben Sheron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library generic_vector_tools.m;

import 'v.dart';

/// Matrix with n (rows) * m (cols) elements
class M {
  // A = { a00 a01 a02 }
  //     { a10 a11 a12 }
  //     { a20 a21 a22 }
  List<V> _m;

  //------------//
  // Properties //
  //------------//

  List<V> get rows => _m;

  List<V> get columns {
    var c = new List<V>(nCols);
    for (int i = 0; i < nCols; i++) {
      c[i] = new V(_m.map((r) => r[i]).toList());
    }
    return (c);
  }

  int get nRows => _m.length;

  int get nCols => _m[0].length;

  V get diagonal {
    List l = new List();
    // There will be a nicer way to do this, but I can't think of it.
    for (int i = 0; i < nRows; i++) {
      l.add(this[i][i]);
    }
    return (new V(l));
  }

  //--------------//
  // Constructors //
  //--------------//

  M(List<V> vals) {
    _m = vals;
  }

  M.fromV(V vals) : this(vals.list);

  M.all(int n, int m, double val) {
    _m = new List<V>(n);
    for (int i = 0; i < n; i++) {
      _m[i] = new V.all(m, val);
    }
  }

  M.zero(int n, int m) : this.all(n, m, 0.0);

  M.one(int n, int m) : this.all(n, m, 1.0);

  M.random(int n, int m) {
    _m = new List<V>(n);
    for (int i = 0; i < n; i++) {
      _m[i] = new V.random(m);
    }
  }

  /// Create a matrix of size n*m from an array of input values
  M.fromArray(int n, int m, List<double> vals) {
    if (vals.length !=
        n * m) throw ("Number of values provided (${vals.length}) does not match input size ($n * $m).");
    _m = new List<V>(n);
    for (int i = 0; i < n; i++) {
      _m[i] = new V.zero(m);
      for (int j = 0; j < m; j++) {
        _m[i][j] = vals[(i * m) + j];
      }
    }
  }

  //---------//
  // Methods //
  //---------//

  M zip(M A, Function f) {
    M _interimM = new M.zero(_m.length, this[0].length);

    for (int i = 0; i < _m.length; i++) {
      _interimM[i] = f(this[i], A[i]);
    }

    return (_interimM);
  }

  M elementWiseMultiply(M A) {
    return (zip(A, (t, a) => t.elementWiseMultiply(a)));
  }

  M elementWiseDivide(M A) {
    return (zip(A, (t, a) => t.elementWiseDivide(a)));
  }

  String printMatrix({bool round: false}) {
    String s = "";
    for (int i = 0; i < _m.length; i++) {
      s += _m[i].printVector(round: round) +
          ((i != _m.length - 1) ? '\r\n' : '');
    }
    return s;
  }

  M mapF(Function f) {
    return (new M(_m.map((v) => v.mapF(f)).toList()));
  }

  //--------------------//
  // Operator Overloads //
  //--------------------//

  // Note -

  operator [](int i) => _m[i];
  operator []=(int i, V v) => _m[i] = v;

  operator +(var x) {
    if (x is M) return _plusMatrix(x);
    else if (x is double) return _plusScalar(x);
    else if (x is int) return _plusScalar(x.toDouble());
  }

  operator -(var x) {
    if (x is M) return _minusMatrix(x);
    else if (x is double) return _minusScalar(x);
    else if (x is int) return _minusScalar(x.toDouble());
  }

  operator *(var x) {
    //if(x is M) return ElementWiseMultiply(x);
    /*else*/ if (x is double) return _multiplyScalar(x);
    else if (x is int) return _multiplyScalar(x.toDouble());
  }

  operator /(var x) {
    //if(x is M) return ElementWiseDivide(x);
    /*else*/ if (x is double) return _divideScalar(x);
    else if (x is int) return _divideScalar(x.toDouble());
  }

  operator ==(M other) {
    bool same = true;
    for (int i = 0; i < nRows; i++) {
      if (this[i] != other[i]) same = false;
    }
    return (same);
  }

  int get hashCode {
    int result = 17;
    for (int i = 0; i < nRows; i++) {
      result = 37 * result + this[i].hashCode;
    }
    return result;
  }
  //-----------------//
  // Private Methods //
  //-----------------//

  M _plusScalar(double c) {
    return (new M(_m.map((v) => v + c).toList()));
  }

  M _plusMatrix(M A) {
    return (this.zip(A, (t, a) => t + a));
  }

  M _minusScalar(double c) {
    return (new M(_m.map((v) => v - c).toList()));
  }

  M _minusMatrix(M A) {
    return (this.zip(A, (t, a) => t - a));
  }

  M _multiplyScalar(double c) {
    return (this.mapF((e) => e * c));
  }

  M _divideScalar(double c) {
    return (this.mapF((e) => e / c));
  }
}
