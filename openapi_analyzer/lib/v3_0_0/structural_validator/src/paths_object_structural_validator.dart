import '../../../validation_exception.dart';
import '../../../utils/validation_utils.dart';
import 'path_item_object_structural_validator.dart';

/// Structural validator for Paths Objects (OpenAPI 3.0.0).
class PathsObjectStructuralValidator {
  /// Validates the structural correctness of a Paths Object.
  static void validate(Map<dynamic, dynamic> data, String path) {
    _validatePathItems(data, path);
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

      PathItemObjectStructuralValidator.validate(
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
}

