/// Severity level of a validation issue.
///
/// - [critical]: Schema represents an empty set (no valid instances possible).
///   Example: `{type: string, minLength: 10, maxLength: 5}` - impossible to satisfy.
///
/// - [moderate]: Schema allows only trivial instances (empty array or empty object).
///   Example: Array schema with incompatible items where minItems is not set,
///   allowing empty arrays as the only valid instance.
///
/// - [low]: Not recommended schema patterns that might cause confusing code generation
///   or indicate poor API design, but don't make the schema technically invalid.
enum ValidationSeverity { critical, moderate, low }

/// Strictness level for validation.
///
/// Controls which severity levels cause validation to fail:
///
/// - [strict]: All severities (critical, moderate, low) cause validation to fail.
///   This is the most rigorous validation mode.
///
/// - [moderate]: Only critical and moderate severities fail validation.
///   Low severity issues are printed as warnings but don't stop validation.
///
/// - [permissive]: Only critical severity issues fail validation.
///   Moderate and low severity issues are printed as warnings.
enum ValidationStrictness { strict, moderate, permissive }

/// Exception thrown when OpenAPI validation fails.
class OpenApiValidationException implements Exception {
  /// The JSON-like path to the field that failed validation (e.g., "/info/title").
  final String path;

  /// Human-readable error message describing the validation failure.
  final String message;

  /// Reference to the OpenAPI 3.0.0 specification section that was violated.
  final String? specReference;

  /// Severity level of this validation issue.
  final ValidationSeverity severity;

  OpenApiValidationException(this.path, this.message, {this.specReference, required this.severity});

  @override
  String toString() {
    final severityLabel = severity == ValidationSeverity.critical
        ? 'error'
        : severity == ValidationSeverity.moderate
        ? 'warning (moderate)'
        : 'warning (low)';
    final buffer = StringBuffer('Validation $severityLabel at $path: $message');
    if (specReference != null) {
      buffer.write(' (See: $specReference)');
    }
    return buffer.toString();
  }
}
