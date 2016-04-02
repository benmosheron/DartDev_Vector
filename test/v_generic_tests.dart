// Copyright (c) 2015, Ben Sheron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library generic_vector_tools.v_generic_tests;

import 'package:generic_vector_tools/generic_vector_tools.dart';
import 'package:test/test.dart';

import 'test_utils.dart';

void run() {
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
      expectTrue(ints.elements.every((e) => e is int));
      for (int i = 0; i < _n; i++) expectTrue(ints[i] == i);
    });

    test('Test strong typing on ass.  ', () {
      // that's assign ;)
      V<int> ints = new V<int>([1, 2, 3]);
      expect(() => ints[1] = new V2.zero(), throws);
    });

    test('Test adding elements to generic vector', () {
      V spooky = new V.generic(3);
      
      spooky[0] = 1; // add an int
      spooky[1] = 2.3; // need to be able to do this, because when compiled to javascript, 1.0 (double) turns to 1 (int)
      spooky[2] = "sadly it means we can do this too";
    });

    test('Test equality               ', () {
      V<V2> v1 = new V<V2>([oneV2, oneV2 * 2.0, oneV2 * 3.0]);
      V<V2> v2 = new V<V2>([oneV2, oneV2 * 2.0, oneV2 * 3.0]);
      expectTrue(v1 == v2);
    });

    test('Test vector of double (lol) ', () {
      V<double> v1 = new V<double>([1.0, 2.0]);
      V<double> v2 = new V<double>([3.0, 4.0]);

      expectTrue((v1 + v2).elements[0] == 4.0);
      expectTrue((v1 + v2).elements[1] == 6.0);
    });

    test('Test vector of vectors      ', () {
      V<V> v1 = new V<V>([oneVector, oneVector * 2.0]);
      V<V> v2 = new V<V>([oneVector * 3.0, oneVector * 4.0]);

      expectTrue(v1[0] is V<double>);
      expectTrue(v1[1] is V<double>);
      expectTrue(v2[0] is V<double>);
      expectTrue(v2[1] is V<double>);
      expectTrue(v1[0][0] == 1);
      expectTrue(v1[1][0] == 2);
    });

    test('Test vector of strings      ', () {
      V<String> v1 = new V<String>(["one", "two"]);
      V<String> v2 = new V<String>(["three", "four"]);

      V v = v1 + v2;

      expectTrue(v[0] == "onethree");
      expectTrue(v[1] == "twofour");
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
      expectTrue(D[0] is V<V2>); // distance between
      expectTrue(D[0][0] == new V2.zero()); // p0 => p0
      expectTrue(D[0][1] == new V2(0.0, 1.0)); // p0 => p1
      expectTrue(D[0][2] == new V2(1.0, 0.0)); // p0 => p2
      expectTrue(D[0][3] == new V2(1.0, 1.0)); // p0 => p3

      expectTrue(D[1][2] == new V2(1.0, -1.0)); // p1 => p2

      // Symmetric elements are negatives
      for (int i = 0; i < 4; i++) {
        // With zero V2s on diagonals
        expectTrue(D[i][i] == new V2.zero());
        for (int j = 0; j < 4; j++) {
          expectTrue(D[i][j] == D[j][i].negate());
        }
      }
    });

    test('Test selfResolve            ', () {
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

      V D = p.selfResolve(distanceBetween);

      // First row of D is the distances between p0 and all other particles
      expectTrue(D[0] is V<V2>); // distance between
      expectTrue(D[0][0] == new V2.zero()); // p0 => p0
      expectTrue(D[0][1] == new V2(0.0, 1.0)); // p0 => p1
      expectTrue(D[0][2] == new V2(1.0, 0.0)); // p0 => p2
      expectTrue(D[0][3] == new V2(1.0, 1.0)); // p0 => p3

      expectTrue(D[1][2] == new V2(1.0, -1.0)); // p1 => p2

      // Symmetric elements are negatives
      for (int i = 0; i < 4; i++) {
        // With zero V2s on diagonals
        expectTrue(D[i][i] == new V2.zero());
        for (int j = 0; j < 4; j++) {
          expectTrue(D[i][j] == D[j][i].negate());
        }
      }
    });

    test('Test zip different types    ', () {
      V<V2> velocities = new V([oneV2, oneV2]);
      V<double> v = new V([5.0, 6.0]);

      V r = velocities.zip(v, (V2 a, double b) => a * b);

      expectTrue(r[0] == new V2.both(5.0));
      expectTrue(r[1] == new V2.both(6.0));
    });

    test('Test magnitude double       ', () {
      V v1 = new V.generic(2);
      expect(() => v1.magnitude, throws);
      v1[0] = 3.0;
      expect(() => v1.magnitude, throws);
      v1[1] = 4.0;
      expectTrue(v1.magnitude == 5.0);
    });

    test('Test magnitude throws       ', () {
      V<V> v1 = new V<V>([oneVector, oneVector * 2.0]);
      expect(() => v1.magnitude, throws);
    });

    test('Test negate                 ', () {
      V<V> v1 = new V<V>([oneVector, oneVector * 2.0]);
      V<V> expected = new V<V>([new V.all(2, -1.0), new V.all(2, -2.0)]);
      V v2 = v1.negate();
      expectTrue(v2 == expected);
    });

    test('Test sum                    ', () {
      V<V> v1 = new V<V>([oneVector, oneVector * 2.0]);
      // sum of v1 = v1[0] + v1[1] = (1, 1) + (2, 2)
      V<double> expected = new V<double>([3.0, 3.0]);
      expectTrue(v1.sum() == expected);
    });

    test('Test sumRecursive           ', () {
      V<V> v1 = new V<V>([oneVector, oneVector * 2.0]);
      V<V> v11 = new V<V>([v1, v1 * 2.0]);
      // sumRecursive of v11 = sum(sum(v11[0]), sum(v11[1])) = ((1+1) + (2+2)) +((2+2) + (4+4))
      expectTrue(v11.sumRecursive() == 18.0);
      expectTrue(new V([v11, v11 * 2, v11 * 3]).sumRecursive() ==
          18.0 + (18.0 * 2.0) + (18.0 * 3.0));
    });

    test('Test every                  ', () {
      V<V> v1 = new V<V>([oneVector, oneVector]);
      expectTrue(v1.every((e) => e is V<double>));
      expectTrue(v1.every((e) => e == oneVector));
    });

    test('Test any                    ', () {
      V<V> v1 = new V<V>([oneVector, oneVector * 2.0]);
      expectTrue(v1.any((e) => e == oneVector * 2.0));
    });

    test('Test inputs not list        ', () {
      var list = [1, 2];
      var hasToList = list.map((e) => e + 1);

      V v1 = new V(list);
      V v2 = new V(hasToList);

      expectTrue(v1 is V);
      expectTrue(v2 is V);
    });
  });
}
