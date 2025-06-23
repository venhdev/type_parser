import 'dart:convert';

import 'package:test/test.dart';
import 'package:type_parser/type_parser.dart';

void main() {
  group('DynamicParsingExtension', () {
    group('asString', () {
      test('should parse int to string', () {
        expect(123.asString(), '123');
      });

      test('should parse double to string', () {
        expect(123.45.asString(), '123.45');
      });

      test('should parse bool to string', () {
        expect(true.asString(), 'true');
      });

      test('should parse list to string', () {
        expect([1, 2, 3].asString(), '[1, 2, 3]');
      });

      test('should parse map to string', () {
        expect({'a': 1, 'b': 2}.asString(), '{a: 1, b: 2}');
      });

      test('should throw FormatException for null', () {
        Object? value;
        expect(() => value.asString(), throwsA(isA<FormatException>()));
      });
    });

    group('tryString', () {
      test('should parse int to string', () {
        expect(123.tryString(), '123');
      });

      test('should parse null to null', () {
        Object? value;
        expect(value.tryString(), null);
      });
    });

    group('asInt', () {
      test('should parse string to int', () {
        expect('123'.asInt(), 123);
      });

      test('should parse double to int', () {
        expect(123.45.asInt(), 123);
      });

      test('should parse num to int', () {
        expect(123.asInt(), 123);
      });

      test('should throw FormatException for invalid string', () {
        expect(() => 'abc'.asInt(), throwsA(isA<FormatException>()));
      });

      test('should throw FormatException for null', () {
        Object? value;
        expect(() => value.asInt(), throwsA(isA<FormatException>()));
      });
    });

    group('tryInt', () {
      test('should parse string to int', () {
        expect('123'.tryInt(), 123);
      });

      test('should return null for invalid string', () {
        expect('abc'.tryInt(), null);
      });

      test('should return null for null', () {
        Object? value;
        expect(value.tryInt(), null);
      });
    });

    group('asDouble', () {
      test('should parse string to double', () {
        expect('123.45'.asDouble(), 123.45);
      });

      test('should parse int to double', () {
        expect(123.asDouble(), 123.0);
      });

      test('should throw FormatException for invalid string', () {
        expect(() => 'abc'.asDouble(), throwsA(isA<FormatException>()));
      });
    });

    group('tryDouble', () {
      test('should parse string to double', () {
        expect('123.45'.tryDouble(), 123.45);
      });

      test('should return null for invalid string', () {
        expect('abc'.tryDouble(), null);
      });
    });

    group('asBool', () {
      test('should parse string "true" to true', () {
        expect('true'.asBool(), true);
      });

      test('should parse string "false" to false', () {
        expect('false'.asBool(), false);
      });

      test('should parse int 1 to true', () {
        expect(1.asBool(), true);
      });

      test('should parse int 0 to false', () {
        expect(0.asBool(), false);
      });

      test('should throw FormatException for invalid string', () {
        expect(() => 'abc'.asBool(), throwsA(isA<FormatException>()));
      });
    });

    group('tryBool', () {
      test('should parse string "true" to true', () {
        expect('true'.tryBool(), true);
      });

      test('should return null for invalid string', () {
        expect('abc'.tryBool(), null);
      });
    });

    group('asNum', () {
      test('should parse string to num', () {
        expect('123'.asNum(), 123);
        expect('123.45'.asNum(), 123.45);
      });

      test('should parse int to num', () {
        expect(123.asNum(), 123);
      });

      test('should parse double to num', () {
        expect(123.45.asNum(), 123.45);
      });
    });

    group('tryNum', () {
      test('should parse string to num', () {
        expect('123'.tryNum(), 123);
        expect('123.45'.tryNum(), 123.45);
      });

      test('should return null for invalid string', () {
        expect('abc'.tryNum(), null);
      });
    });

    group('asMap', () {
      test('should parse JSON string to map', () {
        final map = {'key': 'value', 'number': 123};
        expect(json.encode(map).asMap(), map);
      });

      test('should cast existing map', () {
        final map = {'key': 'value', 'number': 123};
        expect(map.asMap(), map);
      });

      test('should throw FormatException for invalid string', () {
        expect(() => 'abc'.asMap(), throwsA(isA<FormatException>()));
      });

      test('should throw FormatException for null', () {
        Object? value = null;
        expect(() => value.asMap(), throwsA(isA<FormatException>()));
      });
    });

    group('tryMap', () {
      test('should parse JSON string to map', () {
        final map = {'key': 'value', 'number': 123};
        expect(json.encode(map).tryMap(), map);
      });

      test('should return null for null', () {
        Object? value;
        expect(value.tryMap(), null);
      });

      test('should return null for invalid string', () {
        expect('abc'.tryMap(), null);
      });

      test('should return null for null', () {
        Object? value = null;
        expect(value.tryMap(), null);
      });
    });

    group('asList', () {
      test('should parse JSON array string to list', () {
        final list = [1, 2, 3];
        expect(json.encode(list).asList<int>(), list);
      });

      test('should parse comma separated string to list', () {
        expect('1,2,3'.asList<String>(), ['1', '2', '3']);
      });

      test('should cast existing list', () {
        final list = [1, 2, 3];
        expect(list.asList<int>(), list);
      });

      test('should convert items using itemConverter', () {
        final list = ['1', '2', '3'];
        expect(list.asList<int>(itemConverter: (e) => (e as Object?).asInt()),
            [1, 2, 3]);
      });

      test('should throw FormatException for null', () {
        Object? value = null;
        expect(() => value.asList(), throwsA(isA<FormatException>()));
      });
    });

    group('tryList', () {
      test('should parse JSON array string to list', () {
        final list = [1, 2, 3];
        expect(json.encode(list).tryList<int>(), list);
      });

      test('should return null for null', () {
        Object? value = null;
        expect(value.tryList(), null);
      });
    });
  });
}
