# generic_vector_tools

A library for Vectors of arbitrary length, and arbitrary element types.
Makes use of operator overloads of elements to perform operations.

## Usage

A simple usage example:

    import 'package:generic_vector_tools/generic_vector_tools.dart';

    main() {
      V<double> position = new V<double>([0.0, 10.0]);
      V positions = new V([position, position + 10.0, position + 25.0]);
      V morePositions = new V([position, position + 90.0, position + 11.1]);

      V yetMorePositions = positions + morePositions;
    }

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/benmosheron/DartDev_Vector/issues
