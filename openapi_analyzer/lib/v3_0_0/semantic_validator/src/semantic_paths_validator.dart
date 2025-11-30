import '../../../validation_exception.dart';
import '../../parser/src/paths.dart';

/// Semantic validator for Paths Objects (OpenAPI 3.0.0).
///
/// Validates logical consistency and runtime behavior of path definitions.
/// Unlike structural validation (which checks syntax), this validates that
/// paths won't conflict or cause ambiguity at runtime.
class SemanticPathsValidator {
  /// Validates semantic correctness of a Paths Object.
  ///
  /// Currently checks:
  /// - Duplicate templated paths (e.g., `/users/{id}` vs `/users/{userId}`)
  ///
  /// Future validations could include:
  /// - Path parameter consistency (all {params} in path are defined)
  /// - Parameter naming conflicts
  /// - HTTP method coverage
  ///
  /// [paths] The Paths object containing all API path definitions.
  ///
  /// Throws [OpenApiValidationException] if duplicate templated paths are found.
  static void validate(Paths paths) {
    _checkDuplicateTemplatedPaths(paths);

    // Additional semantic path validations would go here
    // e.g., checking path parameter consistency, etc.
  }

  /// Checks for duplicate templated paths that would be ambiguous at runtime.
  ///
  /// According to OpenAPI spec, paths that differ only in their template
  /// parameter names are considered duplicates because they resolve to the
  /// same pattern at runtime.
  ///
  /// Example duplicates:
  /// - `/users/{id}` and `/users/{userId}` → Both match `/users/123`
  /// - `/items/{itemId}/details` and `/items/{id}/details` → Conflict
  ///
  /// [paths] The Paths object to check.
  ///
  /// Throws [OpenApiValidationException] when duplicate patterns are detected.
  static void _checkDuplicateTemplatedPaths(Paths paths) {
    final pathPatterns = <String, String>{};
    for (final key in paths.paths.keys) {
      final pathStr = key;
      final pattern = _normalizePathForDuplicateCheck(pathStr);
      if (pathPatterns.containsKey(pattern) && pathPatterns[pattern] != pathStr) {
        throw OpenApiValidationException(
          '/paths/$pathStr',
          'Duplicate templated path: $pathStr conflicts with ${pathPatterns[pattern]}',
          specReference: 'OpenAPI 3.0.0 - Paths Object',
        );
      }
      pathPatterns[pattern] = pathStr;
    }
  }

  /// Normalizes a path for duplicate checking by replacing all template
  /// parameters with a common placeholder.
  ///
  /// This allows detection of paths that differ only in parameter names:
  /// - `/users/{id}` → `/users/{param}`
  /// - `/users/{userId}` → `/users/{param}` (duplicate!)
  ///
  /// [pathStr] The original path string with template parameters.
  /// Returns the normalized path with all templates as `{param}`.
  static String _normalizePathForDuplicateCheck(String pathStr) {
    return pathStr.replaceAll(RegExp(r'\{[^}]+\}'), '{param}');
  }
}
