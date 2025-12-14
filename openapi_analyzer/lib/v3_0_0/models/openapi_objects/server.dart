import '../openapi_graph.dart';
import 'server_variable.dart';

class ServerNode extends OpenApiNode {
  ServerNode(super.$id, super.json) {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final List<ServerVariableNode>? variableNodes;

  late final Server content;

  void _validateStructure() {}

  void _createChildNodes() {}

  void _createContent() {
    content = Server._(
      $node: this,
      url: json['url'],
      description: json['description'],
      variables: json['variables'],
      extensions: extractExtensions(json),
    );
  }
}

/// Server object representing a server.
class Server {
  final ServerNode $node;
  final String url;
  final String? description;
  final Map<String, ServerVariable>? variables;
  final Map<String, dynamic>? extensions;

  Server._({required this.$node, required this.url, this.description, this.variables, this.extensions});
}
