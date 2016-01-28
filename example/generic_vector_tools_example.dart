// Copyright (c) 2015, Ben Sheron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library generic_vector_tools.example;

import 'package:generic_vector_tools/generic_vector_tools.dart';

main() {
  // Create a vector of two doubles - a position
  V<double> position = new V<double>([0.0, 1.0]);
  print("position:");
  position.Print();

  // Create a vector of positions
  V<V<double>> positions =
      new V<V<double>>([position, position + 1.0, position + 2.0]);
  print("positions:");
  positions.Print();
}
