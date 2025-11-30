import '../../validation_exception.dart';
import '../parser/src/openapi_document.dart';
import 'src/semantic_paths_validator.dart';
import 'src/semantic_schema_validator.dart';
import 'src/reference_resolver.dart';

export '../../validation_exception.dart';

/// Semantic validator for OpenAPI specifications (Stage 3).
///
/// This validator performs post-parsing semantic checks to ensure:
/// - Logical consistency and coherence
/// - Reference resolution and existence
/// - Composition semantics (allOf, oneOf, anyOf)
/// - Discriminator logic and property existence
/// - Cross-schema consistency
/// - Meaningful modeling practices
///
/// Structural validation (vocabulary and structure) is performed in Stage 1.
/// Parsing (Stage 2) transforms the document into typed Dart objects.
abstract class SemanticValidator {
  /// Validates the semantic correctness of a parsed OpenAPI document.
  ///
  /// This performs Stage 3 (Semantic Validation) only.
  /// Expects the document to already be:
  /// - Structurally valid (Stage 1)
  /// - Parsed into an OpenApiDocument (Stage 2)
  ///
  /// [document] is the parsed OpenApiDocument from Stage 2.
  ///
  /// Throws [OpenApiValidationException] if semantic validation fails.
  static void validate(OpenApiDocument document) {
    try {
      // Validate semantic rules using the typed OpenApiDocument
      _validateSemanticRules(document);
    } catch (e) {
      if (e is OpenApiValidationException) {
        rethrow;
      }
      throw OpenApiValidationException(
        '/',
        'Unexpected error during semantic validation: $e',
        specReference: 'OpenAPI 3.0.0',
      );
    }
  }

  /// Validates semantic rules across the parsed document.
  ///
  /// This method orchestrates all semantic validation checks in the following order:
  ///
  /// 1. **Reference Validation**: Ensures all $ref references point to existing objects
  ///    and detects circular references that would cause infinite loops.
  ///
  /// 2. **Paths Validation**: Checks for duplicate templated paths that would conflict
  ///    at runtime (e.g., `/users/{id}` and `/users/{userId}`).
  ///
  /// 3. **Schema Validation**: Validates logical consistency of schema definitions:
  ///    - Constraint coherence (min ≤ max)
  ///    - Composition semantics (allOf type conflicts)
  ///    - Default vs enum compatibility
  ///    - Discriminator property existence
  ///
  /// [document] The fully parsed OpenAPI document with typed objects.
  ///
  /// Throws [OpenApiValidationException] if any semantic rule is violated.
  static void _validateSemanticRules(OpenApiDocument document) {
    // Step 1: Validate reference resolution and existence
    // This must run first to ensure all references are valid before other validators
    // attempt to resolve them. Also detects circular references.
    final resolver = ReferenceResolver(document);
    resolver.validateAllSchemaReferences();

    // Step 2: Validate paths semantic rules
    // Checks for duplicate templated paths that would be ambiguous at runtime.
    // Example: /users/{id} and /users/{userId} are considered duplicates.
    SemanticPathsValidator.validate(document.paths);

    // Step 3: Validate schema semantic rules
    // Validates logical consistency of all schema definitions in components.
    // This includes composition semantics, constraint logic, and more.
    if (document.components?.schemas != null) {
      final schemaValidator = SemanticSchemaValidator(document);
      for (final entry in document.components!.schemas!.entries) {
        final schemaName = entry.key;
        final schemaRef = entry.value;
        schemaValidator.validate(schemaRef, '/components/schemas/$schemaName');
      }
    }

    // TODO: Future semantic validations:
    // - Validate parameter references in paths (check all path params are defined)
    // - Validate response references in operations (ensure refs exist)
    // - Validate request body references
    // - Cross-schema consistency checks (e.g., discriminator mapping targets)
  }
}
