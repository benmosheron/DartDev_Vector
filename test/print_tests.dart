// Copyright (c) 2015, Ben Sheron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library generic_vector_tools.print_tests;

import 'package:generic_vector_tools/generic_vector_tools.dart';
import 'package:test/test.dart';

import 'test_utils.dart';

void run(){
  group('Test printing', () {
    test('Test V.printVector()', () {
      V d = new V([0.0, 1.0]);
      print("");
      expectTrue(d.printVector() == "(0.0, 1.0)");
      print("");
      expectTrue(d.printVector(round: true) == "(0, 1)");
      V D = new V([d, d + 1.0, d + 2.0]);
      print("");
      expectTrue(D.printVector() == "((0.0, 1.0), (1.0, 2.0), (2.0, 3.0))");
      print("");
      expectTrue(D.printVector(round: true) == "((0, 1), (1, 2), (2, 3))");
      V DD = new V([D, D + 1.0, D + 2.0]);
      print("");
      expectTrue(DD.printVector() ==
          '(((0.0, 1.0), (1.0, 2.0), (2.0, 3.0)),'
              ' ((1.0, 2.0), (2.0, 3.0), (3.0, 4.0)),'
              ' ((2.0, 3.0), (3.0, 4.0), (4.0, 5.0)))');
      print("");
    });

    test('Test M.printVector()', () {
      M O = new M.fromArray(2, 3, [1.5, 2.0, 3.0, 4.0, 5.0, 6.0]);
      print("");
      expectStringsEqual(
          O.printMatrix(), '(1.5, 2.0, 3.0)\r\n(4.0, 5.0, 6.0)');
      print("");
      expectStringsEqual(O.printMatrix(round: true), '(2, 2, 3)\r\n(4, 5, 6)');
      print("");
      V v = new V([0.0, 1.0]);
      M A = new M.fromArray(
          2, 3, [v, v + 1.0, v + 2.0, v + 3.0, v + 4.0, v + 5.0]);
      expectStringsEqual(A.printMatrix(),
          '((0.0, 1.0), (1.0, 2.0), (2.0, 3.0))\r\n((3.0, 4.0), (4.0, 5.0), (5.0, 6.0))');
      print("");
    });
  });
}