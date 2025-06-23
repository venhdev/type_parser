import 'dart:convert';
import '../type_parser_base.dart';

/// Provides convenient extension methods on `Object?` for parsing dynamic values
/// into various data types, including primitives, lists, and maps.
///
/// This extension simplifies type conversion by offering both safe (`try*`) and
/// explicit (`as*`) parsing methods.
extension DynamicParsingExtension on Object? {
  /// Tries to parse the dynamic value as a [String].
  /// Returns `null` if parsing fails.
  String? tryString({String Function()? orElse}) {
    if (this == null) return orElse?.call();
    return toString();
  }

  /// Parses the dynamic value as a [String].
  /// Throws a [FormatException] if parsing fails.
  String asString() {
    if (this == null) {
      throw FormatException('Cannot parse null to String');
    }
    return toString();
  }

  /// Tries to parse the dynamic value as an [int].
  /// Returns `null` if parsing fails.
  int? tryInt({int Function()? orElse}) {
    return tryParseInt(this, orElse: orElse);
  }

  /// Parses the dynamic value as an [int].
  /// Throws a [FormatException] if parsing fails.
  int asInt() {
    return parseInt(this);
  }

  /// Tries to parse the dynamic value as a [double].
  /// Returns `null` if parsing fails.
  double? tryDouble({double Function()? orElse}) {
    return tryParseDouble(this, orElse: orElse);
  }

  /// Parses the dynamic value as a [double].
  /// Throws a [FormatException] if parsing fails.
  double asDouble() {
    return parseDouble(this);
  }

  /// Tries to parse the dynamic value as a [bool].
  /// Returns `null` if parsing fails.
  bool? tryBool({bool Function()? orElse}) {
    return tryParseBool(this, orElse: orElse);
  }

  /// Parses the dynamic value as a [bool].
  /// Throws a [FormatException] if parsing fails.
  bool asBool() {
    return parseBool(this);
  }

  /// Tries to parse the dynamic value as a [num].
  /// Returns `null` if parsing fails.
  num? tryNum({num Function()? orElse}) {
    return tryParseNum(this, orElse: orElse);
  }

  /// Parses the dynamic value as a [num].
  /// Throws a [FormatException] if parsing fails.
  num asNum() {
    return parseNum(this);
  }

  /// Tries to parse the dynamic value as a [Map<String, dynamic>].
  /// Returns `null` if parsing fails.
  Map<String, dynamic>? tryMap({Map<String, dynamic> Function()? orElse}) {
    return tryParseMap(this, orElse: orElse);
  }

  /// Parses the dynamic value as a [Map<String, dynamic>].
  /// Throws a [FormatException] if parsing fails.
  Map<String, dynamic> asMap() {
    if (this == null) {
      throw FormatException('Cannot parse null to Map<String, dynamic>');
    }
    if (this is Map<String, dynamic>) return this as Map<String, dynamic>;
    if (this is String) {
      return json.decode(this as String) as Map<String, dynamic>;
    }
    throw FormatException(
        'Cannot parse ${runtimeType} to Map<String, dynamic>');
  }

  /// Tries to parse the dynamic value as a [List<T>].
  /// Returns `null` if parsing fails.
  List<T>? tryList<T>(
      {T Function(dynamic)? itemConverter,
      bool allowStringToList = true,
      String separator = ','}) {
    if (this == null) return null;
    return tryParseList<T>(
      this,
      itemConverter: itemConverter,
      allowStringToList: allowStringToList,
      separator: separator,
    );
  }

  /// Parses the dynamic value as a [List<T>].
  /// Throws a [FormatException] if parsing fails.
  List<T> asList<T>({
    T Function(dynamic)? itemConverter,
    bool allowStringToList = true,
    String separator = ',',
  }) {
    return parseList<T>(
      this,
      itemConverter: itemConverter,
      allowStringToList: allowStringToList,
      separator: separator,
    );
  }
}
