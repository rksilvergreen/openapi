import 'package:yaml/yaml.dart';

import '../validator/openapi_validator.dart';
import 'src/openapi_document.dart';

/// Parser for OpenAPI documents.
abstract class OpenApiParser {
  /// Parses a validated OpenAPI document from YAML content.
  ///
  /// This function first validates the YAML content, then parses it into
  /// a structured Dart object model using JsonSerializable-generated fromJson methods.
  ///
  /// Throws [OpenApiValidationException] if validation fails.
  /// Throws [FormatException] if YAML parsing fails.
  ///
  /// [baseDirectory] is used to resolve external file references.
  static OpenApiDocument parse(String yamlContent, {String? baseDirectory}) {
    // First validate and get parsed YAML document
    final yamlDoc = OpenApiValidator.validate(yamlContent, baseDirectory: baseDirectory);

    // Convert YAML to JSON-compatible Map
    final jsonMap = _yamlToJson(yamlDoc);

    // Parse using generated fromJson
    return OpenApiDocument.fromJson(jsonMap);
  }

  /// Converts a YAML Map to a JSON-compatible Map.
  /// Handles YAML-specific types and converts them to JSON-compatible types.
  static Map<String, dynamic> _yamlToJson(Map<dynamic, dynamic> yaml) {
    final result = <String, dynamic>{};
    for (final entry in yaml.entries) {
      final key = entry.key.toString();
      result[key] = _convertValue(entry.value);
    }
    return result;
  }

  /// Recursively converts YAML values to JSON-compatible values.
  static dynamic _convertValue(dynamic value) {
    if (value == null) return null;
    if (value is Map) {
      final result = <String, dynamic>{};
      for (final entry in value.entries) {
        result[entry.key.toString()] = _convertValue(entry.value);
      }
      return result;
    }
    if (value is List) {
      return value.map((item) => _convertValue(item)).toList();
    }
    if (value is YamlScalar) {
      return value.value;
    }
    // For other YAML types, convert to string or handle appropriately
    return value;
  }
}
