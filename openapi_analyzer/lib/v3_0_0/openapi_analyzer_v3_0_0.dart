import 'dart:io';
import 'package:openapi_analyzer/validation_exception.dart';
import 'openapi_graph.dart';

/// OpenAPI 3.0.0 Validator - Entry point for validating OpenAPI 3.0.0 documents.
/// 
/// This validator processes OpenAPI documents through a three-stage pipeline:
/// - Stage A: Structural Validation
/// - Stage B: Create Child Nodes (build graph)
/// - Stage C: Create Content (semantic analysis)
/// 
/// The result is an OpenApiGraph containing the complete analyzed document.
class OpenApiValidatorV3_0_0 {
  /// Validates an OpenAPI 3.0.0 document and returns the analyzed graph.
  /// 
  /// Parameters:
  /// - [file]: The OpenAPI YAML file to validate
  /// - [strictness]: Validation strictness level (strict, moderate, permissive)
  /// 
  /// Returns an [OpenApiGraph] containing the validated and analyzed document.
  /// 
  /// Throws [ValidationFailedException] if validation fails according to the strictness level.
  static OpenApiGraph validate(
    File file, {
    ValidationStrictness strictness = ValidationStrictness.moderate,
  }) {
    final graph = OpenApiGraph(file);
    graph.create(strictness: strictness);
    return graph;
  }

  /// Validates an OpenAPI 3.0.0 document from a file path.
  /// 
  /// Convenience method that creates a File object from the path.
  static OpenApiGraph validateFromPath(
    String filePath, {
    ValidationStrictness strictness = ValidationStrictness.moderate,
  }) {
    return validate(File(filePath), strictness: strictness);
  }
}

