// Copyright (c) 2015, Ben Sheron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library generic_vector_tools.test;

import 'package:generic_vector_tools/generic_vector_tools.dart';
import 'package:test/test.dart';

void main() {
  // To run tests:
  //   >dart "C:\DartDev\Vector\test\Vector_test.dart"

  group('V2', () {
    V2 zeroVector2;
    V2 oneVector2;

    setUp(() {
      zeroVector2 = new V2.zero();
      oneVector2 = new V2.one();
    });

    test('Test zero', () {
      expect(zeroVector2.x == 0.0 && zeroVector2.y == 0.0, isTrue);
    });

    test('Test one', () {
      expect(oneVector2.x == 1.0 && oneVector2.y == 1.0, isTrue);
    });

    test('Test operations', () {
      V2 v1 = new V2(2.0, 3.0);
      V2 v2 = new V2(10.0, 0.0);
      double c1 = 8.0;
      double c2 = 4.0;

      // (12, 3)
      V2 v3 = v2 + v1;

      // (96, 24)
      V2 v4 = v3 * c1;

      // (24, 6)
      V2 v5 = v4 / c2;

      // (23, 5)
      V2 v6 = v5 - new V2.one();
      expect(v6.x == 23.0 && v6.y == 5.0, isTrue);
    });

    test('Test equality', () {
      V2 v1 = new V2(1.0, 1.1);
      V2 v2 = new V2(1.0, 1.1);
      _expectTrue(v1 == v2);
    });

    test('Test magnitude', () {
      V2 v1 = new V2.int(3, 4);
      _expectTrue(v1.unit == new V2(3.0 / 5.0, 4.0 / 5.0));
    });

    test('Test magnitude of zero', () {
      _expectTrue(zeroVector2.unit == new V2.zero());
    });

    test('Test Unit', () {
      V2 v1 = new V2.int(3, 4);
      _expectTrue(v1.magnitude == 5.0);
    });

    test('Test Unit of zero', () {
      _expectTrue(zeroVector2.magnitude == 0.0);
    });
  });

  group('V', () {
    V zeroVector;
    V oneVector;

    setUp(() {
      zeroVector = new V.all(4, 0.0);
      oneVector = new V.all(4, 1.0);
    });

    // "All" tests
    test('Test correct number of elements                ', () {
      expect(zeroVector.list.length == 4, isTrue);
    });

    test('Test all zero                                  ', () {
      expect(zeroVector.list.every((d) => d == 0.0), isTrue);
    });

    test('Test all one                                   ', () {
      expect(oneVector.list.every((d) => d == 1.0), isTrue);
    });

    test('Test zero constructor                          ', () {
      V z = new V.zero(10);
      expect(z.list.every((d) => d == 0.0), isTrue);
      expect(z.list.length == 10, isTrue);
    });

    test('Test one constructor                           ', () {
      V o = new V.one(10);
      expect(o.list.every((d) => d == 1.0), isTrue);
      expect(o.list.length == 10, isTrue);
    });

    test('Test random constructor                        ', () {
      V o = new V.random(10);
      _expectTrue(o.list.every((d) => d is double));
      _expectTrue(o.list.every((d) => d >= 0.0 && d <= 1.0));
    });

    // Test operations
    test('Test []                                        ', () {
      V v = new V.zero(3);
      v[0] = 1.0;
      v[1] = 2.0;
      v[2] = 3.0;
      expect(v[0] == 1.0, isTrue);
      expect(v[1] == 2.0, isTrue);
      expect(v[2] == 3.0, isTrue);
    });

    test('Test equality                                  ', () {
      V v1 = new V([1.0, 1.1, 1.2]);
      V v2 = new V([1.0, 1.1, 1.2]);
      _expectTrue(v1 == v2);
    });

    test('Test + v                                       ', () {
      V v1 = new V.zero(3);
      v1[0] = 1.0;
      v1[1] = 2.0;
      v1[2] = 3.0;
      V v2 = new V.zero(3);
      v2[0] = 4.0;
      v2[1] = -200.0;
      v2[2] = 32.0;

      V v = v1 + v2;

      expect(v[0] == 5.0, isTrue);
      expect(v[1] == -198.0, isTrue);
      expect(v[2] == 35.0, isTrue);
    });

    test('Test + c                                       ', () {
      V v1 = new V.zero(3);
      v1[0] = 1.0;
      v1[1] = 2.0;
      v1[2] = 3.0;

      V vd = v1 + 10.0;
      V vi = v1 + 10;

      expect(vd[0] == vi[0] && vd[0] == 11.0, isTrue);
      expect(vd[1] == vi[1] && vd[1] == 12.0, isTrue);
      expect(vd[2] == vi[2] && vd[2] == 13.0, isTrue);
    });

    test('Test - v                                       ', () {
      V v1 = new V.zero(3);
      v1[0] = 1.0;
      v1[1] = 2.0;
      v1[2] = 3.0;
      V v2 = new V.zero(3);
      v2[0] = 4.0;
      v2[1] = -200.0;
      v2[2] = 32.0;

      V v = v1 - v2;

      expect(v[0] == -3.0, isTrue);
      expect(v[1] == 202.0, isTrue);
      expect(v[2] == -29.0, isTrue);
    });

    test('Test - c                                       ', () {
      V v1 = new V.zero(3);
      v1[0] = 1.0;
      v1[1] = 2.0;
      v1[2] = 3.0;

      V vd = v1 - 10.0;
      V vi = v1 - 10;

      expect(vd[0] == vi[0] && vd[0] == -9.0, isTrue);
      expect(vd[1] == vi[1] && vd[1] == -8.0, isTrue);
      expect(vd[2] == vi[2] && vd[2] == -7.0, isTrue);
    });

    test('Test * scalar                                  ', () {
      V v1 = new V.zero(3);
      v1[0] = 1.0;
      v1[1] = 2.0;
      v1[2] = 3.0;

      V va = v1 * 3.0;
      V vb = v1 * -9.0;

      expect(va[0] == 3.0, isTrue);
      expect(va[1] == 6.0, isTrue);
      expect(va[2] == 9.0, isTrue);
      expect(vb[0] == -9.0, isTrue);
      expect(vb[1] == -18.0, isTrue);
      expect(vb[2] == -27.0, isTrue);
    });

    test('Test * vector                                  ', () {
      // { 1 }                 {  4  5  6  7 }
      // { 2 } * { 4 5 6 7 } = {  8 10 12 14 }
      // { 3 }                 { 12 15 18 21 }

      V v1 = new V.zero(3);
      v1[0] = 1.0;
      v1[1] = 2.0;
      v1[2] = 3.0;

      V v2 = new V.zero(4);
      v2[0] = 4.0;
      v2[1] = 5.0;
      v2[2] = 6.0;
      v2[3] = 7.0;

      V R = v1 * v2;

      expect(R[0][0] == 4.0, isTrue);
      expect(R[0][1] == 5.0, isTrue);
      expect(R[0][2] == 6.0, isTrue);
      expect(R[0][3] == 7.0, isTrue);
      expect(R[1][0] == 8.0, isTrue);
      expect(R[1][1] == 10.0, isTrue);
      expect(R[1][2] == 12.0, isTrue);
      expect(R[1][3] == 14.0, isTrue);
      expect(R[2][0] == 12.0, isTrue);
      expect(R[2][1] == 15.0, isTrue);
      expect(R[2][2] == 18.0, isTrue);
      expect(R[2][3] == 21.0, isTrue);
    });

    test('Test /                                         ', () {
      V v1 = new V.zero(3);
      v1[0] = 3.0;
      v1[1] = -4.0;
      v1[2] = 5.0;

      V va = v1 / 2.0;
      V vb = v1 / -4.0;

      expect(va[0] == 1.5, isTrue);
      expect(va[1] == -2.0, isTrue);
      expect(va[2] == 2.5, isTrue);
      expect(vb[0] == -0.75, isTrue);
      expect(vb[1] == 1.0, isTrue);
      expect(vb[2] == -1.25, isTrue);
    });

    test('Test magnitude                                 ', () {
      _expectTrue(new V.one(1).magnitude == 1);
      _expectTrue(new V([3.0, 4.0]).magnitude == 5.0);
      _expectTrue(new V([4.0, 3.0]).magnitude == 5.0);
      _expectTrue(
          new V([1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).magnitude ==
              3.0);
    });

    test('Test element wise multiply                     ', () {
      V v1 = new V.zero(3);
      v1[0] = 3.0;
      v1[1] = -4.0;
      v1[2] = 5.0;

      V v2 = new V.zero(3);
      v2[0] = 4.0;
      v2[1] = 5.0;
      v2[2] = 6.0;

      V va = v1.elementWiseMultiply(v2);

      expect(va[0] == 12.0, isTrue);
      expect(va[1] == -20.0, isTrue);
      expect(va[2] == 30.0, isTrue);
    });

    test('Test element wise divide                       ', () {
      V v1 = new V.zero(3);
      v1[0] = 3.0;
      v1[1] = -4.0;
      v1[2] = 5.0;

      V v2 = new V.zero(3);
      v2[0] = 4.0;
      v2[1] = 5.0;
      v2[2] = 5.0;

      V va = v1.elementWiseDivide(v2);

      expect(va[0] == 0.75, isTrue);
      expect(va[1] == -0.8, isTrue);
      expect(va[2] == 1.0, isTrue);
    });

    test('Test resolve                                   ', () {
      V v1 = new V([0.0, 1.0, 2.0]);
      V v2 = new V([10.0, 11.0, 12.0]);

      f1(x, y) => x + y;
      f2(x, y) => x * y;

      V R1 = v1.resolve(v2, f1);
      V R2 = v1.resolve(v2, f2);

      // Expected results
      M E1 = new M.FromArray(
          3, 3, [10.0, 11.0, 12.0, 11.0, 12.0, 13.0, 12.0, 13.0, 14.0]);

      M E2 = new M.FromArray(
          3, 3, [0.0, 0.0, 0.0, 10.0, 11.0, 12.0, 20.0, 22.0, 24.0]);

      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          _expectTrue(R1[i][j] == E1[i][j]);
          _expectTrue(R2[i][j] == E2[i][j]);
        }
      }
    });

    test('Test mapF                                      ', () {
      V v1 = new V([0.0, 1.0, 2.0]);

      f1(x) => x * x;

      V vr = v1.mapF(f1);

      // Expected results
      V e1 = new V([0.0, 1.0, 4.0]);

      for (int i = 0; i < 3; i++) {
        _expectTrue(vr[i] == e1[i]);
      }
    });

    // template
    // test('Test ', () {
    //   expect(, isTrue);
    // });
  });

  group('V Generics', () {
    V oneVector;
    V2 oneV2;

    setUp(() {
      oneVector = new V.all(2, 1.0);
      oneV2 = new V2.one();
    });

    test('Test generic constructor    ', () {
      int _n = 3;
      V ints = new V.generic(3);
      for (int i = 0; i < _n; i++) {
        ints[i] = i;
      }
      _expectTrue(ints.elements.every((e) => e is int));
      for (int i = 0; i < _n; i++) _expectTrue(ints[i] == i);
    });

    test('Test strong typing on ass.  ', () {
      // thats assign ;)
      V<int> ints = new V<int>([1, 2, 3]);
      expect(() => ints[1] = new V2.zero(), throws);
    });

    test('Test strong typing generic  ', () {
      // thats assign ;)
      V spooky = new V.generic(3);
      // Set the type
      spooky[0] = 1; // sets type to int
      expect(() => spooky[1] = new V2.zero(), throws);
    });

    test('Test equality               ', () {
      V<V2> v1 = new V<V2>([oneV2, oneV2 * 2.0, oneV2 * 3.0]);
      V<V2> v2 = new V<V2>([oneV2, oneV2 * 2.0, oneV2 * 3.0]);
      _expectTrue(v1 == v2);
    });

    test('Test vector of double (lol) ', () {
      V<double> v1 = new V<double>([1.0, 2.0]);
      V<double> v2 = new V<double>([3.0, 4.0]);

      _expectTrue((v1 + v2).elements[0] == 4.0);
      _expectTrue((v1 + v2).elements[1] == 6.0);
    });

    test('Test vector of vectors      ', () {
      V<V> v1 = new V<V>([oneVector, oneVector * 2.0]);
      V<V> v2 = new V<V>([oneVector * 3.0, oneVector * 4.0]);

      _expectTrue(v1[0] is V<double>);
      _expectTrue(v1[1] is V<double>);
      _expectTrue(v2[0] is V<double>);
      _expectTrue(v2[1] is V<double>);
      _expectTrue(v1[0][0] == 1);
      _expectTrue(v1[1][0] == 2);
    });

    test('Test vector of strings      ', () {
      V<String> v1 = new V<String>(["one", "two"]);
      V<String> v2 = new V<String>(["three", "four"]);

      V v = v1 + v2;

      _expectTrue(v[0] == "onethree");
      _expectTrue(v[1] == "twofour");
    });

    test('Test resolve                ', () {
      // Test with a useable scenario
      // Getting the matrix of vectors between a set of vectors

      // 4 particles
      V2 p0 = new V2(1.0, 1.0);
      V2 p1 = new V2(1.0, 2.0); // 1.0 above p0
      V2 p2 = new V2(2.0, 1.0); // 1.0 right of p0
      V2 p3 = new V2(2.0, 2.0);

      // set of positions
      V<V2> p = new V<V2>([p0, p1, p2, p3]);

      distanceBetween(x, y) => y - x;

      V D = p.resolve(p, distanceBetween);

      // First row of D is the distances between p0 and all other particles
      _expectTrue(D[0] is V<V2>); // distance between
      _expectTrue(D[0][0] == new V2.zero()); // p0 => p0
      _expectTrue(D[0][1] == new V2(0.0, 1.0)); // p0 => p1
      _expectTrue(D[0][2] == new V2(1.0, 0.0)); // p0 => p2
      _expectTrue(D[0][3] == new V2(1.0, 1.0)); // p0 => p3

      _expectTrue(D[1][2] == new V2(1.0, -1.0)); // p1 => p2

      // Symmetric elements are negatives
      for (int i = 0; i < 4; i++) {
        // With zero V2s on diagonals
        _expectTrue(D[i][i] == new V2.zero());
        for (int j = 0; j < 4; j++) {
          _expectTrue(D[i][j] == D[j][i].negate());
        }
      }
    });

    test('Test zip different types    ', () {
      V<V2> velocities = new V([oneV2, oneV2]);
      V<double> v = new V([5.0, 6.0]);

      V r = velocities.zip(v, (V2 a, double b) => a * b);

      _expectTrue(r[0] == new V2.both(5.0));
      _expectTrue(r[1] == new V2.both(6.0));
    });
  });

  group('M', () {
    test('Test equality                                  ', () {
      M M1 = new M.Zero(3, 3);
      M M2 = new M.Zero(3, 3);
      _expectTrue(M1 == M2);
    });

    test('Test row get                                   ', () {
      M O = new M.One(2, 3);
      var rows = O.Rows;
      _expectTrue(rows is List<V> == true);
      _expectTrue(rows.length == 2);
      _expectTrue(rows.every((v) => v.length == 3));
      _expectTrue(rows.every((v) => v.elements.every((e) => e == 1.0)));
    });

    test('Test column get                                ', () {
      // { 1 3 1 }
      // { 1 1 6 }
      M O = new M.One(2, 3);
      O[0][1] = 3.0;
      O[1][2] = 6.0;
      var cols = O.Columns;
      _expectTrue(cols is List<V> == true);
      _expectTrue(cols.length == 3);
      _expectTrue(cols.every((v) => v.length == 2));
      _expectTrue(cols[1][0] == 3.0);
      _expectTrue(cols[2][1] == 6.0);
    });

    test('Test diagonals                                 ', () {
      // { 1 3 1 }
      // { 1 1 6 }
      // { 9 8 7 }
      M m =
          new M.FromArray(3, 3, [1.0, 3.0, 1.0, 1.0, 1.0, 6.0, 9.0, 8.0, 7.0]);

      _expectTrue(m.Diagonal is V<double>);
      _expectTrue(m.Diagonal == new V([1.0, 1.0, 7.0]));
    });

    test('Test One                                       ', () {
      M O = new M.One(2, 3);
      expect(O[0][0] == 1.0, isTrue);
      expect(O[0][1] == 1.0, isTrue);
      expect(O[0][2] == 1.0, isTrue);
      expect(O[1][0] == 1.0, isTrue);
      expect(O[1][1] == 1.0, isTrue);
      expect(O[1][2] == 1.0, isTrue);
    });

    test('Test FromArray                                 ', () {
      // 1 2 3
      // 4 5 6
      M O = new M.FromArray(2, 3, [1.0, 2.0, 3.0, 4.0, 5.0, 6.0]);
      expect(O[0][0] == 1.0, isTrue);
      expect(O[0][1] == 2.0, isTrue);
      expect(O[0][2] == 3.0, isTrue);
      expect(O[1][0] == 4.0, isTrue);
      expect(O[1][1] == 5.0, isTrue);
      expect(O[1][2] == 6.0, isTrue);
    });

    test('Test FromArray fail                            ', () {
      expect(() => new M.FromArray(1, 1, [0, 0]), throws);
    });

    test('Test + M                                       ', () {
      M O1 = new M.One(2, 3);
      M O2 = new M.One(2, 3);
      M R = O1 + O2;
      expect(R.Rows.every((r) => r.elements.every((e) => e == 2.0)), isTrue);
    });

    test('Test + c                                       ', () {
      M O1 = new M.One(2, 3);
      M R = O1 + 1.0;
      expect(R.Rows.every((r) => r.elements.every((e) => e == 2.0)), isTrue);
    });

    test('Test - M                                       ', () {
      M O1 = new M.One(2, 3);
      M O2 = new M.One(2, 3);
      M R = O1 - O2;
      expect(R.Rows.every((r) => r.elements.every((e) => e == 0.0)), isTrue);
    });

    test('Test - c                                       ', () {
      M O1 = new M.One(2, 3);
      M R = O1 - 1.0;
      expect(R.Rows.every((r) => r.elements.every((e) => e == 0.0)), isTrue);
    });

    test('Test * c                                       ', () {
      M O1 = new M.One(2, 3);
      M R = O1 * 2.0;
      expect(R.Rows.every((r) => r.elements.every((e) => e == 2.0)), isTrue);
    });

    test('Test / c                                       ', () {
      M O1 = new M.One(2, 3);
      M R = O1 / 2.0;
      expect(R.Rows.every((r) => r.elements.every((e) => e == 0.5)), isTrue);
    });

    test('Test mismatch                                  ', () {
      M M1 = new M.One(2, 3);
      M M2 = new M.One(3, 2);

      expect(() => M1 + M2, throws);
      expect(() => M1 - M2, throws);
    });

    test('Test element wise multiply                     ', () {
      M M1 = new M.FromArray(2, 3, [1.0, 2.0, 3.0, 4.0, 5.0, 6.0]);
      M M2 = new M.FromArray(2, 3, [1.0, 2.0, 3.0, 4.0, 5.0, 6.0]);

      M R = M1.ElementWiseMultiply(M2);
      expect(R[0][0] == 1.0, isTrue);
      expect(R[0][1] == 4.0, isTrue);
      expect(R[0][2] == 9.0, isTrue);
      expect(R[1][0] == 16.0, isTrue);
      expect(R[1][1] == 25.0, isTrue);
      expect(R[1][2] == 36.0, isTrue);
    });

    test('Test element wise divide                       ', () {
      M M1 = new M.FromArray(2, 3, [1.0, 8.0, 27.0, 64.0, 125.0, 216.0]);
      M M2 = new M.FromArray(2, 3, [1.0, 2.0, 3.0, 4.0, 5.0, 6.0]);

      M R = M1.ElementWiseDivide(M2);
      expect(R[0][0] == 1.0, isTrue);
      expect(R[0][1] == 4.0, isTrue);
      expect(R[0][2] == 9.0, isTrue);
      expect(R[1][0] == 16.0, isTrue);
      expect(R[1][1] == 25.0, isTrue);
      expect(R[1][2] == 36.0, isTrue);
    });

    test('Test element wise mismatch                     ', () {
      M M1 = new M.One(2, 3);
      M M2 = new M.One(3, 2);

      expect(() => M1.ElementWiseMultiply(M2), throws);
      expect(() => M1.ElementWiseDivide(M2), throws);
    });

    test('Test MapF                                      ', () {
      M M1 = new M.FromArray(2, 2, [1.0, 2.0, 3.0, 4.0]);

      M E1 = new M.FromArray(2, 2, [10.0, 20.0, 30.0, 40.0]);

      _expectMatrixEquality(M1, E1);
    });
  });

  group('Test printing', () {
    test('Test V.printVector()', () {
      V d = new V([0.0, 1.0]);
      _expectTrue(d.printVector() == "(0.0, 1.0)");
      _expectTrue(d.printVector(round: true) == "(0, 1)");
      V D = new V([d, d + 1.0, d + 2.0]);
      _expectTrue(D.printVector() == "((0.0, 1.0), (1.0, 2.0), (2.0, 3.0))");
      _expectTrue(D.printVector(round: true) == "((0, 1), (1, 2), (2, 3))");
      V DD = new V([D, D + 1.0, D + 2.0]);
      _expectTrue(DD.printVector() ==
          '(((0.0, 1.0), (1.0, 2.0), (2.0, 3.0)),' +
              ' ((1.0, 2.0), (2.0, 3.0), (3.0, 4.0)),' +
              ' ((2.0, 3.0), (3.0, 4.0), (4.0, 5.0)))');
    });

    test('Test M.printVector()', () {
      M O = new M.FromArray(2, 3, [1.5, 2.0, 3.0, 4.0, 5.0, 6.0]);
      _expectStringsEqual(O.Print(), '(1.5, 2.0, 3.0)\r\n(4.0, 5.0, 6.0)');
      _expectStringsEqual(O.Print(round: true), '(2, 2, 3)\r\n(4, 5, 6)');
      V v = new V([0.0, 1.0]);
      M A = new M.FromArray(
          2, 3, [v, v + 1.0, v + 2.0, v + 3.0, v + 4.0, v + 5.0]);
      _expectStringsEqual(A.Print(),
          '((0.0, 1.0), (1.0, 2.0), (2.0, 3.0))\r\n((3.0, 4.0), (4.0, 5.0), (5.0, 6.0))');
    });
  });

  // Template
  // group('GroupName', () {
  //   test('TestName', (){

  //     });
  // });
}

// == seems to get confused by newline, so comparing element-wise
void _expectStringsEqual(String s1, String s2) {
  for (int i = 0; i < s1.length; i++) {
    _expectTrue(s1[i] == s2[i]);
  }
}

void _expectMatrixEquality(M M1, M M2) {
  _expectTrue(M1.nRows == M2.nRows);
  _expectTrue(M1.nCols == M2.nCols);

  for (int i = 0; i < M1.nRows; i++) {
    for (int j = 0; j < M1.nCols; j++) {
      _expectTrue(M1[i][j] == M1[i][j]);
      _expectTrue(M2[i][j] == M2[i][j]);
    }
  }
}

void _expectTrue(bool b) {
  expect(b, isTrue);
}
