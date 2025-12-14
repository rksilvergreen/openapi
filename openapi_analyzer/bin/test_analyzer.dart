import 'dart:io';
import 'package:openapi_analyzer/v3_0_0/openapi_validator_v3_0_0.dart';
import 'package:openapi_analyzer/validation_exception.dart';

/// Test harness for the OpenAPI Analyzer.
/// 
/// This tests the complete three-stage pipeline on a sample OpenAPI spec.
void main() {
  print('=== OpenAPI Analyzer Test ===\n');

  final testFile = File('bin/test_petstore.yaml');
  
  if (!testFile.existsSync()) {
    print('Error: Test file not found: ${testFile.path}');
    exit(1);
  }

  print('Testing file: ${testFile.path}\n');

  try {
    // Validate with moderate strictness
    print('Running validation (moderate strictness)...');
    final graph = OpenApiValidatorV3_0_0.validate(
      testFile,
      strictness: ValidationStrictness.moderate,
    );

    print('✓ Validation successful!\n');

    // Print summary
    print('=== OpenAPI Document Summary ===');
    print('Title: ${graph.root.info.title}');
    print('Version: ${graph.root.info.version}');
    print('Description: ${graph.root.info.description ?? "N/A"}');
    print('');

    print('=== Statistics ===');
    print('OpenAPI Nodes: ${graph.openApiNodes.length}');
    print('Schema Nodes: ${graph.schemaNodes.length}');
    print('OpenAPI Edges: ${graph.openApiEdges.length}');
    print('Structural Edges: ${graph.schemaStructuralEdges.length}');
    print('Applicator Edges: ${graph.schemaApplicatorEdges.length}');
    print('');

    print('=== Paths ===');
    for (final entry in graph.root.paths.paths.entries) {
      print('Path: ${entry.key}');
      final pathItem = entry.value;
      if (pathItem.get_ != null) print('  - GET');
      if (pathItem.post != null) print('  - POST');
      if (pathItem.put != null) print('  - PUT');
      if (pathItem.delete != null) print('  - DELETE');
    }
    print('');

    print('=== Components ===');
    if (graph.root.components?.schemas != null) {
      print('Schemas:');
      for (final schemaName in graph.root.components!.schemas!.keys) {
        print('  - $schemaName');
      }
    }
    print('');

    print('=== Test Complete ===');
    print('All phases executed successfully!');
    
  } on ValidationFailedException catch (e) {
    print('✗ Validation failed:\n');
    print(e.message);
    exit(1);
  } catch (e, stackTrace) {
    print('✗ Unexpected error:\n');
    print(e);
    print('\nStack trace:');
    print(stackTrace);
    exit(1);
  }
}

