import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';

class XMLNode extends OpenApiNode {
  XMLNode(Map<String, dynamic> json, String document, String jsonPointer)
      : super(NodeId(document, jsonPointer), json);

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final XML content;

  void create() {
    _validateStructure();
    _createContent();
  }

  void _validateStructure() {
    final jsonPointer = $id.jsonPointer;

    // All fields are optional
    if (json.containsKey('name')) {
      ValidationUtils.requireString(json['name'], ValidationUtils.buildPath(jsonPointer, 'name'));
    }

    if (json.containsKey('namespace')) {
      ValidationUtils.requireString(json['namespace'], ValidationUtils.buildPath(jsonPointer, 'namespace'));
    }

    if (json.containsKey('prefix')) {
      ValidationUtils.requireString(json['prefix'], ValidationUtils.buildPath(jsonPointer, 'prefix'));
    }

    if (json.containsKey('attribute')) {
      ValidationUtils.requireBool(json['attribute'], ValidationUtils.buildPath(jsonPointer, 'attribute'));
    }

    if (json.containsKey('wrapped')) {
      ValidationUtils.requireBool(json['wrapped'], ValidationUtils.buildPath(jsonPointer, 'wrapped'));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(
      json,
      {'name', 'namespace', 'prefix', 'attribute', 'wrapped'},
      jsonPointer,
      'XML Object',
    );

    _structureValidated = true;
  }

  void _createContent() {
    content = XML._(
      $node: this,
      name: json['name'],
      namespace: json['namespace'],
      prefix: json['prefix'],
      attribute: json['attribute'] ?? false,
      wrapped: json['wrapped'] ?? false,
      extensions: extractExtensions(json),
    );
    _contentCreated = true;
  }
}

/// XML object for XML representation metadata.
class XML {
  final XMLNode $node;
  final String? name;
  final String? namespace;
  final String? prefix;
  final bool attribute;
  final bool wrapped;
  final Map<String, dynamic>? extensions;

  XML._({
    required this.$node,
    this.name,
    this.namespace,
    this.prefix,
    this.attribute = false,
    this.wrapped = false,
    this.extensions,
  });
}
