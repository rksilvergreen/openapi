import '../openapi_graph.dart';

class XMLNode extends OpenApiNode {
  XMLNode(super.$id, super.json) {
    _validateStructure();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final XML content;

  void _validateStructure() {}
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
