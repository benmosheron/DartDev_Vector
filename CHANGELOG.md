# Changelog

## 0.0.1

- Initial version, created by Stagehand

## 1.0.0

- Initial publish version, basic features and unit tests.

## 1.0.1

- Added some documentation

## 1.0.2

- Added negate methods to V and M
- Added sum(), sumRecursive(), any() and every() to V

## 1.0.3

- SelfResolve
- Split unit tests into separate files
- Try and convert basic constructor input to list
- docs for M
- generic constructor for m and unit tests
- zip uses generic constructor

## 1.0.4

- V2 now extends V
- explicitly set V list sizes where relevant

## 1.0.5

- removed the type checking for V.generic, it caused issues when compiled to js

## 1.0.6

- fixed unit tests not working in checked mode

## 1.0.7

- Unit tests make use of the test package (pub run test...) rather than
a custom command.
- More flexible V2 overloads.