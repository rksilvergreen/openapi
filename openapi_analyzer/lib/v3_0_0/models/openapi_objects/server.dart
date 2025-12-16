import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../node_creation_helpers.dart';
import 'server_variable.dart';

class ServerNode extends OpenApiNode {
  ServerNode(super.$id, super.json);

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final Map<String, ServerVariableNode>? variablesNodes;

  late final Server content;

  void create() {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  void _validateStructure() {
    _structureValidated = true;
    final jsonPointer = $id.jsonPointer;

    // Validate required: url (non-empty string)
    final url = ValidationUtils.requireField(json, 'url', jsonPointer);
    ValidationUtils.requireNonEmptyString(url, ValidationUtils.buildPath(jsonPointer, 'url'));

    // Validate optional: description (string)
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPath(jsonPointer, 'description'));
    }

    // Validate optional: variables (map of ServerVariable objects)
    if (json.containsKey('variables')) {
      ValidationUtils.requireMap(json['variables'], ValidationUtils.buildPath(jsonPointer, 'variables'));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(json, {'url', 'description', 'variables'}, jsonPointer, 'Server Object');
  }

  void _createChildNodes() {
    _createServerVariableNodes();
  }

  void _createServerVariableNodes() {
    variablesNodes = createMapNode<ServerVariableNode>(
      jsonKey: 'variables',
      factory: ({required id, required json}) => ServerVariableNode(id, json),
    );
  }

  void _createContent() {
    content = Server._(
      $node: this,
      url: json['url'],
      description: json['description'],
      extensions: extractExtensions(json),
    );
    _contentCreated = true;
  }
}

/// Server object representing a server.
class Server {
  final ServerNode $node;
  final String url;
  final String? description;
  Map<String, ServerVariable>? get variables => $node.variablesNodes?.map((k, v) => MapEntry(k, v.content));
  final Map<String, dynamic>? extensions;

  Server._({required this.$node, required this.url, this.description, this.extensions});
}
