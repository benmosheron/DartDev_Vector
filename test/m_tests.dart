// Copyright (c) 2015, Ben Sheron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library generic_vector_tools.m_tests;

import 'package:generic_vector_tools/generic_vector_tools.dart';
import 'package:test/test.dart';

import 'test_utils.dart';


void run(){
  group('M', () {
    test('Test equality                                  ', () {
      M M1 = new M.zero(3, 3);
      M M2 = new M.zero(3, 3);
      expectTrue(M1 == M2);
    });

    test('Test row get                                   ', () {
      M O = new M.one(2, 3);
      var rows = O.rows;
      expectTrue(rows is List<V> == true);
      expectTrue(rows.length == 2);
      expectTrue(rows.every((v) => v.length == 3));
      expectTrue(rows.every((v) => v.elements.every((e) => e == 1.0)));
    });

    test('Test column get                                ', () {
      // { 1 3 1 }
      // { 1 1 6 }
      M O = new M.one(2, 3);
      O[0][1] = 3.0;
      O[1][2] = 6.0;
      var cols = O.columns;
      expectTrue(cols is List<V> == true);
      expectTrue(cols.length == 3);
      expectTrue(cols.every((v) => v.length == 2));
      expectTrue(cols[1][0] == 3.0);
      expectTrue(cols[2][1] == 6.0);
    });

    test('Test diagonals                                 ', () {
      // { 1 3 1 }
      // { 1 1 6 }
      // { 9 8 7 }
      M m =
          new M.fromArray(3, 3, [1.0, 3.0, 1.0, 1.0, 1.0, 6.0, 9.0, 8.0, 7.0]);

      expectTrue(m.diagonal is V<double>);
      expectTrue(m.diagonal == new V([1.0, 1.0, 7.0]));
    });

    test('Test One                                       ', () {
      M O = new M.one(2, 3);
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
      M O = new M.fromArray(2, 3, [1.0, 2.0, 3.0, 4.0, 5.0, 6.0]);
      expect(O[0][0] == 1.0, isTrue);
      expect(O[0][1] == 2.0, isTrue);
      expect(O[0][2] == 3.0, isTrue);
      expect(O[1][0] == 4.0, isTrue);
      expect(O[1][1] == 5.0, isTrue);
      expect(O[1][2] == 6.0, isTrue);
    });

    test('Test FromArray fail                            ', () {
      expect(() => new M.fromArray(1, 1, [0, 0]), throws);
    });

    test('Test + M                                       ', () {
      M O1 = new M.one(2, 3);
      M O2 = new M.one(2, 3);
      M R = O1 + O2;
      expect(R.rows.every((r) => r.elements.every((e) => e == 2.0)), isTrue);
    });

    test('Test + c                                       ', () {
      M O1 = new M.one(2, 3);
      M R = O1 + 1.0;
      expect(R.rows.every((r) => r.elements.every((e) => e == 2.0)), isTrue);
    });

    test('Test - M                                       ', () {
      M O1 = new M.one(2, 3);
      M O2 = new M.one(2, 3);
      M R = O1 - O2;
      expect(R.rows.every((r) => r.elements.every((e) => e == 0.0)), isTrue);
    });

    test('Test - c                                       ', () {
      M O1 = new M.one(2, 3);
      M R = O1 - 1.0;
      expect(R.rows.every((r) => r.elements.every((e) => e == 0.0)), isTrue);
    });

    test('Test * c                                       ', () {
      M O1 = new M.one(2, 3);
      M R = O1 * 2.0;
      expect(R.rows.every((r) => r.elements.every((e) => e == 2.0)), isTrue);
    });

    test('Test / c                                       ', () {
      M O1 = new M.one(2, 3);
      M R = O1 / 2.0;
      expect(R.rows.every((r) => r.elements.every((e) => e == 0.5)), isTrue);
    });

    test('Test mismatch                                  ', () {
      M M1 = new M.one(2, 3);
      M M2 = new M.one(3, 2);

      expect(() => M1 + M2, throws);
      expect(() => M1 - M2, throws);
    });

    test('Test element wise multiply                     ', () {
      M M1 = new M.fromArray(2, 3, [1.0, 2.0, 3.0, 4.0, 5.0, 6.0]);
      M M2 = new M.fromArray(2, 3, [1.0, 2.0, 3.0, 4.0, 5.0, 6.0]);

      M R = M1.elementWiseMultiply(M2);
      expect(R[0][0] == 1.0, isTrue);
      expect(R[0][1] == 4.0, isTrue);
      expect(R[0][2] == 9.0, isTrue);
      expect(R[1][0] == 16.0, isTrue);
      expect(R[1][1] == 25.0, isTrue);
      expect(R[1][2] == 36.0, isTrue);
    });

    test('Test element wise divide                       ', () {
      M M1 = new M.fromArray(2, 3, [1.0, 8.0, 27.0, 64.0, 125.0, 216.0]);
      M M2 = new M.fromArray(2, 3, [1.0, 2.0, 3.0, 4.0, 5.0, 6.0]);

      M R = M1.elementWiseDivide(M2);
      expect(R[0][0] == 1.0, isTrue);
      expect(R[0][1] == 4.0, isTrue);
      expect(R[0][2] == 9.0, isTrue);
      expect(R[1][0] == 16.0, isTrue);
      expect(R[1][1] == 25.0, isTrue);
      expect(R[1][2] == 36.0, isTrue);
    });

    test('Test element wise mismatch                     ', () {
      M M1 = new M.one(2, 3);
      M M2 = new M.one(3, 2);

      expect(() => M1.elementWiseMultiply(M2), throws);
      expect(() => M1.elementWiseDivide(M2), throws);
    });

    test('Test MapF                                      ', () {
      M M1 = new M.fromArray(2, 2, [1.0, 2.0, 3.0, 4.0]);

      M E1 = new M.fromArray(2, 2, [10.0, 20.0, 30.0, 40.0]);

      expectMatrixEquality(M1, E1);
    });

    test('Test negate                                    ', () {
      M M1 = new M.fromArray(2, 2, [1.0, 2.0, 3.0, 4.0]);

      M M2 = M1.negate();

      M E1 = new M.fromArray(2, 2, [-1.0, -2.0, -3.0, -4.0]);

      expectMatrixEquality(M2, E1);
    });

    test('Test sum                                       ', () {
      M M1 = new M.fromArray(2, 2, [1.0, 2.0, 3.0, 4.0]);
      expectTrue(M1.sum() == 10.0);
    });

    test('Test zip                                       ', () {
      M M1 = new M.fromArray(2, 2, [1.0, 2.0, 3.0, 4.0]);
      M M2 = new M.fromArray(2, 2, [4.0, 3.0, 2.0, 1.0]);
      M E = new M.all(2, 3, 5.0);
      expectTrue(M1.zip(M2, (e1, e2) => e1 + e2) == E);
    });   
  });  
}