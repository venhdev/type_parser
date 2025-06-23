import 'package:type_parser/src/vendor/colored_logger/colored_logger.dart';

abstract class TypeParseException implements Exception {
  /// Error message
  final String message;

  /// Optional inner exception
  final Object? innerException;

  const TypeParseException(this.message, {this.innerException});

  @override
  String toString() {
    final buffer = StringBuffer('$runtimeType: $message');
    if (innerException != null) buffer.write(' | Inner: $innerException');
    return buffer.toString().red.toString();
  }
}

class UnsupportedError extends TypeParseException {
  UnsupportedError({
    required String type,
    required String toType,
    super.innerException,
  }) : super('Cannot parse $type to $toType');
}
