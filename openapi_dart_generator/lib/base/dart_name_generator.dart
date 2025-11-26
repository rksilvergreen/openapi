import 'package:recase/recase.dart';
import 'package:openapi_analyzer/openapi_analyzer.dart';

/// Generates Dart-specific file and class names for schemas.
class DartNameGenerator {
  final NameExtractor _extractor = NameExtractor();

  /// Generate file and class names for a schema following Dart conventions.
  void generateNames(SchemaMetadata metadata) {
    final baseName = _extractor.extractBaseName(metadata);

    // Convert to PascalCase for class name (Dart convention)
    final className = ReCase(baseName).pascalCase;

    // Convert to snake_case for file name (Dart convention)
    final fileName = ReCase(baseName).snakeCase;

    // Ensure uniqueness
    final uniqueClassName = _extractor.ensureUnique(className);
    final uniqueFileName = _extractor.ensureUnique(fileName);

    // Apply Dart-specific keyword handling
    metadata.className = handleDartKeywords(uniqueClassName);
    metadata.fileName = uniqueFileName;
  }

  /// Check if a name is a Dart reserved keyword and append underscore if needed.
  static String handleDartKeywords(String name) {
    const keywords = {
      'abstract',
      'as',
      'assert',
      'async',
      'await',
      'break',
      'case',
      'catch',
      'class',
      'const',
      'continue',
      'covariant',
      'default',
      'deferred',
      'do',
      'dynamic',
      'else',
      'enum',
      'export',
      'extends',
      'extension',
      'external',
      'factory',
      'false',
      'final',
      'finally',
      'for',
      'Function',
      'get',
      'hide',
      'if',
      'implements',
      'import',
      'in',
      'interface',
      'is',
      'late',
      'library',
      'mixin',
      'new',
      'null',
      'of',
      'on',
      'operator',
      'part',
      'required',
      'rethrow',
      'return',
      'set',
      'show',
      'static',
      'super',
      'switch',
      'sync',
      'this',
      'throw',
      'true',
      'try',
      'typedef',
      'var',
      'void',
      'while',
      'with',
      'yield',
    };

    if (keywords.contains(name)) {
      return '${name}_';
    }
    return name;
  }

  /// Sanitize an arbitrary string into a valid Dart identifier (camelCase + keyword safe).
  static String normalizeIdentifier(String value) {
    var identifier = value
        .replaceAll(RegExp(r'[^\w\s]'), '_')
        .replaceAll(RegExp(r'\s+'), '_')
        .replaceAll(RegExp(r'_+'), '_')
        .replaceAll(RegExp(r'^_|_$'), '');

    if (identifier.isEmpty) {
      identifier = 'unknown';
    }

    if (RegExp(r'^\d').hasMatch(identifier)) {
      identifier = 'value$identifier';
    }

    final camel = ReCase(identifier).camelCase;
    final safeName = camel.isEmpty ? 'unknown' : camel;
    return handleDartKeywords(safeName);
  }
}

