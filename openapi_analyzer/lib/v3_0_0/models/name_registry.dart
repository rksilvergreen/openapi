import '../validation/validation_context.dart';
import 'package:openapi_analyzer/validation_exception.dart';

/// Manages name registries for schemas, operations, and documents.
/// Handles collision detection and resolution with deterministic suffixes.
class NameRegistry {
  final ValidationContext validationContext;

  // Schema name registries
  final Map<String, String> _schemaNames = {}; // absolutePointer -> name
  final Map<String, List<String>> _nameRegistry = {}; // name -> list of absolutePointers using this name

  // Operation name registries
  final Map<String, String> _operationNames = {}; // absolutePointer -> name
  final Map<String, List<String>> _operationNameRegistry = {}; // name -> list of absolutePointers using this name

  // Document name registries
  final Map<String, String> _documentNames = {}; // absolutePointer -> name
  final Map<String, List<String>> _documentNameRegistry = {}; // name -> list of absolutePointers using this name

  // Parameter name registries
  final Map<String, String> _parameterNames = {}; // absolutePointer -> name
  final Map<String, List<String>> _parameterNameRegistry = {}; // name -> list of absolutePointers using this name

  // Request body name registries
  final Map<String, String> _requestBodyNames = {}; // absolutePointer -> name
  final Map<String, List<String>> _requestBodyNameRegistry = {}; // name -> list of absolutePointers using this name

  // Response name registries
  final Map<String, String> _responseNames = {}; // absolutePointer -> name
  final Map<String, List<String>> _responseNameRegistry = {}; // name -> list of absolutePointers using this name

  // Header name registries
  final Map<String, String> _headerNames = {}; // absolutePointer -> name
  final Map<String, List<String>> _headerNameRegistry = {}; // name -> list of absolutePointers using this name

  // Callback name registries
  final Map<String, String> _callbackNames = {}; // absolutePointer -> name
  final Map<String, List<String>> _callbackNameRegistry = {}; // name -> list of absolutePointers using this name

  // Security scheme name registries
  final Map<String, String> _securitySchemeNames = {}; // absolutePointer -> name
  final Map<String, List<String>> _securitySchemeNameRegistry = {}; // name -> list of absolutePointers using this name

  // Server name registries
  final Map<String, String> _serverNames = {}; // absolutePointer -> name
  final Map<String, List<String>> _serverNameRegistry = {}; // name -> list of absolutePointers using this name

  NameRegistry(this.validationContext);

  /// Generic method to register a name, handling collisions with deterministic suffixes.
  /// Returns the final unique name (may have _2, _3, etc. suffix if there was a collision).
  String _registerName(
    String absolutePointer,
    String baseName,
    Map<String, String> namesCache,
    Map<String, List<String>> nameRegistry,
    String typeName,
  ) {
    // Check if this node already has a name
    if (namesCache.containsKey(absolutePointer)) {
      return namesCache[absolutePointer]!;
    }

    // Check for collisions
    String finalName = baseName;
    if (nameRegistry.containsKey(baseName)) {
      // Collision detected - add suffix
      final existingPointers = nameRegistry[baseName]!;
      final count = existingPointers.length + 1;
      finalName = '${baseName}_$count';

      // Add this pointer to the registry
      existingPointers.add(absolutePointer);
      nameRegistry[baseName] = existingPointers;

      // Add low severity validation exception for the collision
      validationContext.addException(
        OpenApiValidationException(
          absolutePointer,
          '$typeName name collision: "$baseName" is already used by ${typeName.toLowerCase()}s at: ${existingPointers.join(", ")}',
          specReference: '$typeName Naming',
          severity: ValidationSeverity.low,
        ),
      );
    } else {
      // First use of this name
      nameRegistry[baseName] = [absolutePointer];
    }

    // Store the final name
    namesCache[absolutePointer] = finalName;
    return finalName;
  }

  /// Registers a name for a schema, handling collisions with deterministic suffixes.
  /// Returns the final unique name (may have _2, _3, etc. suffix if there was a collision).
  String registerSchemaName(String absolutePointer, String baseName) {
    return _registerName(absolutePointer, baseName, _schemaNames, _nameRegistry, 'Schema');
  }

  /// Gets a cached name for a schema if it exists.
  String? getCachedSchemaName(String absolutePointer) {
    return _schemaNames[absolutePointer];
  }

  /// Registers a name for an operation, handling collisions with deterministic suffixes.
  /// Returns the final unique name (may have _2, _3, etc. suffix if there was a collision).
  String registerOperationName(String absolutePointer, String baseName) {
    return _registerName(absolutePointer, baseName, _operationNames, _operationNameRegistry, 'Operation');
  }

  /// Gets a cached name for an operation if it exists.
  String? getCachedOperationName(String absolutePointer) {
    return _operationNames[absolutePointer];
  }

  /// Registers a name for a document, handling collisions with deterministic suffixes.
  /// Returns the final unique name (may have _2, _3, etc. suffix if there was a collision).
  String registerDocumentName(String absolutePointer, String baseName) {
    return _registerName(absolutePointer, baseName, _documentNames, _documentNameRegistry, 'Document');
  }

  /// Gets a cached name for a document if it exists.
  String? getCachedDocumentName(String absolutePointer) {
    return _documentNames[absolutePointer];
  }

  /// Registers a name for a parameter, handling collisions with deterministic suffixes.
  /// Returns the final unique name (may have _2, _3, etc. suffix if there was a collision).
  String registerParameterName(String absolutePointer, String baseName) {
    return _registerName(absolutePointer, baseName, _parameterNames, _parameterNameRegistry, 'Parameter');
  }

  /// Gets a cached name for a parameter if it exists.
  String? getCachedParameterName(String absolutePointer) {
    return _parameterNames[absolutePointer];
  }

  /// Registers a name for a request body, handling collisions with deterministic suffixes.
  /// Returns the final unique name (may have _2, _3, etc. suffix if there was a collision).
  String registerRequestBodyName(String absolutePointer, String baseName) {
    return _registerName(absolutePointer, baseName, _requestBodyNames, _requestBodyNameRegistry, 'RequestBody');
  }

  /// Gets a cached name for a request body if it exists.
  String? getCachedRequestBodyName(String absolutePointer) {
    return _requestBodyNames[absolutePointer];
  }

  /// Registers a name for a response, handling collisions with deterministic suffixes.
  /// Returns the final unique name (may have _2, _3, etc. suffix if there was a collision).
  String registerResponseName(String absolutePointer, String baseName) {
    return _registerName(absolutePointer, baseName, _responseNames, _responseNameRegistry, 'Response');
  }

  /// Gets a cached name for a response if it exists.
  String? getCachedResponseName(String absolutePointer) {
    return _responseNames[absolutePointer];
  }

  /// Registers a name for a header, handling collisions with deterministic suffixes.
  /// Returns the final unique name (may have _2, _3, etc. suffix if there was a collision).
  String registerHeaderName(String absolutePointer, String baseName) {
    return _registerName(absolutePointer, baseName, _headerNames, _headerNameRegistry, 'Header');
  }

  /// Gets a cached name for a header if it exists.
  String? getCachedHeaderName(String absolutePointer) {
    return _headerNames[absolutePointer];
  }

  /// Registers a name for a callback, handling collisions with deterministic suffixes.
  /// Returns the final unique name (may have _2, _3, etc. suffix if there was a collision).
  String registerCallbackName(String absolutePointer, String baseName) {
    return _registerName(absolutePointer, baseName, _callbackNames, _callbackNameRegistry, 'Callback');
  }

  /// Gets a cached name for a callback if it exists.
  String? getCachedCallbackName(String absolutePointer) {
    return _callbackNames[absolutePointer];
  }

  /// Registers a name for a security scheme, handling collisions with deterministic suffixes.
  /// Returns the final unique name (may have _2, _3, etc. suffix if there was a collision).
  String registerSecuritySchemeName(String absolutePointer, String baseName) {
    return _registerName(
      absolutePointer,
      baseName,
      _securitySchemeNames,
      _securitySchemeNameRegistry,
      'SecurityScheme',
    );
  }

  /// Gets a cached name for a security scheme if it exists.
  String? getCachedSecuritySchemeName(String absolutePointer) {
    return _securitySchemeNames[absolutePointer];
  }

  /// Registers a name for a server, handling collisions with deterministic suffixes.
  /// Returns the final unique name (may have _2, _3, etc. suffix if there was a collision).
  String registerServerName(String absolutePointer, String baseName) {
    return _registerName(absolutePointer, baseName, _serverNames, _serverNameRegistry, 'Server');
  }

  /// Gets a cached name for a server if it exists.
  String? getCachedServerName(String absolutePointer) {
    return _serverNames[absolutePointer];
  }
}