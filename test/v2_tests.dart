// Copyright (c) 2015, Ben Sheron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library generic_vector_tools.v2_tests;

import 'package:generic_vector_tools/generic_vector_tools.dart';
import 'package:test/test.dart';

import 'test_utils.dart';

void run() {
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
      expectTrue(v1 == v2);
    });

    test('Test unit', () {
      V2 v1 = new V2.int(3, 4);
      expectTrue(v1.unit == new V2(3.0 / 5.0, 4.0 / 5.0));
    });

    test('Test unit of zero', () {
      expectTrue(zeroVector2.unit == new V2.zero());
    });

    test('Test magnitude', () {
      V2 v1 = new V2.int(3, 4);
      expectTrue(v1.magnitude == 5.0);
    });

    test('Test magnitude of zero', () {
      expectTrue(zeroVector2.magnitude == 0.0);
    });

    test('Test random', () {
      // generate a load of random V2s
      var randoms = new List<V2>();
      var magnitudes = new List<double>();
      for(int i = 0; i = 100; i++){
        magnitudes.add(i.toDouble() + 1.0);
        randoms.add(new V2.random(magnitudes[i]));
        expectTrue(floatCompare(randoms[i].magnitude, magnitudes[i]));
      }
    });

    test('Test exactly 2 elements', () {
      V2 v = new V2(0,0);
      V2 vb = new V2.both(0);
      expect(() => v.list.add(0.0), throws);
      expect(() => vb.list.add(0.0), throws);
    });
  });
}
