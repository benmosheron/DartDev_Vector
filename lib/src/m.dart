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

  /// List of rows
  List<V> get rows => _m;

  /// List of columns
  List<V> get columns {
    var c = new List<V>(nCols);
    for (int i = 0; i < nCols; i++) {
      c[i] = new V(_m.map((r) => r[i]).toList());
    }
    return (c);
  }

  /// The number of rows
  int get nRows => _m.length;

  /// the number of columns
  int get nCols => _m[0].length;

  /// Diagonal elements of the matrix
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

  /// New matrix from a list of vectors representing the rows
  M(List<V> vals) {
    _m = vals;
  }

  /// New matrix from a vector of rows.
  M.fromV(V vals) : this(vals.list);

  /// New n*m matrix with all elements set to the same values
  M.all(int n, int m, dynamic val) {
    _m = new List<V>(n);
    for (int i = 0; i < n; i++) {
      _m[i] = new V.all(m, val);
    }
  }

  /// New n*m matrix with all elements set to 0.0
  M.zero(int n, int m) : this.all(n, m, 0.0);

  /// New n*m matrix with all elements set to 1.0
  M.one(int n, int m) : this.all(n, m, 1.0);

  /// New n*m matrix with all elements set to a random number between 0 and 1
  M.random(int n, int m) {
    _m = new List<V>(n);
    for (int i = 0; i < n; i++) {
      _m[i] = new V.random(m);
    }
  }

  /// New n*m matrix of generic elements
  M.generic(int n, int m) {
    _m = new List<V>(n);
    for (int i = 0; i < n; i++) {
      _m[i] = new V.generic(m);
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

  /// Combine two matrices by applying a function f to each element-pair.
  M zip(M A, Function f) {
    M _interimM = new M.generic(_m.length, this[0].length);

    for (int i = 0; i < _m.length; i++) {
      _interimM[i] = f(this[i], A[i]);
    }

    return (_interimM);
  }

  /// Multiple this matrix with another, element-wise.
  M elementWiseMultiply(M A) {
    return (zip(A, (t, a) => t.elementWiseMultiply(a)));
  }

  /// Divide this matrix by another, element-wise.
  M elementWiseDivide(M A) {
    return (zip(A, (t, a) => t.elementWiseDivide(a)));
  }

  /// Print the matrix to console
  String printMatrix({bool round: false}) {
    String s = "";
    for (int i = 0; i < _m.length; i++) {
      s += _m[i].printVector(round: round) +
          ((i != _m.length - 1) ? '\r\n' : '');
    }
    return s;
  }

  /// Apply a function to every element, return the results as a new matrix.
  M mapF(Function f) {
    return (new M(_m.map((v) => v.mapF(f)).toList()));
  }

  /// Call negate() of every row.
  M negate() {
    return (new M(this.rows.map((r) => r.negate()).toList()));
  }

  /// Return the sum of elements. Uses the + operator overload on each element.
  dynamic sum() {
    var x = this[0][0];
    for (int i = 0; i < nRows; i++) {
      for (int j = 0; j < nCols; j++) {
        if (!(i == 0 && j == 0)) x += this[i][j];
      }
    }
    return x;
  }

  //--------------------//
  // Operator Overloads //
  //--------------------//

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
