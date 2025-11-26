# OpenAPI Dart Generator

Generate type-safe Dart models from OpenAPI specifications.

## Features

- **Type-Safe Models**: Generates Dart classes with full type safety
- **JSON Serialization**: Uses `json_serializable` for serialization
- **CopyWith**: Generates copyWith extensions for immutability
- **Equatable**: Value equality for all generated classes
- **Complex Patterns**: Supports discriminators, oneOf, allOf, anyOf, and more
- **Inheritance**: Proper handling of OpenAPI inheritance patterns

## Installation

Add this to your package's `pubspec.yaml`:

```yaml
dependencies:
  openapi_dart_generator: ^1.0.0
  openapi_analyzer: ^1.0.0
  
  # Dependencies for generated code
  json_annotation: ^4.9.0
  copy_with_extension: ^5.0.0
  equatable: ^2.0.0

dev_dependencies:
  build_runner: ^2.4.0
  json_serializable: ^6.8.0
  copy_with_extension_gen: ^5.0.0
```

## Usage

### Basic Generation

```dart
import 'package:openapi_analyzer/openapi_analyzer.dart';
import 'package:openapi_dart_generator/openapi_dart_generator.dart';
import 'dart:io';

void main() async {
  // Read and validate OpenAPI YAML
  final yamlContent = await File('api.yaml').readAsString();
  final validator = OpenApiValidator_v3_0_0();
  validator.validate(yamlContent);
  
  // Parse to document
  final validatedMap = validator.validate(yamlContent);
  final document = OpenApiDocument.fromJson(validatedMap);
  
  // Generate Dart models
  final generator = ModelGenerator_v3_0_0('./lib/models');
  await generator.generate(document);
  
  print('✓ Models generated successfully');
}
```

### Running Code Generation

After generating models, run code generation for json_serializable and copy_with:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Generated Code Example

Given this OpenAPI schema:

```yaml
components:
  schemas:
    User:
      type: object
      required: [id, name]
      properties:
        id:
          type: integer
        name:
          type: string
        email:
          type: string
```

The generator creates:

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'user.g.dart';

@CopyWith()
@JsonSerializable()
class User extends Equatable {
  final int id;
  final String name;
  final String? email;

  const User({
    required this.id,
    required this.name,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [id, name, email];

  @override
  String toString() => 'User(id: $id, name: $name, email: $email)';
}
```

## Supported Patterns

The generator handles complex OpenAPI patterns:

- **Simple Objects**: Basic object schemas
- **Enums**: String, integer, and number enums
- **Discriminators**: Polymorphic types with discriminator property
- **oneOf**: Union types (generates interfaces)
- **allOf**: Inheritance and composition
- **anyOf**: Multiple valid schemas
- **Nested Objects**: Inline object definitions
- **Arrays**: Lists with type safety
- **Maps**: additionalProperties support

## Architecture

This package follows a version-based inheritance architecture:

```
lib/
├── base/                      # Complete Dart generation for 3.0.0
│   ├── model_generator.dart  # Main orchestrator
│   ├── dart_type_mapper.dart # Type mapping
│   ├── dart_name_generator.dart # Naming conventions
│   ├── object_class_generator.dart
│   ├── enum_generator.dart
│   ├── interface_generator.dart
│   ├── variant_class_generator.dart
│   ├── pattern_orchestrator.dart
│   └── file_writer.dart
└── v3_0_0/                    # 3.0.0 version wrappers
```

## Relationship with openapi_analyzer

This package depends on `openapi_analyzer` for:

- OpenAPI validation
- Document parsing
- Schema discovery and classification
- Composition analysis

The generator adds Dart-specific:

- Type mapping (OpenAPI → Dart types)
- Naming conventions (PascalCase, snake_case)
- Code generation (using code_builder)
- File writing and formatting

## CLI Usage

You can create a CLI tool in `bin/`:

```dart
// bin/generate.dart
import 'dart:io';
import 'package:args/args.dart';
import 'package:openapi_analyzer/openapi_analyzer.dart';
import 'package:openapi_dart_generator/openapi_dart_generator.dart';

void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption('input', abbr: 'i', help: 'Input OpenAPI YAML file')
    ..addOption('output', abbr: 'o', help: 'Output directory');

  final args = parser.parse(arguments);
  
  final inputFile = args['input'] as String?;
  final outputDir = args['output'] as String?;
  
  if (inputFile == null || outputDir == null) {
    print('Usage: dart run bin/generate.dart -i <input.yaml> -o <output-dir>');
    exit(1);
  }
  
  // Validate and parse
  final yamlContent = await File(inputFile).readAsString();
  final validator = OpenApiValidator_v3_0_0();
  final validatedMap = validator.validate(yamlContent);
  final document = OpenApiDocument.fromJson(validatedMap);
  
  // Generate
  final generator = ModelGenerator_v3_0_0(outputDir);
  await generator.generate(document);
  
  print('✓ Generation complete!');
  print('Run: dart run build_runner build --delete-conflicting-outputs');
}
```

Run it:

```bash
dart run bin/generate.dart -i api.yaml -o lib/models
```

## License

Copyright (c) 2025. All rights reserved.
