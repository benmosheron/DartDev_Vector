// Copyright (c) 2015, Ben Sheron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library generic_vector_tools.v;

import 'dart:math';

/// Vector with n elements
class V<T> {
  static final Random rand = new Random();
  List<T> list;

  //------------//
  // Properties //
  //------------//

  /// Get the elements as a List<T>. Use for access to dart collection methods.
  List<T> get elements => list;

  /// Number of elements (1st dimension)
  int get length => list.length;

  /// magnitude of the vector, only valid for number T (but will try anyway)
  double get magnitude =>
      sqrt(list.map((e) => e * e).fold(0.0, (p, n) => p + n));

  /// return this vector normalised. If vector has magnitude zero, will return zero vector.
  V get unit {
    if (magnitude == 0.0) return new V.zero(length);
    return this / magnitude;
  }

  //--------------//
  // Constructors //
  //--------------//

  /// Create a new vector from a list of elements
  V(List<T> vals) {
    if (vals is! List) {
      try {
        vals = vals.toList();
        if (vals
            is! List) throw "Converting vector input to list, failed to create list";
      } catch (e) {
        throw "Vector input must be a List, or have a toList() method to call";
      }
    }
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
    list = new List<T>(size);
    for (int i = 0; i < size; i++) {
      list[i] = rand.nextDouble() as T;
    }
  }

  /// Create a vector of random doubles [-1 to 1], normalised to a supplied magnitude
  V.randomNormalised(int size, double magnitude) {
    list = new List<T>(size);

    // Get an array of uniform random numbers
    for (int i = 0; i < size; i++) {
      list[i] = (rand.nextDouble() * 2) - 1 as T;
    }
    double scale = magnitude / this.magnitude;

    list = list.map((e) => e * scale);
  }

  /// Create a vector of a generic type.
  V.generic(int _length) {
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

  /// Create a new vector by applying a function over every set of element pairs f(v1_i, v2_i)
  V zip(V v, Function f) {
    if (this.length !=
        v.length) throw ("Vectors have different lengths: [${this.length}], [${v.length}].");
    V _interimV = new V.generic(length);
    for (int i = 0; i < length; i++) {
      _interimV[i] = f(this[i], v[i]);
    }
    return (_interimV);
  }

  /// Multiply two vectors element-wise.
  V elementWiseMultiply(V v) {
    return (this.zip(v, (v1, v2) => v1 * v2));
  }

  /// Divide two vectors element-wise
  V elementWiseDivide(V v) {
    return (this.zip(v, (v1, v2) => v1 / v2));
  }

  /// Round every element using the element's .round() method
  V round() {
    return (new V(list.map((e) => e.round()).toList()));
  }

  /// Print the vector to console. Returns printed string.
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

  /// Create matrix (V<V>) of function results applied every set of element pairs f(v1_i, v2_j).
  /// Equivalent to to (v1 *[outer product] v2).mapF(f)
  V resolve(V v2, Function f) {
    // R = { f(v1_0, v2_0), f(v1_0, v2_1) }
    //     { f(v1_1, v2_0), f(v1_1, v2_1) }
    return (new V(list
        .map((e) => new V((v2.elements.map((e2) => f(e, e2)).toList())))
        .toList()));
  }

  /// Create matrix (V<V>) of function results applied every set of element pairs f(v_i, v_j).
  /// Equivalent to to (v *[outer product] v).mapF(f)
  V selfResolve(Function f) {
    // R = { f(v1_0, v1_0), f(v1_0, v1_1) }
    //     { f(v1_1, v1_0), f(v1_1, v1_1) }
    return (new V(list
        .map((e) => new V((elements.map((e2) => f(e, e2)).toList())))
        .toList()));
  }

  /// Apply a function to every element, returning the results as a new vector.
  V mapF(Function f) {
    return new V(elements.map((e) => f(e)).toList());
  }

  /// Return a vector with negated elements. First looks for a .negate() method on each element [(e) => e.negate()], then tries [(e) => -e].
  V negate() {
    return (_negate(this));
  }

  /// Return the sum of elements. Uses the + operator overload on each element.
  dynamic sum() {
    var x = this[0];
    for (int i = 1; i < length; i++) {
      x += this[i];
    }
    return x;
  }

  /// Return the sum of elements. Uses the + operator overload on each element, unless element is V, in which case calls sum() of that vector.
  dynamic sumRecursive() {
    // Treat all elements the same to hopefully avoid type shenanigans
    if (this[0] is V) {
      // Elements are vectors, call sumRecursive on each element
      return (this.mapF((e) => e.sumRecursive()).sum());
    } else {
      return this.sum();
    }
  }

  /// Easy access to List.every()
  bool every(Function f) {
    return (this.list.every((e) => f(e)));
  }

  /// Easy access to List.any()
  bool any(Function f) {
    return (this.list.any((e) => f(e)));
  }

  //--------------------//
  // Operator overloads //
  //--------------------//

  operator [](int i) => list[i];

  operator []=(int i, var value) {
    if (value is! T) throw new Exception(
        'Vector type mismatch value $value is not of type $T');

      list[i] = value;
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

  dynamic _negate(V v) {
    // If the elements are themselves vectors, call their negate methods
    if (v[0] is V) {
      // Assume if element [0] is...
      return (v.mapF((e) => e.negate()));
    } else {
      // otherwise it's probably a number
      return (v.mapF((e) => -e));
    }
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
