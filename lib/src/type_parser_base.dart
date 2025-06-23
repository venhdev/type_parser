import 'dart:convert';

List<T>? tryParseList<T>(
  dynamic value, {
  List<T> Function()? orElse,
  T Function(dynamic)? itemConverter,
  bool allowStringToList = true,
  String separator = ',',
}) {
  if (value == null) return null;
  try {
    return parseList(
      value,
      itemConverter: itemConverter,
      allowStringToList: allowStringToList,
      separator: separator,
    );
  } catch (e) {
    if (orElse != null) return orElse();
    return null;
  }
}

num? tryParseNum<T>(dynamic value, {num Function()? orElse}) {
  try {
    if (value == null) {
      return null;
    } else {
      return parseNum(value, orElse: orElse);
    }
  } catch (e) {
    if (orElse != null) return orElse();
    return null;
  }
}

num parseNum<T>(dynamic value, {num Function()? orElse}) {
  try {
    if (value is num) {
      return value;
    } else if (value is String) {
      final number = num.tryParse(value);
      if (number is num) return number;
      return double.parse(value);
    } else {
      throw FormatException('Cannot parse ${value.runtimeType} to num');
    }
  } catch (e) {
    if (orElse != null) return orElse();
    rethrow;
  }
}

double? tryParseDouble<T>(dynamic value, {double Function()? orElse}) {
  try {
    if (value == null) {
      return null;
    } else {
      return parseDouble(value, orElse: orElse);
    }
  } catch (e) {
    if (orElse != null) return orElse();
    return null;
  }
}

/// Parses a dynamic [value] into a [double].
///
/// Throws a [FormatException] if the value cannot be parsed to a [double].
/// If [orElse] is provided, its result is returned instead of throwing an exception.
double parseDouble<T>(dynamic value, {double Function()? orElse}) {
  try {
    if (value is double) {
      return value;
    } else if (value is num) {
      return value.toDouble();
    } else if (value is int) {
      return value.toDouble();
    } else if (value is String) {
      final number = num.tryParse(value);
      if (number is num) return number.toDouble();
      return double.parse(value);
    } else {
      throw FormatException('Cannot parse ${value.runtimeType} to double');
    }
  } catch (e) {
    if (orElse != null) return orElse();
    rethrow;
  }
}

int? tryParseInt<T>(dynamic value, {int Function()? orElse}) {
  try {
    if (value == null) {
      return null;
    } else {
      return parseInt(value, orElse: orElse);
    }
  } catch (e) {
    if (orElse != null) return orElse();
    return null;
  }
}

/// Parses a dynamic [value] into an [int].
///
/// Throws a [FormatException] if the value cannot be parsed to an [int].
/// If [orElse] is provided, its result is returned instead of throwing an exception.
int parseInt<T>(dynamic value, {int Function()? orElse}) {
  try {
    if (value is int) {
      return value;
    } else if (value is num) {
      return value.toInt();
    } else if (value is double) {
      return value.toInt();
    } else if (value is String) {
      final number = num.tryParse(value);
      if (number is num) return number.toInt();
      return int.parse(value);
    } else {
      throw FormatException('[ERR] Cannot parse ${value.runtimeType} to int');
    }
  } catch (e) {
    if (orElse != null) return orElse();
    rethrow;
  }
}

bool? tryParseBool<T>(dynamic value, {bool Function()? orElse}) {
  try {
    if (value == null) {
      return null;
    } else {
      return parseBool(value, orElse: orElse);
    }
  } catch (e) {
    if (orElse != null) return orElse();
    return null;
  }
}

List<T> parseList<T>(
  dynamic value, {
  T Function(dynamic)? itemConverter,
  bool allowStringToList = true,
  String separator = ',',
  List<T> Function()? orElse,
}) {
  try {
    if (value == null) {
      throw FormatException('Cannot parse null to List<$T>');
    }

    // Handle Iterable types (including List)
    if (value is Iterable) {
      if (itemConverter == null) return value.toList().cast<T>();
      return value.map((e) => itemConverter(e)).toList();
    }

    // Handle String type that can be converted to List
    if (allowStringToList && value is String) {
      final trimmed = value.trim();
      // Handle JSON array string
      if (trimmed.startsWith('[') && trimmed.endsWith(']')) {
        try {
          final decoded = json.decode(trimmed) as List;
          if (itemConverter == null) return decoded.cast<T>();
          return decoded.map((e) => itemConverter(e)).toList();
        } catch (_) {
          // If JSON parsing fails, split by separator
          final items = value.split(separator).map((e) => e.trim()).toList();
          if (itemConverter == null) return items.cast<T>();
          return items.map((e) => itemConverter(e)).toList();
        }
      }
      // Split regular string by separator
      final items = value.split(separator).map((e) => e.trim()).toList();
      if (itemConverter == null) return items.cast<T>();
      return items.map((e) => itemConverter(e)).toList();
    }

    // Handle Set type
    if (value is Set) {
      if (itemConverter == null) return value.toList().cast<T>();
      return value.map((e) => itemConverter(e)).toList();
    }

    // Handle single item that should be converted to a list
    if (itemConverter != null) {
      return [itemConverter(value)];
    }

    // Try to cast single item if no parser provided
    try {
      return [value as T];
    } catch (_) {
      throw FormatException('Cannot parse $value to List<$T>');
    }
  } catch (e) {
    if (orElse != null) return orElse();
    rethrow;
  }
}

/// Parse [value] to bool
/// - If [value] is bool, return it
/// - If [value] is String, return `value.toLowerCase() == 'true'`
/// - If [value] is num, return `value == 1`
/// Tries to parse [raw] to type [T].
///
/// If [raw] is `null`, returns `null`.
/// If [raw] cannot be parsed, returns the result of [orElse] if provided, otherwise `null`.

Map<K, V>? tryParseMap<K, V>(
  dynamic value, {
  Map<K, V> Function()? orElse,
  K Function(dynamic)? keyConverter,
  V Function(dynamic)? valueConverter,
}) {
  if (value == null) return null;
  try {
    return parseMap(value,
        keyConverter: keyConverter, valueConverter: valueConverter);
  } catch (e) {
    if (orElse != null) return orElse();
    return null;
  }
}

Map<K, V> parseMap<K, V>(
  dynamic value, {
  Map<K, V> Function()? orElse,
  K Function(dynamic)? keyConverter,
  V Function(dynamic)? valueConverter,
}) {
  try {
    if (value is Map) {
      if (keyConverter == null && valueConverter == null) {
        return value.cast<K, V>();
      } else {
        return value.map((key, value) {
          final newKey = keyConverter != null ? keyConverter(key) : key;
          final newValue =
              valueConverter != null ? valueConverter(value) : value;
          return MapEntry(newKey, newValue);
        }).cast<K, V>();
      }
    } else if (value is String) {
      final trimmed = value.trim();
      if (trimmed.startsWith('{') && trimmed.endsWith('}')) {
        final decoded = json.decode(trimmed) as Map;
        if (keyConverter == null && valueConverter == null) {
          return decoded.cast<K, V>();
        } else {
          return decoded.map((key, value) {
            final newKey = keyConverter != null ? keyConverter(key) : key;
            final newValue =
                valueConverter != null ? valueConverter(value) : value;
            return MapEntry(newKey, newValue);
          }).cast<K, V>();
        }
      }
    }
    throw FormatException('Cannot parse ${value.runtimeType} to Map<K, V>');
  } catch (e) {
    if (orElse != null) return orElse();
    rethrow;
  }
}

///
/// The [parser] parameter can be used to provide a custom parsing function for type [T].
/// If [parser] is not provided, it attempts to parse based on common types:
/// - `List<T>`: Uses `tryParseList`.
/// - `int`: Uses `tryParseInt`.
/// - `double`: Uses `tryParseDouble`.
/// - `num`: Uses `tryParseNum`.
/// - `bool`: Uses `tryParseBool`.
/// - `String`: Returns `raw` as `String?`.
/// - `Map`: Returns `raw` as `Map<dynamic, dynamic>?`.
///
/// Example:
/// ```dart
/// final intValue = tryParse<int>('123'); // 123
/// final doubleValue = tryParse<double>('123.45'); // 123.45
/// final boolValue = tryParse<bool>('true'); // true
/// final listValue = tryParse<String>('[a,b,c]'); // ['a', 'b', 'c']
/// final customValue = tryParse<MyClass>(data, parser: (d) => MyClass.fromJson(d));
/// ```
T? tryParse<T>(
  dynamic raw, {
  T Function()? orElse,
  T Function(dynamic)? parser,
}) {
  try {
    if (raw == null) {
      return null;
    }

    if (parser != null) {
      return parser(raw);
    }

    if (T == List) {
      return tryParseList(raw, orElse: orElse as List<T> Function()?) as T?;
    } else if (T == int) {
      return tryParseInt(raw, orElse: orElse as int Function()?) as T?;
    } else if (T == double) {
      return tryParseDouble(raw, orElse: orElse as double Function()?) as T?;
    } else if (T == bool) {
      return tryParseBool(raw, orElse: orElse as bool Function()?) as T?;
    } else if (T == num) {
      return tryParseNum(raw, orElse: orElse as num Function()?) as T?;
    } else if (T == String) {
      return tryParseString(raw, orElse: orElse as String Function()?) as T?;
    } else if (T == Map) {
      return tryParseMap(raw,
          orElse: orElse as Map<String, dynamic> Function()?) as T?;
    }

    return raw as T?;
  } catch (e) {
    return null;
  }
}

String? tryParseString(dynamic value, {String Function()? orElse}) {
  if (value == null) return null;
  try {
    return parseString(value);
  } catch (e) {
    if (orElse != null) return orElse();
    return null;
  }
}

String parseString(dynamic value, {String Function()? orElse}) {
  try {
    if (value is String) return value;
    return value.toString();
  } catch (e) {
    if (orElse != null) return orElse();
    rethrow;
  }
}

/// Parses a dynamic [value] into a [bool].
///
/// Throws a [FormatException] if the value cannot be parsed to a [bool].
/// If [orElse] is provided, its result is returned instead of throwing an exception.
bool parseBool(dynamic value, {bool Function()? orElse}) {
  try {
    if (value is bool) {
      return value;
    } else if (value is String) {
      final lowerCaseValue = value.toLowerCase();
      if (lowerCaseValue == 'true') return true;
      if (lowerCaseValue == 'false') return false;
      throw FormatException('Cannot parse "$value" to bool');
    } else if (value is num) {
      return value == 1;
    } else {
      throw FormatException('Cannot parse ${value.runtimeType} to bool');
    }
  } catch (e) {
    if (orElse != null) return orElse();
    rethrow;
  }
}
