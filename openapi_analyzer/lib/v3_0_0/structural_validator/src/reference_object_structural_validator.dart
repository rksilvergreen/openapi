import '../../../validation_exception.dart';
import '../../../utils/validation_utils.dart';

/// Structural validator for Reference Objects (OpenAPI 3.0.0).
class ReferenceObjectStructuralValidator {
  /// Validates the structural correctness of a Reference Object.
  static void validate(Map<dynamic, dynamic> data, String path) {
    // $ref is REQUIRED
    final ref = ValidationUtils.requireString(
      ValidationUtils.requireField(data, r'$ref', path),
      ValidationUtils.buildPath(path, r'$ref'),
    );

    if (ref.isEmpty) {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, r'$ref'),
        '\$ref cannot be empty',
        specReference: 'OpenAPI 3.0.0 - Reference Object',
        severity: ValidationSeverity.critical,
      );
    }

    // In OpenAPI 3.0.0, when $ref is used, other properties are ignored
    // But we can validate that only $ref and extension fields are present
    for (final key in data.keys) {
      final keyStr = key.toString();
      if (keyStr != r'$ref' && !keyStr.startsWith('x-')) {
        // Sibling properties are technically ignored in OAS 3.0, but their presence
        // might indicate user error. We'll be lenient and not throw an error.
      }
    }
  }
}

