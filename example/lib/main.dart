import 'package:type_parser/type_parser.dart';

void main() {
  // --- Basic Type Parsing ---
  print('--- Basic Type Parsing ---');
  dynamic intValue = '123';
  dynamic doubleValue = '123.45';
  dynamic boolValue = 'true';
  dynamic stringValue = 123;

  print('Parsing int: ${(intValue as Object?).tryInt()}'); // 123
  print('Parsing double: ${(doubleValue as Object?).tryDouble()}'); // 123.45
  print('Parsing bool: ${(boolValue as Object?).tryBool()}'); // true
  print('Parsing string: ${(stringValue as Object?).tryString()}'); // "123"

  // --- Parsing with orElse (safe parsing) ---
  print('\n--- Parsing with orElse ---');
  dynamic invalidValue = 'abc';
  print(
      'Parsing invalid int with orElse: ${(invalidValue as Object?).tryInt(orElse: () => 0)}'); // 0
  print(
      'Parsing invalid double with orElse: ${(invalidValue as Object?).tryDouble(orElse: () => 0.0)}'); // 0.0
  print(
      'Parsing invalid bool with orElse: ${(invalidValue as Object?).tryBool(orElse: () => false)}'); // false

  // --- Explicit Parsing (throws exception) ---
  print('\n--- Explicit Parsing ---');
  try {
    ('abc' as Object?).asInt();
  } catch (e) {
    print('Caught exception for asInt: $e'); // FormatException
  }

  // --- List Parsing ---
  print('\n--- List Parsing ---');
  dynamic listString = '[1, 2, 3]';
  dynamic listDynamic = [1, '2', 3.0];
  dynamic commaSeparatedString = 'apple,banana,orange';

  print(
      'Parsing list from JSON string: ${tryParseList<int>(listString)}'); // [1, 2, 3]
  print(
      'Parsing list with mixed types: ${tryParseList<String>(listDynamic, itemConverter: (e) => e.toString())}'); // ['1', '2', '3.0']
  print(
      'Parsing list from comma-separated string: ${tryParseList<String>(commaSeparatedString)}'); // ['apple', 'banana', 'orange']

  // --- Map Parsing ---
  print('\n--- Map Parsing ---');
  dynamic mapString = '{"name": "John", "age": 30}';
  dynamic mapDynamic = {'city': 'New York', 'zip': 10001};

  print(
      'Parsing map from JSON string: ${tryParseMap(mapString)}'); // {name: John, age: 30}
  print(
      'Parsing map with mixed values: ${tryParseMap(mapDynamic, valueConverter: (v) => v.toString())}'); // {city: New York, zip: 10001}

  // --- Complex Scenarios ---
  print('\n--- Complex Scenarios ---');
  dynamic complexData = {
    'id': 1,
    'name': 'Product A',
    'price': 99.99,
    'available': true,
    'tags': ['electronics', 'gadget'],
    'details': {'weight': '1kg', 'color': 'black'},
    'null_value': null,
  };

  print('ID: ${(complexData['id'] as Object?).tryInt()}');
  print('Name: ${(complexData['name'] as Object?).tryString()}');
  print('Price: ${(complexData['price'] as Object?).tryDouble()}');
  print('Available: ${(complexData['available'] as Object?).tryBool()}');
  print('Tags: ${tryParseList<String>(complexData['tags'])}');
  print('Details: ${tryParseMap(complexData['details'])}');
  print(
      'Null Value with orElse: ${(complexData['null_value'] as Object?).tryString(orElse: () => 'N/A')}');

  // --- Using top-level functions ---
  print('\n--- Using top-level functions ---');
  print('Top-level parseInt: ${parseInt('456')}');
  print('Top-level tryParseDouble: ${tryParseDouble('789.0')}');
  print('Top-level parseBool: ${parseBool('false')}');
  print('Top-level tryParseList: ${tryParseList<int>('[10, 20, 30]')}');
  print('Top-level tryParseMap: ${tryParseMap('{"a": 1, "b": 2}')}');
}
