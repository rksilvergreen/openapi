import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';

class XMLNode extends OpenApiNode {
  XMLNode(super.$id, super.json);

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
    final path = $id.relativePath;

    // All fields are optional
    if (json.containsKey('name')) {
      ValidationUtils.requireString(json['name'], ValidationUtils.buildPath(path, 'name'));
    }

    if (json.containsKey('namespace')) {
      ValidationUtils.requireString(json['namespace'], ValidationUtils.buildPath(path, 'namespace'));
    }

    if (json.containsKey('prefix')) {
      ValidationUtils.requireString(json['prefix'], ValidationUtils.buildPath(path, 'prefix'));
    }

    if (json.containsKey('attribute')) {
      ValidationUtils.requireBool(json['attribute'], ValidationUtils.buildPath(path, 'attribute'));
    }

    if (json.containsKey('wrapped')) {
      ValidationUtils.requireBool(json['wrapped'], ValidationUtils.buildPath(path, 'wrapped'));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(
      json,
      {'name', 'namespace', 'prefix', 'attribute', 'wrapped'},
      path,
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
