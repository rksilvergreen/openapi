# OpenAPI Analyzer

Language-agnostic validation, parsing, and analysis of OpenAPI specifications.

## Features

- **Validation**: Validates OpenAPI YAML files against the OpenAPI specification
- **Parsing**: Parses YAML into strongly-typed Dart objects
- **Analysis**: Discovers and classifies schemas, analyzes composition patterns
- **Version Support**: Currently supports OpenAPI 3.0.0 with extensible version-based architecture

## Installation

Add this to your package's `pubspec.yaml`:

```yaml
dependencies:
  openapi_analyzer: ^1.0.0
```

## Usage

### Basic Validation and Parsing

```dart
import 'package:openapi_analyzer/openapi_analyzer.dart';
import 'dart:io';

void main() async {
  // Read OpenAPI YAML file
  final yamlContent = await File('api.yaml').readAsString();
  
  // Validate
  final validator = OpenApiValidator_v3_0_0();
  final validatedMap = validator.validate(yamlContent);
  print('✓ OpenAPI document is valid');
  
  // Parse to typed objects
  final document = OpenApiDocument.fromJson(validatedMap);
  print('API: ${document.info.title} ${document.info.version}');
}
```

### Schema Discovery and Classification

```dart
import 'package:openapi_analyzer/openapi_analyzer.dart';

void analyzeSchemas(OpenApiDocument document) {
  // Discover all schemas in the document
  final discoverer = SchemaDiscoverer_v3_0_0();
  final schemas = discoverer.discover(document);
  
  print('Found ${schemas.length} schemas');
  
  // Classify each schema
  final classifier = SchemaClassifier_v3_0_0();
  for (final metadata in schemas) {
    final type = classifier.classify(metadata.schema);
    print('${metadata.location.path}: $type');
  }
}
```

### Composition Analysis

```dart
import 'package:openapi_analyzer/openapi_analyzer.dart';

void analyzeComposition(SchemaObject schema) {
  final analyzer = CompositionAnalyzer_v3_0_0();
  
  // Analyze allOf compositions
  if (schema.allOf != null) {
    final analysis = analyzer.analyzeAllOf(schema.allOf!);
    print('AllOf analysis: ${analysis.isActualInheritance ? "inheritance" : "merge"}');
  }
  
  // Resolve all properties including inherited ones
  final allProperties = analyzer.resolveAllProperties(schema);
  print('Total properties: ${allProperties.length}');
}
```

## Architecture

This package follows a version-based inheritance architecture:

```
lib/
├── base/                    # Complete 3.0.0 implementation
│   ├── validator/          # Validation logic
│   ├── parser/             # Parser models
│   ├── analyzer/           # Analysis logic
│   └── utils/              # Utilities
├── v3_0_0/                  # 3.0.0 version (minimal wrappers)
├── v3_0_1/                  # Future: 3.0.1 extensions
└── version_detector.dart    # Version detection and routing
```

Future OpenAPI versions will extend previous versions, overriding only what changed.

## Relationship with openapi_dart_generator

This package provides the foundation for the `openapi_dart_generator` package:

- `openapi_analyzer` - Language-agnostic analysis
- `openapi_dart_generator` - Dart-specific code generation

If you want to generate Dart code from OpenAPI specs, use `openapi_dart_generator` which depends on this package.

## License

Copyright (c) 2025. All rights reserved.
