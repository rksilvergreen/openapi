import 'dart:io';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

/// Writes generated code to files using code_builder and dart_style.
class FileWriter {
  final DartEmitter _emitter = DartEmitter();
  late final DartFormatter _formatter = DartFormatter(languageVersion: DartFormatter.latestLanguageVersion);
  
  /// Write a library to a file.
  Future<void> writeLibrary(
    Library library,
    String filePath,
  ) async {
    // Convert library to source code
    final source = library.accept(_emitter).toString();
    
    // Format the source code
    String formattedSource;
    try {
      formattedSource = _formatter.format(source);
    } catch (e) {
      print('Warning: Could not format $filePath: $e');
      formattedSource = source;
    }
    
    // Write to file
    final file = File(filePath);
    await file.parent.create(recursive: true);
    await file.writeAsString(formattedSource);
  }
  
  /// Create a Library with common header and imports.
  Library createModelLibrary(
    String fileName,
    dynamic classDefinition, // Can be Spec or List<Spec> for multiple definitions
    List<String> relativeImports, {
    bool extendsCustomBaseClass = false,
  }) {
    return Library((b) {
      // Add header comments
      b.comments.add('//');
      b.comments.add('// AUTO-GENERATED FILE, DO NOT MODIFY!');
      b.comments.add('//');
      b.comments.add('');
      b.comments.add('// ignore_for_file: unused_element');
      
      // Handle both single Spec and List<Spec>
      final specs = classDefinition is List ? classDefinition : [classDefinition];
      
      // Check if we have any concrete classes (non-interface classes)
      final hasConcreteClass = specs.any((s) {
        if (s is Class) {
          // Concrete classes are not abstract interfaces
          return !(s.abstract == true && s.modifier == ClassModifier.interface);
        }
        return false;
      });
      
      // Check if any class has @JsonSerializable annotation (requires code generation)
      final hasJsonSerializable = specs.any((s) {
        if (s is Class) {
          final emitter = DartEmitter();
          return s.annotations.any((a) {
            final annotationCode = a.accept(emitter).toString();
            return annotationCode.contains('JsonSerializable');
          });
        }
        return false;
      });
      
      // Check if we have any classes that use code generation
      // Only classes with @JsonSerializable need code generation
      final needsCodeGen = hasJsonSerializable || specs.any((s) => s is Enum);
      
      // Check if any class extends Equatable (needs equatable import)
      final extendsEquatable = specs.any((s) {
        if (s is Class && s.extend != null) {
          return s.extend!.symbol == 'Equatable';
        }
        return false;
      });
      
      // Add package imports for concrete classes and enums
      if (needsCodeGen) {
        // Always add json_annotation (needed for both classes and enums)
        b.directives.add(Directive.import('package:json_annotation/json_annotation.dart'));
        
        if (hasConcreteClass) {
          b.directives.addAll([
            Directive.import('package:copy_with_extension/copy_with_extension.dart'),
          ]);
        }
      }
      
      // Add equatable import if any class extends Equatable
      if (extendsEquatable && !extendsCustomBaseClass) {
        b.directives.add(Directive.import('package:equatable/equatable.dart'));
      }
      
      // Add relative imports for other models (must come before part directive)
      for (final relativeImport in relativeImports) {
        b.directives.add(Directive.import(relativeImport));
      }
      
      // Add part directive for generated file (only for concrete classes/enums)
      if (needsCodeGen) {
        b.directives.add(Directive.part('_gen/$fileName.g.dart'));
      }
      
      // Add all class/enum definitions
      for (final spec in specs) {
        b.body.add(spec);
      }
    });
  }
  
  /// Create a barrel file that exports all models.
  Library createBarrelFile(List<String> modelFiles) {
    return Library((b) {
      b.comments.add('//');
      b.comments.add('// AUTO-GENERATED FILE, DO NOT MODIFY!');
      b.comments.add('//');
      
      // Sort exports alphabetically
      final sortedFiles = List<String>.from(modelFiles)..sort();
      
      for (final modelFile in sortedFiles) {
        b.directives.add(Directive.export('$modelFile.dart'));
      }
    });
  }
  
  /// Create build.yaml configuration file.
  Future<void> createBuildYaml(String outputDir) async {
    final buildYaml = '''
targets:
  \$default:
    builders:
      source_gen:combining_builder:
        options:
          build_extensions:
            "{{dir}}/{{file}}.dart":
              ["{{dir}}/_gen/{{file}}.g.dart"]
      json_serializable:
        options:
          any_map: false
          checked: true
          create_factory: true
          create_to_json: true
          disallow_unrecognized_keys: true
          explicit_to_json: true
          field_rename: none
          ignore_unannotated: false
          include_if_null: false
      copy_with_extension_gen:
        options:
          generate_for:
            - lib/models/**
''';
    
    final file = File('$outputDir/build.yaml');
    await file.writeAsString(buildYaml);
  }
  
  /// Create .gitignore file.
  Future<void> createGitignore(String outputDir) async {
    final gitignore = '''
# Generated files
_gen/
*.g.dart
''';
    
    final file = File('$outputDir/.gitignore');
    await file.writeAsString(gitignore);
  }
  
  /// Create README.md with instructions.
  Future<void> createReadme(String outputDir) async {
    final readme = '''
# Generated Dart Models

This directory contains auto-generated Dart model classes from an OpenAPI specification.

## Usage

These models use:
- `json_serializable` for JSON serialization
- `copy_with_extension` for immutable updates
- `equatable` for value equality

## Regenerating `.g.dart` files

After making changes to the OpenAPI spec and regenerating these models, run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Dependencies

Add these to your `pubspec.yaml`:

```yaml
dependencies:
  json_annotation: ^4.9.0
  copy_with_extension: ^7.1.0
  equatable: ^2.0.0

dev_dependencies:
  build_runner: ^2.4.0
  json_serializable: ^6.9.0
  copy_with_extension_gen: ^7.1.0
```
''';
    
    final file = File('$outputDir/README.md');
    await file.writeAsString(readme);
  }
}

