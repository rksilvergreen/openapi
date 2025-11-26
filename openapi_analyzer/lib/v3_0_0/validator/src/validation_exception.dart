/// Exception thrown when OpenAPI validation fails.
class OpenApiValidationException implements Exception {
  /// The JSON-like path to the field that failed validation (e.g., "/info/title").
  final String path;

  /// Human-readable error message describing the validation failure.
  final String message;

  /// Reference to the OpenAPI 3.0.0 specification section that was violated.
  final String? specReference;

  OpenApiValidationException(
    this.path,
    this.message, {
    this.specReference,
  });

  @override
  String toString() {
    final buffer = StringBuffer('Validation error at $path: $message');
    if (specReference != null) {
      buffer.write(' (See: $specReference)');
    }
    return buffer.toString();
  }
}

