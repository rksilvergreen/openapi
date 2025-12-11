import 'dart:io';
import 'dart:convert';
import 'package:args/args.dart';
import 'package:openapi_analyzer/main.dart';

Future<void> main(List<String> arguments) async {
  final parser = ArgParser();

  final commandParser = ArgParser()
    ..addOption('file', abbr: 'f', help: 'Path to the OpenAPI YAML file', mandatory: true);

  parser.addCommand('validate', commandParser);
  parser.addCommand('parse', commandParser);

  final results = parser.parse(arguments);

  if (results.command == null) {
    print('OpenAPI Analyzer - Validator & Parser');
    print('');
    print('Usage:');
    print('  dart run bin/openapi_analyzer.dart validate --file <path-to-openapi.yaml>');
    print('  dart run bin/openapi_analyzer.dart parse --file <path-to-openapi.yaml>');
    print('  dart run bin/openapi_analyzer.dart validate -f <path-to-openapi.yaml>');
    print('  dart run bin/openapi_analyzer.dart parse -f <path-to-openapi.yaml>');
    print('');
    print('Commands:');
    print('  validate    Validate an OpenAPI YAML file');
    print('  parse       Validate and parse an OpenAPI YAML file into a structured document');
    print('');
    print('Options:');
    print('  -f, --file  Path to the OpenAPI YAML file (required)');
    exit(0);
  }

  final command = results.command!;
  final filePath = command['file'] as String;

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
  final yamlDoc = loadYaml(yamlContent);

  // Get base directory for resolving external references
  final baseDir = file.parent.absolute.path;

  // Handle validate command
  if (command.name == 'validate') {
    try {
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

  // Handle parse command
  if (command.name == 'parse') {
    try {
      // First validate
      OpenApiValidator.validate(yamlContent, baseDirectory: baseDir);
      print('✓ Validation successful: OpenAPI 3.0.0 specification is valid');

      // Then parse
      final document = OpenApiParser.parse(yamlContent, baseDirectory: baseDir);
      print('');
      print('✓ Parsing successful');
      print('');
      print('OpenAPI Document:');
      // Convert to JSON and pretty print
      final json = document.toJson();
      final encoder = JsonEncoder.withIndent('  ');
      print(encoder.convert(json));
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
      print('✗ Parsing failed:');
      print('  Error type: ${e.runtimeType}');
      print('  Error: $e');
      exit(1);
    }
  }
}
