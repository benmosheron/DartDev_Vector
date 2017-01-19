// Copyright (c) 2015, Ben Sheron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library generic_vector_tools.example;

import 'package:generic_vector_tools/generic_vector_tools.dart';

main() {
  // Create a vector of two doubles - a position
  V<double> position = new V<double>([0.0, 10.0]);
  print("position:");
  position.printVector();
  print("");

  // Create a vector of positions
  V<V<double>> positions =
      new V<V<double>>([position, position + 10.0, position + 25.0]);
  print("positions:");
  positions.printVector();
  print("");

  // Calculate a matrix of distances between all positions
  V distances = positions.resolve(positions, (V p1, V p2) => p2 - p1);
  print("distances:");
  distances.printVector();
  print("");

  // M class is a wrapper around vector with some methods suited to 2D, like printing:
  M distanceMatrix = new M.fromV(distances);
  print("distanceMatrix:");
  distanceMatrix.printMatrix();
  print("");

  // We can also easily compute the magnitude of the distances (or any other function over elements)
  M magnitudes = new M.fromV(
      positions.resolve(positions, (V p1, V p2) => (p2 - p1).Magnitude));
  print("magnitudes:");
  magnitudes.printMatrix();
  print("");

  // For easy viewing:
  print("magnitudes (rounded for printing):");
  magnitudes.printMatrix(round: true);
  print("");

  // And easily apply functions over the matrix
  M magnitudesCubedThenRounded = magnitudes.mapF((e) => (e * e * e).round());
  print("magnitudesCubedThenRounded:");
  magnitudesCubedThenRounded.printMatrix();
  print("");
}
