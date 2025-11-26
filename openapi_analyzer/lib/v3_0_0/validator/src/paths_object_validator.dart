import 'validation_exception.dart';
import 'validation_utils.dart';
import 'path_item_object_validator.dart';

/// Validator for Paths Objects according to OpenAPI 3.0.0 specification.
class PathsObjectValidator {
  /// Validates a Paths Object.
  static void validate(Map<dynamic, dynamic> data, String path) {
    _validatePathItems(data, path);
    _checkDuplicateTemplatedPaths(data, path);
  }

  static void _validatePathItems(Map<dynamic, dynamic> data, String path) {
    for (final key in data.keys) {
      final pathStr = key.toString();

      _validatePathFormat(pathStr, path);

      final pathItem = data[key];
      if (pathItem is! Map) {
        throw OpenApiValidationException(
          ValidationUtils.buildPath(path, pathStr),
          'Path item must be a Path Item Object',
          specReference: 'OpenAPI 3.0.0 - Paths Object',
        );
      }

      PathItemObjectValidator.validate(
        pathItem,
        ValidationUtils.buildPath(path, pathStr),
      );
    }
  }

  static void _validatePathFormat(String pathStr, String path) {
    if (!pathStr.startsWith('/')) {
      throw OpenApiValidationException(
        ValidationUtils.buildPath(path, pathStr),
        'Path must begin with a slash, got: $pathStr',
        specReference: 'OpenAPI 3.0.0 - Paths Object',
      );
    }
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
