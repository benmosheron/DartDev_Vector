// Copyright (c) 2015, Ben Sheron. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library generic_vector_tools.test;

import 'package:args/args.dart';

import 'v2_tests.dart' as v2_tests;
import 'v_tests.dart' as v_tests;
import 'v_generic_tests.dart' as vg_tests;
import 'm_tests.dart' as m_tests;
import 'print_tests.dart' as print_tests;

void main(List<String> args) {
  // To run tests:
  //   >dart "C:\DartDev\Vector\test\Vector_test.dart"

  final ArgParser p = new ArgParser();
  p.addFlag("disablePrintTests", abbr: "p");

  var argResults = p.parse(args);

  // runTests("V2", v2_tests.run);
  // runTests("V", v_tests.run);
  runTests("V - Generics", vg_tests.run);
  // runTests("M", m_tests.run);
  if (argResults["disablePrintTests"]) {
    print('Skipping Print tests');
  } else {
    // runTests("Printing", print_tests.run);
  }

  // Template
  // group('GroupName', () {
  //   test('TestName', (){

  //     });
  // });
}

void runTests(String name, Function t) {
  print("Running tests: $name");
  t();
}
