import '../validation_exception.dart';
import 'structural_validator/structural_validator.dart';
import 'semantic_validator/semantic_validator.dart';

export '../validation_exception.dart';

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
/// - Transforms validated YAML into Dart object tree
/// - Creates typed representations of OpenAPI objects
/// 
/// **Stage 3: Semantic Validation (Post-parsing)**
/// - Verifies logical consistency and coherence
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
  /// Returns a parsed OpenAPI document object if validation succeeds.
  ///
  /// Throws [OpenApiValidationException] if any validation stage fails.
  /// Throws [FormatException] if YAML parsing fails.
  ///
  /// [yamlContent] - The OpenAPI specification as a YAML string.
  /// [baseDirectory] - Optional base directory for resolving external file references.
  ///
  /// Processing stages:
  /// 1. Structural Validation - ensures correct vocabulary and structure
  /// 2. Parsing - creates Dart object tree (currently returns Map)
  /// 3. Semantic Validation - ensures logical consistency
  /// 4. Schema Modeling - generates specialized models (deferred)
  static Map<dynamic, dynamic> validate(String yamlContent, {String? baseDirectory}) {
    try {
      // STAGE 1: Structural Validation (Pre-parsing)
      // Validates that the document uses correct OpenAPI vocabulary and structure
      print('Stage 1: Running Structural Validation...');
      final structurallyValidDoc = StructuralValidator.validate(yamlContent);
      print('✓ Stage 1: Structural Validation passed');

      // STAGE 2: Parsing
      // Transforms the validated YAML into Dart objects
      // NOTE: Full parsing to typed Dart objects is deferred for now
      // Currently, we use the Map directly from Stage 1
      print('Stage 2: Parsing (using Map representation)...');
      final parsedDoc = structurallyValidDoc; // TODO: Replace with OpenApiParser.parse() when ready
      print('✓ Stage 2: Parsing complete');

      // STAGE 3: Semantic Validation (Post-parsing)
      // Validates logical consistency and meaningful relationships
      print('Stage 3: Running Semantic Validation...');
      SemanticValidator.validate(parsedDoc, baseDirectory: baseDirectory);
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
      );
    }
  }

  /// Validates only the structural correctness (Stage 1).
  /// 
  /// Useful for fast syntax checking without full semantic validation.
  static Map<dynamic, dynamic> validateStructure(String yamlContent) {
    return StructuralValidator.validate(yamlContent);
  }

  /// Validates semantic correctness of an already structurally-valid document (Stage 3).
  /// 
  /// Assumes the document has already passed structural validation.
  static void validateSemantics(Map<dynamic, dynamic> document, {String? baseDirectory}) {
    SemanticValidator.validate(document, baseDirectory: baseDirectory);
  }
}

