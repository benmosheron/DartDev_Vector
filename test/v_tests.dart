// Copyright (c) 2015, Ben Sheron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library generic_vector_tools.v_tests;

import 'dart:math';

import 'package:generic_vector_tools/generic_vector_tools.dart';
import 'package:test/test.dart';

import 'test_utils.dart';

void run() {
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
      expectTrue(o.list.every((d) => d is double));
      expectTrue(o.list.every((d) => d >= 0.0 && d <= 1.0));
    });

    test('Test random normalised constructor             ', () {
      Random random = new Random();

      var magnitudes = new List<double>();

      int N = 10;
      var randoms = new M.generic(10, 10);
      // Generate N random magnitudes
      for (int i = 0; i < N; i++) {
        magnitudes.add(random.nextDouble() * 100.0);
        // For each magnitude, generate a vecor of length j
        for (int j = 0; j < N; j++) {
          randoms[i][j] = (new V.randomNormalised(j + 1, magnitudes[i]));

          // The magnitude of the created vector should be as expected
          expectTrue(floatCompare(magnitudes[i], randoms[i][j].magnitude));
        }
      }
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
      expectTrue(v1 == v2);
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
      expectTrue(new V.one(1).magnitude == 1);
      expectTrue(new V([3.0, 4.0]).magnitude == 5.0);
      expectTrue(new V([4.0, 3.0]).magnitude == 5.0);
      expectTrue(
          new V([1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]).magnitude ==
              3.0);
    });

    test('Test unit                                      ', () {
      expectTrue(new V([1.0, 0.0]).unit == new V([1.0, 0.0]));
      expectTrue(new V([4.0, 3.0]).unit == new V([4.0 / 5.0, 3.0 / 5.0]));
      expectTrue(new V.zero(3).unit == new V.zero(3));
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
      M E1 = new M.fromArray(
          3, 3, [10.0, 11.0, 12.0, 11.0, 12.0, 13.0, 12.0, 13.0, 14.0]);

      M E2 = new M.fromArray(
          3, 3, [0.0, 0.0, 0.0, 10.0, 11.0, 12.0, 20.0, 22.0, 24.0]);

      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          expectTrue(R1[i][j] == E1[i][j]);
          expectTrue(R2[i][j] == E2[i][j]);
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
        expectTrue(vr[i] == e1[i]);
      }
    });

    test('Test sum                                       ', () {
      V v1 = new V([0.0, 1.0, 2.0]);
      expectTrue(v1.sum() == 3.0);
    });

    // template
    // test('Test ', () {
    //   expect(, isTrue);
    // });
  });
}
