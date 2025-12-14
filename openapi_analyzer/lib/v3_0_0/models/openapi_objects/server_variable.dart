import '../openapi_graph.dart';

class ServerVariableNode extends OpenApiNode {
  ServerVariableNode(super.$id, super.json) {
    _validateStructure();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final ServerVariable content;

  void _validateStructure() {}
  void _createContent() {
    content = ServerVariable._(
      $node: this,
      enum_: json['enum'],
      default_: json['default'],
      description: json['description'],
      extensions: extractExtensions(json),
    );
  }
}

/// Server Variable for server URL template substitution.
class ServerVariable {
  final ServerVariableNode $node;
  final List<String>? enum_;
  final String default_;
  final String? description;
  final Map<String, dynamic>? extensions;

  ServerVariable._({
    required this.$node,
    required this.enum_,
    required this.default_,
    this.description,
    this.extensions,
  });
}
