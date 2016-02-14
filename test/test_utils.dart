// Copyright (c) 2015, Ben Sheron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library generic_vector_tools.test_utils;

import 'package:generic_vector_tools/generic_vector_tools.dart';
import 'package:test/test.dart';

// == seems to get confused by newline, so comparing element-wise
void expectStringsEqual(String s1, String s2) {
  for (int i = 0; i < s1.length; i++) {
    expectTrue(s1[i] == s2[i]);
  }
}

void expectMatrixEquality(M M1, M M2) {
  expectTrue(M1.nRows == M2.nRows);
  expectTrue(M1.nCols == M2.nCols);

  for (int i = 0; i < M1.nRows; i++) {
    for (int j = 0; j < M1.nCols; j++) {
      expectTrue(M1[i][j] == M1[i][j]);
      expectTrue(M2[i][j] == M2[i][j]);
    }
  }
}

void expectTrue(bool b) {
  expect(b, isTrue);
}

bool floatCompare(double d1, double d2, {double tol: 0.000000001}) {
  var d = d1 - d2;
  if (d < 0) d = -d;
  if (d <= tol) return true;
  return false;
}
