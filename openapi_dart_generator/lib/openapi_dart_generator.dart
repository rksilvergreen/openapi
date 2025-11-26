/// OpenAPI Dart Generator - Dart Code Generation from OpenAPI Specifications
/// 
/// This package generates type-safe Dart models from OpenAPI documents.
/// It depends on the openapi_analyzer package for document parsing and analysis.
/// 
/// Features:
/// - Type-safe Dart classes with JsonSerializable
/// - CopyWith extensions
/// - Equatable for value equality
/// - Support for complex OpenAPI patterns (discriminators, oneOf, allOf, etc.)
/// - Generated fromJson/toJson methods
/// 
/// Example usage:
/// ```dart
/// import 'package:openapi_analyzer/openapi_analyzer.dart';
/// import 'package:openapi_dart_generator/openapi_dart_generator.dart';
/// 
/// void main() async {
///   // Parse OpenAPI document
///   final validator = OpenApiValidator_v3_0_0();
///   final yamlContent = await File('api.yaml').readAsString();
///   validator.validate(yamlContent);
///   
///   final document = parseOpenApiDocument(yamlContent);
///   
///   // Generate Dart code
///   final generator = ModelGenerator_v3_0_0('./output');
///   await generator.generate(document);
/// }
/// ```
library openapi_dart_generator;

// V3.0.0 - Main supported version
export 'v3_0_0/model_generator_v3_0_0.dart';
export 'v3_0_0/dart_type_mapper_v3_0_0.dart';
export 'v3_0_0/dart_name_generator_v3_0_0.dart';
export 'v3_0_0/object_class_generator_v3_0_0.dart';
export 'v3_0_0/enum_generator_v3_0_0.dart';
export 'v3_0_0/interface_generator_v3_0_0.dart';

// Base classes (for advanced usage and extension)
export 'base/model_generator.dart';
export 'base/dart_type_mapper.dart';
export 'base/dart_name_generator.dart';
export 'base/object_class_generator.dart';
export 'base/enum_generator.dart';
export 'base/interface_generator.dart';
export 'base/variant_class_generator.dart';
export 'base/primitive_wrapper_generator.dart';
export 'base/union_generator.dart';
export 'base/pattern_orchestrator.dart';
export 'base/file_writer.dart';
