import 'dart:io';
import 'package:args/args.dart';
import 'package:openapi_analyzer/main.dart';

Future<void> main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption('file', abbr: 'f', help: 'Path to the OpenAPI YAML file to validate')
    ..addFlag('generate', abbr: 'g', negatable: false, help: 'Generate Dart model classes')
    ..addOption('output', abbr: 'o', help: 'Output directory for generated models (required with --generate)')
    ..addFlag('help', abbr: 'h', negatable: false, help: 'Show this help message');

  final results = parser.parse(arguments);

  if (results['help'] == true || results.rest.isEmpty && results['file'] == null) {
    print('OpenAPI Dart Generator - Validator & Generator');
    print('');
    print('Usage:');
    print('  dart run bin/openapi_dart_validator.dart <path-to-openapi.yaml>');
    print('  dart run bin/openapi_dart_validator.dart --file <path-to-openapi.yaml>');
    print('  dart run bin/openapi_dart_validator.dart -f <path-to-openapi.yaml>');
    print('  dart run bin/openapi_dart_validator.dart --file <path-to-openapi.yaml> --generate --output ./generated');
    print('');
    print('Options:');
    print(parser.usage);
    exit(0);
  }

  // Get file path from arguments
  String filePath;
  if (results['file'] != null) {
    filePath = results['file'] as String;
  } else if (results.rest.isNotEmpty) {
    filePath = results.rest[0];
  } else {
    print('Error: No file path provided');
    print('Use --help for usage information');
    exit(1);
  }

  // Read file
  final file = File(filePath);
  if (!file.existsSync()) {
    print('Error: File not found: $filePath');
    exit(1);
  }

  String yamlContent;
  try {
    yamlContent = file.readAsStringSync();
  } catch (e) {
    print('Error: Failed to read file: $e');
    exit(1);
  }

  // Validate
  try {
    // Get base directory for resolving external references
    final baseDir = file.parent.absolute.path;
    OpenApiValidator.validate(yamlContent, baseDirectory: baseDir);
    print('✓ Validation successful: OpenAPI 3.0.0 specification is valid');
    exit(0);
  } on OpenApiValidationException catch (e) {
    print('✗ Validation failed:');
    print(e.toString());
    exit(1);
  } on FormatException catch (e) {
    print('✗ Parse error:');
    print(e.message);
    exit(1);
  } catch (e) {
    print('✗ Unexpected error:');
    print('  Error type: ${e.runtimeType}');
    print('  Error: $e');
    exit(1);
  }
}
