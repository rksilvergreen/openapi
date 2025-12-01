import '../../../validation_exception.dart';
import '../../parser/src/openapi_document.dart';
import '../../parser/src/schema_object.dart';
import '../../parser/src/referenceable.dart';
import '../../parser/src/response.dart';
import '../../parser/src/parameter.dart';
import '../../parser/src/request_body.dart';
import '../../parser/src/header.dart';
import '../semantic_validator.dart';

/// Resolves OpenAPI $ref pointers to their actual objects within a document.
///
/// Handles JSON Pointer resolution (RFC 6901) for internal references starting
/// with `#/`. External references (URLs) are not yet supported.
///
/// Features:
/// - Resolves schemas, responses, parameters, request bodies, and headers
/// - Detects circular references to prevent infinite loops
/// - Follows nested references (a ref to a ref to a schema)
/// - Validates reference existence during resolution
///
/// Example usage:
/// ```dart
/// final resolver = ReferenceResolver(document);
/// final schema = resolver.resolveSchema('#/components/schemas/User');
/// ```
class ReferenceResolver {
  /// The complete OpenAPI document being analyzed.
  final OpenApiDocument document;

  /// Tracks visited references to detect circular dependencies.
  /// Reset for each top-level validation to allow the same schema
  /// to be referenced from multiple places without false positives.
  final Set<String> _visitedRefs = {};

  /// Creates a new reference resolver.
  ///
  /// [document] The complete OpenAPI document containing all definitions
  /// and components that can be referenced.
  ReferenceResolver(this.document);

  /// Resolves a schema reference string to the actual SchemaObject.
  ///
  /// Follows the JSON Pointer format (RFC 6901) for internal references.
  /// Currently supports only `#/components/schemas/{name}` format.
  ///
  /// [ref] The reference string, e.g., `#/components/schemas/User`
  /// [detectCircular] If true, tracks visited refs to detect cycles.
  ///   Set to false if you need to resolve the same schema multiple times
  ///   in different contexts.
  ///
  /// Returns the resolved SchemaObject, or null if:
  /// - The reference format is invalid
  /// - The reference points to a non-existent schema
  /// - The reference is external (not yet supported)
  ///
  /// Throws [OpenApiValidationException] if a circular reference is detected.
  ///
  /// Example:
  /// ```dart
  /// final user = resolver.resolveSchema('#/components/schemas/User');
  /// ```
  SchemaObject? resolveSchema(String ref, {bool detectCircular = true}) {
    if (detectCircular) {
      if (_visitedRefs.contains(ref)) {
        throw OpenApiValidationException(
          ref,
          'Circular reference detected: $ref',
          specReference: 'OpenAPI 3.0.0 - Reference Object',
          severity: ValidationSeverity.critical,
        );
      }
      _visitedRefs.add(ref);
    }

    // Parse the reference
    if (!ref.startsWith('#/')) {
      // External references not yet supported
      return null;
    }

    final parts = ref.substring(2).split('/');

    // Expected format: components/schemas/SchemaName
    if (parts.length != 3) {
      return null;
    }

    if (parts[0] != 'components' || parts[1] != 'schemas') {
      return null;
    }

    final schemaName = parts[2];
    final schemaRef = document.components?.schemas?[schemaName];

    if (schemaRef == null) {
      return null;
    }

    if (schemaRef.isReference()) {
      // Follow nested reference
      return resolveSchema(schemaRef.asReference()!, detectCircular: detectCircular);
    }

    return schemaRef.asValue();
  }

  /// Resolves a Referenceable<SchemaObject> to the actual SchemaObject.
  ///
  /// This is a convenience wrapper that handles both direct values and
  /// references within a Referenceable container.
  ///
  /// [schemaRef] The Referenceable container that may hold a reference or value.
  /// [path] JSON Pointer path for error reporting if resolution fails.
  ///
  /// Returns the resolved SchemaObject (either the direct value or the
  /// referenced schema).
  ///
  /// Throws [OpenApiValidationException] if the reference doesn't exist.
  SchemaObject? resolveSchemaRef(Referenceable<SchemaObject> schemaRef, String path) {
    if (schemaRef.isReference()) {
      final ref = schemaRef.asReference()!;
      final resolved = resolveSchema(ref);
      if (resolved == null) {
        throw OpenApiValidationException(
          path,
          'Reference "$ref" not found in document',
          specReference: 'OpenAPI 3.0.0 - Reference Object',
          severity: ValidationSeverity.critical,
        );
      }
      return resolved;
    }
    return schemaRef.asValue();
  }

  /// Validates that all schema references in the document are resolvable.
  ///
  /// This performs a comprehensive check of all schemas in the Components
  /// section, ensuring:
  /// 1. All $ref pointers point to existing schemas
  /// 2. No circular references exist that would cause infinite loops
  /// 3. All nested references (in properties, items, composition) are valid
  ///
  /// This should be called early in semantic validation to catch broken
  /// references before other validators attempt to use them.
  ///
  /// [context] Optional validation context for collecting exceptions.
  ///
  /// Throws [OpenApiValidationException] if any reference is invalid or circular.
  void validateAllSchemaReferences([ValidationContext? context]) {
    if (document.components?.schemas == null) return;

    for (final entry in document.components!.schemas!.entries) {
      final schemaName = entry.key;
      final schemaRef = entry.value;
      _validateSchemaReferences(schemaRef, '/components/schemas/$schemaName', context);
    }
  }

  /// Recursively validates all references within a schema or reference.
  ///
  /// This internal method traverses the entire schema tree, checking every
  /// nested reference in:
  /// - properties (object schemas)
  /// - items (array schemas)
  /// - additionalProperties (object schemas)
  /// - allOf/oneOf/anyOf/not (composition schemas)
  ///
  /// [schemaRef] The schema or reference to validate.
  /// [path] JSON Pointer path for error reporting.
  /// [context] Optional validation context for collecting exceptions.
  ///
  /// Throws [OpenApiValidationException] for invalid or circular references.
  void _validateSchemaReferences(Referenceable<SchemaObject> schemaRef, String path, [ValidationContext? context]) {
    if (schemaRef.isReference()) {
      final ref = schemaRef.asReference()!;
      _visitedRefs.clear(); // Reset for each top-level validation
      final resolved = resolveSchema(ref);
      if (resolved == null) {
        throw OpenApiValidationException(
          path,
          'Reference "$ref" not found in document',
          specReference: 'OpenAPI 3.0.0 - Reference Object',
          severity: ValidationSeverity.critical,
        );
      }
      // Continue validating the resolved schema
      _validateSchemaReferences(Referenceable.value(resolved), path, context);
      return;
    }

    final schema = schemaRef.asValue();
    if (schema == null) return;

    // Validate nested references
    if (schema.properties != null) {
      for (final entry in schema.properties!.entries) {
        _validateSchemaReferences(entry.value, '$path/properties/${entry.key}', context);
      }
    }

    if (schema.items != null) {
      _validateSchemaReferences(schema.items!, '$path/items', context);
    }

    if (schema.additionalProperties is Referenceable<SchemaObject>) {
      _validateSchemaReferences(
        schema.additionalProperties as Referenceable<SchemaObject>,
        '$path/additionalProperties',
        context,
      );
    }

    // Validate composition references
    if (schema.allOf != null) {
      for (var i = 0; i < schema.allOf!.length; i++) {
        _validateSchemaReferences(schema.allOf![i], '$path/allOf[$i]', context);
      }
    }

    if (schema.oneOf != null) {
      for (var i = 0; i < schema.oneOf!.length; i++) {
        _validateSchemaReferences(schema.oneOf![i], '$path/oneOf[$i]', context);
      }
    }

    if (schema.anyOf != null) {
      for (var i = 0; i < schema.anyOf!.length; i++) {
        _validateSchemaReferences(schema.anyOf![i], '$path/anyOf[$i]', context);
      }
    }

    if (schema.not != null) {
      _validateSchemaReferences(schema.not!, '$path/not', context);
    }
  }

  /// Resolves a response reference to the actual Response object.
  ///
  /// [ref] The reference string, e.g., `#/components/responses/NotFound`
  ///
  /// Returns the resolved Response, or null if the reference is invalid
  /// or doesn't exist.
  Response? resolveResponse(String ref) {
    if (!ref.startsWith('#/')) return null;

    final parts = ref.substring(2).split('/');
    if (parts.length != 3 || parts[0] != 'components' || parts[1] != 'responses') {
      return null;
    }

    final responseName = parts[2];
    final responseRef = document.components?.responses?[responseName];

    if (responseRef == null) return null;
    if (responseRef.isReference()) {
      return resolveResponse(responseRef.asReference()!);
    }
    return responseRef.asValue();
  }

  /// Resolves a parameter reference to the actual Parameter object.
  ///
  /// [ref] The reference string, e.g., `#/components/parameters/PageSize`
  ///
  /// Returns the resolved Parameter, or null if the reference is invalid
  /// or doesn't exist.
  Parameter? resolveParameter(String ref) {
    if (!ref.startsWith('#/')) return null;

    final parts = ref.substring(2).split('/');
    if (parts.length != 3 || parts[0] != 'components' || parts[1] != 'parameters') {
      return null;
    }

    final paramName = parts[2];
    final paramRef = document.components?.parameters?[paramName];

    if (paramRef == null) return null;
    if (paramRef.isReference()) {
      return resolveParameter(paramRef.asReference()!);
    }
    return paramRef.asValue();
  }

  /// Resolves a request body reference to the actual RequestBody object.
  ///
  /// [ref] The reference string, e.g., `#/components/requestBodies/CreateUser`
  ///
  /// Returns the resolved RequestBody, or null if the reference is invalid
  /// or doesn't exist.
  RequestBody? resolveRequestBody(String ref) {
    if (!ref.startsWith('#/')) return null;

    final parts = ref.substring(2).split('/');
    if (parts.length != 3 || parts[0] != 'components' || parts[1] != 'requestBodies') {
      return null;
    }

    final requestBodyName = parts[2];
    final requestBodyRef = document.components?.requestBodies?[requestBodyName];

    if (requestBodyRef == null) return null;
    if (requestBodyRef.isReference()) {
      return resolveRequestBody(requestBodyRef.asReference()!);
    }
    return requestBodyRef.asValue();
  }

  /// Resolves a header reference to the actual Header object.
  ///
  /// [ref] The reference string, e.g., `#/components/headers/X-Rate-Limit`
  ///
  /// Returns the resolved Header, or null if the reference is invalid
  /// or doesn't exist.
  Header? resolveHeader(String ref) {
    if (!ref.startsWith('#/')) return null;

    final parts = ref.substring(2).split('/');
    if (parts.length != 3 || parts[0] != 'components' || parts[1] != 'headers') {
      return null;
    }

    final headerName = parts[2];
    final headerRef = document.components?.headers?[headerName];

    if (headerRef == null) return null;
    if (headerRef.isReference()) {
      return resolveHeader(headerRef.asReference()!);
    }
    return headerRef.asValue();
  }
}
