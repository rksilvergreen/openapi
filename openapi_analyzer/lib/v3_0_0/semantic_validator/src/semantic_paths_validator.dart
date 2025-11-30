import '../../../validation_exception.dart';
import '../../../utils/validation_utils.dart';

/// Semantic validator for Paths Objects (OpenAPI 3.0.0).
/// Validates logical consistency for path definitions.
class SemanticPathsValidator {
  /// Validates semantic correctness of a Paths Object.
  static void validate(Map<dynamic, dynamic> data, String path) {
    _checkDuplicateTemplatedPaths(data, path);

    // Additional semantic path validations would go here
    // e.g., checking path parameter consistency, etc.
  }

  static void _checkDuplicateTemplatedPaths(Map<dynamic, dynamic> data, String path) {
    final pathPatterns = <String, String>{};
    for (final key in data.keys) {
      final pathStr = key.toString();
      final pattern = _normalizePathForDuplicateCheck(pathStr);
      if (pathPatterns.containsKey(pattern) && pathPatterns[pattern] != pathStr) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, pathStr),
          'Duplicate templated path: $pathStr conflicts with ${pathPatterns[pattern]}',
          specReference: 'OpenAPI 3.0.0 - Paths Object',
        );
      }
      pathPatterns[pattern] = pathStr;
    }
  }

  static String _normalizePathForDuplicateCheck(String pathStr) {
    return pathStr.replaceAll(RegExp(r'\{[^}]+\}'), '{param}');
  }
}
