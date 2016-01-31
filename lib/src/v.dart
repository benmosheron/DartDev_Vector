// Copyright (c) 2015, Ben Sheron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library generic_vector_tools.v;

import 'dart:math';

/// Vector with n elements
class V<T> {
  static final Random rand = new Random();
  List<T> list;

  // Trying to keep vectors strongly typed.
  // Generic vectors have _generic = true
  // try and keep these all the same type by controlling assignments
  bool _generic = false;
  // Set this to the index of the first assignment. This feels like a bit of a hack.
  int _genericSet = -1;

  //------------//
  // Properties //
  //------------//

  /// Get the elements as a List<T>. Use for access to dart collection methods.
  List<T> get elements => list;

  /// Number of elements (1st dimension)
  int get length => list.length;

  /// magnitude of the vector, only valid for numbers (but will try anyway)
  double get magnitude =>
      sqrt(list.map((e) => e * e).fold(0.0, (p, n) => p + n));

  //--------------//
  // Constructors //
  //--------------//

  /// Create a new vector from a list of elements
  V(List<T> vals) {
    if (vals is! List) throw new Exception('Vector input must be a List');
    list = vals;
  }

  /// Create a new vector from a filled list of the same value (generic)
  V.all(int size, T val) {
    list = new List<T>.filled(size, val);
  }

  /// Create a vector of 0.0s
  V.zero(int size) : this.all(size, 0.0 as T);

  /// Create a vector of 1.0s
  V.one(int size) : this.all(size, 1.0 as T);

  /// Create a vector of random doubles [0 to 1]
  V.random(int size) {
    list = new List<T>();
    for (int i = 0; i < size; i++) {
      list.add(rand.nextDouble() as T);
    }
  }

  /// Create a vector of a generic type. Once an element has been set,
  /// only elements of the same time can be added.
  V.generic(int _length) {
    _generic = true;
    list = new List(_length);
  }

  //---------//
  // Methods //
  //---------//

  toString() {
    // String s = "";
    String s = list.fold("", (a, b) => a.toString() + b.toString() + ", ");
    s = "(" + s.substring(0, s.length - 2) + ")";
    return s;
  }

  V zip(V v, Function f) {
    if (this.length !=
        v.length) throw ("Vectors have different lengths: [${this.length}], [${v.length}].");
    V _interimV = new V.generic(length);
    for (int i = 0; i < length; i++) {
      _interimV[i] = f(this[i], v[i]);
    }
    return (_interimV);
  }

  V elementWiseMultiply(V v) {
    return (this.zip(v, (v1, v2) => v1 * v2));
  }

  V elementWiseDivide(V v) {
    return (this.zip(v, (v1, v2) => v1 / v2));
  }

  V round() {
    return (new V(list.map((e) => e.round()).toList()));
  }

  String printVector({bool round: false}) {
    String row;
    if (round) {
      List _l = list.map((x) => x.round());
      row = _l.toString();
    } else {
      row = this.toString();
    }
    print(row);
    return row;
  }

  /// Create matrix of function results applied over two vectors
  V resolve(V v2, Function f) {
    // R = { f(t0, v0), f(t0, v1) }
    //     { f(t1, v0), f(t1, v1) }
    return (new V(list
        .map((e) => new V((v2.elements.map((e2) => f(e, e2)).toList())))
        .toList()));
  }

  V mapF(Function f) {
    return new V(elements.map((e) => f(e)).toList());
  }

  //--------------------//
  // Operator overloads //
  //--------------------//

  operator [](int i) => list[i];

  operator []=(int i, var value) {
    if (value is! T) throw new Exception(
        'Vector type mismatch value $value is not of type $T');
    if (!_generic) {
      // Just set it
      list[i] = value;
    } else {
      // It's generic D:
      if (_genericSet == -1) {
        // type of vector has not been set, so set it
        list[i] = value;
        _genericSet = i;
      } else {
        // type of vector has been set, so make sure it's the same
        if (value.runtimeType !=
            this[_genericSet].runtimeType) throw new Exception(
            'Vector type mismatch value $value is not of type $T');
        list[i] = value;
      }
    }
  }

  operator +(var x) {
    if (x is V) return _plusV(x);
    else if (x is double) return _plusDouble(x);
    else if (x is int) return _plusDouble(x.toDouble());
  }

  operator -(var x) {
    if (x is V) return _minusV(x);
    else if (x is double) return _minusDouble(x);
    else if (x is int) return _minusDouble(x.toDouble());
  }

  operator *(var x) {
    if (x is double) return _multiplyByScalar(x);
    else if (x is int) return _multiplyByScalar(x.toDouble());
    else if (x is V) return _multiplyByVector(x);
  }

  operator /(double s) {
    return (new V(list.map((e) => e / s).toList()));
  }

  operator ==(V other) {
    bool same = true;
    for (int i = 0; i < length; i++) {
      if (this[i] != other[i]) same = false;
    }
    return (same);
  }

  int get hashCode {
    int result = 17;
    for (int i = 0; i < length; i++) {
      result = 37 * result + this[i].hashCode;
    }
    return result;
  }
  //-----------------//
  // Private methods //
  //-----------------//

  V _plusDouble(double x) {
    return (new V(list.map((e) => e + x).toList()));
  }

  V _plusV(V v) {
    return (this.zip(v, (v1, v2) => v1 + v2));
  }

  V _minusDouble(double x) {
    return (new V(list.map((e) => e - x).toList()));
  }

  V _minusV(V v) {
    return (this.zip(v, (v1, v2) => v1 - v2));
  }

  //-----------------//
  // Mulitiplication //
  //-----------------//

  V _multiplyByScalar(double x) {
    return (new V(list.map((i) => i * x).toList()));
  }

  V _multiplyByVector(V v) {
    // this = t
    // R = { t0 * v } = { t0v0, t0v1, t0v2 }
    //     { t1 * v } = { t1v0, t1v1, t1v2 }
    //     { t2 * v } = { t2v0, t2v1, t2v2 }
    return (new V(list.map((i) => v * i).toList()));
  }
}
