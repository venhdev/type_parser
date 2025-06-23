# type_parser

A powerful and flexible Dart package for parsing and converting dynamic values to various types, including primitives, lists, and maps. It provides both safe (`tryParse`) and explicit (`parse`) methods for robust type handling.

## Features

- **Safe Parsing**: `tryParse` methods return `null` on failure, preventing runtime errors.
- **Explicit Parsing**: `parse` methods throw `FormatException` on failure, allowing for explicit error handling.
- **Extension Methods**: Convenient extension methods on `dynamic` for easy type conversion (e.g., `myDynamic.asString()`, `myDynamic.tryInt()`).
- **List and Map Parsing**: Robust handling for converting dynamic values to lists and maps, including JSON string parsing.

## Getting started

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  type_parser: ^1.0.0
```

Then run `dart pub get`.

## Usage

### Basic Type Conversion

```dart
import 'package:type_parser/type_parser.dart';

void main() {
  dynamic value = '123';

  // Using asType methods (throws FormatException on failure)
  int intValue = value.asInt(); // 123
  print('asInt: $intValue');

  dynamic anotherValue = 'true';
  bool boolValue = anotherValue.asBool(); // true
  print('asBool: $boolValue');

  dynamic numValue = '3.14';
  double doubleValue = numValue.asDouble(); // 3.14
  print('asDouble: $doubleValue');

  // Using tryType methods (returns null on failure)
  dynamic invalidValue = 'abc';
  int? tryIntValue = invalidValue.tryInt(); // null
  print('tryInt: $tryIntValue');

  dynamic validValue = '456';
  int? tryValidIntValue = validValue.tryInt(); // 456
  print('tryInt (valid): $tryValidIntValue');
}
```

### List and Map Conversion

```dart
import 'package:type_parser/type_parser.dart';

void main() {
  dynamic jsonString = '[{"id": 1, "name": "Alice"}, {"id": 2, "name": "Bob"}]';
  List<Map<String, dynamic>> users = jsonString.asList(
    itemConverter: (item) => item.asMap(),
  ); // [{'id': 1, 'name': 'Alice'}, {'id': 2, 'name': 'Bob'}]
  print('Users: $users');

  dynamic csvString = 'apple,banana,orange';
  List<String> fruits = csvString.asList(); // ['apple', 'banana', 'orange']
  print('Fruits: $fruits');

  dynamic mapString = '{"key": "value", "number": 123}';
  Map<String, dynamic> data = mapString.asMap(); // {'key': 'value', 'number': 123}
  print('Data: $data');
}
```

## Additional information

Feel free to contribute, report issues, or suggest features on the [GitHub repository](https://github.com/venhdev/type_parser).
