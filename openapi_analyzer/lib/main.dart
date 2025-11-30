/// OpenAPI Analyzer - Main library export
/// 
/// This library provides a 4-stage validation and parsing pipeline for OpenAPI 3.0.0 specifications:
/// 
/// **Stage 1:** Structural Validation (Pre-parsing) - ensures correct vocabulary and structure
/// **Stage 2:** Parsing - transforms YAML into Dart object tree
/// **Stage 3:** Semantic Validation (Post-parsing) - ensures logical consistency
/// **Stage 4:** Schema Modeling - generates specialized models (deferred)
/// 
/// Use [OpenApiValidatorV3_0_0] for the new 4-stage pipeline.
/// 
/// Legacy validator (combined validation) is still available via [OpenApiValidator]
/// for backward compatibility.
library;

export 'v3_0_0/openapi_validator_v3_0_0.dart';
export 'v3_0_0/structural_validator/structural_validator.dart';
export 'v3_0_0/semantic_validator/semantic_validator.dart';
export 'v3_0_0/parser/openapi_parser.dart';
export 'v3_0_0/validator/openapi_validator.dart' hide OpenApiValidationException; // Legacy validator
export 'validation_exception.dart';