/// Version detection and routing for OpenAPI specifications
library;

import 'package:yaml/yaml.dart';

/// Supported OpenAPI versions
enum OpenApiVersion {
  v3_0_0('3.0.0'),
  v3_0_1('3.0.1'),
  v3_0_2('3.0.2'),
  v3_0_3('3.0.3'),
  v3_1_0('3.1.0');

  const OpenApiVersion(this.versionString);

  final String versionString;

  @override
  String toString() => versionString;
}

/// Detects and routes OpenAPI versions
class VersionDetector {
  /// Detects OpenAPI version from YAML content
  /// 
  /// Throws [FormatException] if:
  /// - The 'openapi' field is missing
  /// - The version is not supported
  OpenApiVersion detectVersion(String yamlContent) {
    final doc = loadYaml(yamlContent);
    
    if (doc is! Map) {
      throw FormatException('OpenAPI document must be a map/object');
    }
    
    final openapiField = doc['openapi'];
    if (openapiField == null) {
      throw FormatException('Missing required "openapi" field');
    }
    
    final version = openapiField.toString();
    return detectVersionFromString(version);
  }

  /// Detects version from parsed YAML document
  OpenApiVersion detectVersionFromMap(Map<dynamic, dynamic> yamlDoc) {
    final openapiField = yamlDoc['openapi'];
    if (openapiField == null) {
      throw FormatException('Missing required "openapi" field');
    }
    
    final version = openapiField.toString();
    return detectVersionFromString(version);
  }

  /// Detects version from version string
  OpenApiVersion detectVersionFromString(String version) {
    // Normalize version string (remove any whitespace)
    final normalized = version.trim();
    
    switch (normalized) {
      case '3.0.0':
        return OpenApiVersion.v3_0_0;
      case '3.0.1':
        return OpenApiVersion.v3_0_1;
      case '3.0.2':
        return OpenApiVersion.v3_0_2;
      case '3.0.3':
        return OpenApiVersion.v3_0_3;
      case '3.1.0':
        return OpenApiVersion.v3_1_0;
      default:
        // Check for partial matches (e.g., "3.0" should match "3.0.0")
        if (normalized.startsWith('3.0') && 
            !['3.0.1', '3.0.2', '3.0.3'].any((v) => normalized.startsWith(v))) {
          return OpenApiVersion.v3_0_0;
        }
        throw FormatException('Unsupported OpenAPI version: $version. '
            'Supported versions: 3.0.0, 3.0.1, 3.0.2, 3.0.3, 3.1.0');
    }
  }
}

