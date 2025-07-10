import '../vendor/colored_logger/colored_logger.dart';

class UnsupportedException extends FormatException {
  /// Error message
  final String message;

  /// Optional inner exception
  final Object? innerException;

  const UnsupportedException(this.message, {this.innerException});

  @override
  String toString() {
    final buffer = StringBuffer('$runtimeType: $message');
    if (innerException != null) buffer.write(' | Inner: $innerException');
    return buffer.toString().red.toString();
  }
}
