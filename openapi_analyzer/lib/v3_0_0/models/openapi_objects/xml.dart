import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';

class XMLNode extends OpenApiNode with LeafNode {
  XMLNode(Map<String, dynamic> json, String document, String jsonPointer) : super(NodeId(document, jsonPointer), json);

  late final XML content;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    // All fields are optional
    if (json.containsKey('name')) {
      ValidationUtils.requireString(json['name'], ValidationUtils.buildPointer([jsonPointer, 'name']));
    }

    if (json.containsKey('namespace')) {
      ValidationUtils.requireString(json['namespace'], ValidationUtils.buildPointer([jsonPointer, 'namespace']));
    }

    if (json.containsKey('prefix')) {
      ValidationUtils.requireString(json['prefix'], ValidationUtils.buildPointer([jsonPointer, 'prefix']));
    }

    if (json.containsKey('attribute')) {
      ValidationUtils.requireBool(json['attribute'], ValidationUtils.buildPointer([jsonPointer, 'attribute']));
    }

    if (json.containsKey('wrapped')) {
      ValidationUtils.requireBool(json['wrapped'], ValidationUtils.buildPointer([jsonPointer, 'wrapped']));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(
      json,
      {'name', 'namespace', 'prefix', 'attribute', 'wrapped'},
      jsonPointer,
      'XML Object',
    );
  }

  @override
  void createContent() {
    content = XML._(
      $node: this,
      name: json['name'],
      namespace: json['namespace'],
      prefix: json['prefix'],
      attribute: json['attribute'] ?? false,
      wrapped: json['wrapped'] ?? false,
      extensions: extractExtensions(json),
    );
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
