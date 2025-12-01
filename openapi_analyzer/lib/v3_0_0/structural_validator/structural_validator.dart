import 'package:yaml/yaml.dart';

import '../../validation_exception.dart';
import 'src/openapi_object_structural_validator.dart';

export '../../validation_exception.dart';

/// Structural validator for OpenAPI specifications (Stage 1).
/// 
/// This validator performs pre-parsing structural checks to ensure:
/// - Correct vocabulary and structure per OpenAPI 3.0 spec
/// - Allowed keywords and field types
/// - Required fields presence
/// - No unknown/misspelled fields
/// - Proper object structure
///
/// Semantic validation (logical consistency) is performed in Stage 3.
abstract class StructuralValidator {

  /// Validates the structural correctness of an OpenAPI YAML content string.
  ///
  /// Returns the parsed YAML document as a Map if structurally valid.
  ///
  /// Throws [OpenApiValidationException] if structural validation fails.
  /// Throws [FormatException] if YAML parsing fails.
  ///
  /// This performs Stage 1 (Structural Validation) only.
  static Map<dynamic, dynamic> validate(String yamlContent) {
    try {
      // Parse YAML
      final yamlDoc = loadYaml(yamlContent);

      // Ensure root is a Map
      if (yamlDoc is! Map) {
        throw OpenApiValidationException(
          '/',
          'OpenAPI document root must be an object',
          specReference: 'OpenAPI 3.0.0 - Document Structure',
          severity: ValidationSeverity.critical,
        );
      }

      // Check for openapi field to determine version
      final rootMap = yamlDoc;
      if (!rootMap.containsKey('openapi')) {
        throw OpenApiValidationException(
          '/',
          'OpenAPI document must have an "openapi" field',
          specReference: 'OpenAPI 3.0.0 - OpenAPI Object',
          severity: ValidationSeverity.critical,
        );
      }

      final openapiVersion = rootMap['openapi']?.toString();
      if (openapiVersion == null || openapiVersion.isEmpty) {
        throw OpenApiValidationException(
          '/openapi',
          'openapi field cannot be empty',
          specReference: 'OpenAPI 3.0.0 - OpenAPI Object',
          severity: ValidationSeverity.critical,
        );
      }

      // For now, only support 3.0.0
      if (openapiVersion == '3.0.0') {
        // Validate structural correctness
        OpenApiObjectStructuralValidator.validate(rootMap, '');
      } else {
        throw OpenApiValidationException(
          '/openapi',
          'Unsupported OpenAPI version: $openapiVersion. Only 3.0.0 is currently supported',
          specReference: 'OpenAPI 3.0.0 - Versions',
          severity: ValidationSeverity.critical,
        );
      }

      return rootMap;
    } on YamlException catch (e) {
      throw FormatException('Failed to parse YAML: ${e.message}', e.span?.start.offset);
    } on OpenApiValidationException {
      // Re-throw validation exceptions
      rethrow;
    } catch (e) {
      if (e is OpenApiValidationException) {
        rethrow;
      }
      throw OpenApiValidationException('/', 'Unexpected error during structural validation: $e', specReference: 'OpenAPI 3.0.0', severity: ValidationSeverity.critical);
    }
  }
}

