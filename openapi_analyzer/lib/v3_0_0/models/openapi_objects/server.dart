import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
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

  void _validateStructure() {
    _structureValidated = true;
    final path = $id.relativePath;

    // Validate required: url (non-empty string)
    final url = ValidationUtils.requireField(json, 'url', path);
    ValidationUtils.requireNonEmptyString(url, ValidationUtils.buildPath(path, 'url'));

    // Validate optional: description (string)
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPath(path, 'description'));
    }

    // Validate optional: variables (map of ServerVariable objects)
    if (json.containsKey('variables')) {
      ValidationUtils.requireMap(json['variables'], ValidationUtils.buildPath(path, 'variables'));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(
      json,
      {'url', 'description', 'variables'},
      path,
      'Server Object',
    );
  }

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
