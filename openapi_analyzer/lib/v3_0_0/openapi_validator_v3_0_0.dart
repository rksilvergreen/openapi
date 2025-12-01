import '../validation_exception.dart';
import 'structural_validator/structural_validator.dart';
import 'parser/src/openapi_document.dart';
import 'semantic_validator/semantic_validator.dart';

export '../validation_exception.dart';
export 'parser/src/openapi_document.dart';

/// Main validator for OpenAPI 3.0.0 specifications.
/// 
/// Implements a 4-stage processing pipeline:
/// 
/// **Stage 1: Structural Validation (Pre-parsing)**
/// - Verifies document structure and vocabulary
/// - Checks field types and allowed keywords
/// - Ensures spec-compliance at the syntax level
/// 
/// **Stage 2: Parsing**
/// - Transforms validated YAML into typed Dart object tree
/// - Creates typed representations of OpenAPI objects (OpenApiDocument)
/// 
/// **Stage 3: Semantic Validation (Post-parsing)**
/// - Verifies logical consistency and coherence using typed objects
/// - Validates references and composition semantics
/// - Checks discriminator logic and cross-schema consistency
/// 
/// **Stage 4: Schema Modeling (Deferred)**
/// - Generates specialized schema models for code generation
/// - Creates operation and parameter models
/// - (Not yet implemented)
abstract class OpenApiValidatorV3_0_0 {

  /// Validates an OpenAPI 3.0.0 specification through all stages.
  ///
  /// Returns a parsed OpenApiDocument object if validation succeeds.
  ///
  /// Throws [OpenApiValidationException] if any validation stage fails.
  /// Throws [FormatException] if YAML parsing fails.
  ///
  /// [yamlContent] - The OpenAPI specification as a YAML string.
  ///
  /// Processing stages:
  /// 1. Structural Validation - ensures correct vocabulary and structure
  /// 2. Parsing - creates typed Dart object tree (OpenApiDocument)
  /// 3. Semantic Validation - ensures logical consistency using typed objects
  /// 4. Schema Modeling - generates specialized models (deferred)
  static OpenApiDocument validate(String yamlContent) {
    try {
      // STAGE 1: Structural Validation (Pre-parsing)
      // Validates that the document uses correct OpenAPI vocabulary and structure
      print('Stage 1: Running Structural Validation...');
      final structurallyValidDoc = StructuralValidator.validate(yamlContent);
      print('✓ Stage 1: Structural Validation passed');

      // STAGE 2: Parsing
      // Transforms the validated YAML Map into typed Dart objects
      print('Stage 2: Parsing to OpenApiDocument...');
      final parsedDoc = _parseFromMap(structurallyValidDoc);
      print('✓ Stage 2: Parsing complete');

      // STAGE 3: Semantic Validation (Post-parsing)
      // Validates logical consistency using the typed OpenApiDocument
      print('Stage 3: Running Semantic Validation...');
      SemanticValidator.validate(parsedDoc);
      print('✓ Stage 3: Semantic Validation passed');

      // STAGE 4: Schema Modeling (Deferred)
      // Would generate specialized schema models for code generation
      // print('Stage 4: Schema Modeling (deferred)...');
      // final models = SchemaModeler.model(parsedDoc);
      // print('✓ Stage 4: Schema Modeling complete');

      print('✓ All validation stages completed successfully');
      return parsedDoc;

    } on OpenApiValidationException {
      // Re-throw validation exceptions with their original context
      rethrow;
    } on FormatException {
      // Re-throw YAML parsing errors
      rethrow;
    } catch (e) {
      // Wrap unexpected errors
      throw OpenApiValidationException(
        '/',
        'Unexpected error during validation: $e',
        specReference: 'OpenAPI 3.0.0',
        severity: ValidationSeverity.critical,
      );
    }
  }

  /// Validates only the structural correctness (Stage 1).
  /// 
  /// Useful for fast syntax checking without full semantic validation.
  /// Returns the structurally valid Map (not yet parsed).
  static Map<dynamic, dynamic> validateStructure(String yamlContent) {
    return StructuralValidator.validate(yamlContent);
  }

  /// Validates semantic correctness of an already parsed document (Stage 3).
  /// 
  /// Assumes the document has already passed:
  /// - Stage 1: Structural validation
  /// - Stage 2: Parsing to OpenApiDocument
  static void validateSemantics(OpenApiDocument document) {
    SemanticValidator.validate(document);
  }

  /// Internal helper to parse from an already-validated Map.
  /// Used in Stage 2 of the pipeline.
  static OpenApiDocument _parseFromMap(Map<dynamic, dynamic> yamlDoc) {
    // Convert YAML to JSON-compatible Map
    final jsonMap = _yamlToJson(yamlDoc);
    // Parse using generated fromJson
    return OpenApiDocument.fromJson(jsonMap);
  }

  /// Converts a YAML Map to a JSON-compatible Map.
  static Map<String, dynamic> _yamlToJson(Map<dynamic, dynamic> yaml) {
    final result = <String, dynamic>{};
    for (final entry in yaml.entries) {
      final key = entry.key.toString();
      result[key] = _convertValue(entry.value);
    }
    return result;
  }

  /// Recursively converts YAML values to JSON-compatible values.
  static dynamic _convertValue(dynamic value) {
    if (value == null) return null;
    if (value is Map) {
      final result = <String, dynamic>{};
      for (final entry in value.entries) {
        result[entry.key.toString()] = _convertValue(entry.value);
      }
      return result;
    }
    if (value is List) {
      return value.map((item) => _convertValue(item)).toList();
    }
    // For YAML scalars and primitives
    return value;
  }
}

