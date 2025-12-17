import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../node_creation_helpers.dart';
import 'server_variable.dart';

class ServerNode extends OpenApiNode with InternalNode {
  ServerNode(Map<String, dynamic> json, String document, String jsonPointer)
    : super(NodeId(document, jsonPointer), json);

  late final Map<String, ServerVariableNode>? variablesNodes;

  late final Server content;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    // Validate required: url (non-empty string)
    final url = ValidationUtils.requireField(json, 'url', jsonPointer);
    ValidationUtils.requireNonEmptyString(url, ValidationUtils.buildPointer([jsonPointer, 'url']));

    // Validate optional: description (string)
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPointer([jsonPointer, 'description']));
    }

    // Validate optional: variables (map of ServerVariable objects)
    if (json.containsKey('variables')) {
      ValidationUtils.requireMap(json['variables'], ValidationUtils.buildPointer([jsonPointer, 'variables']));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(json, {'url', 'description', 'variables'}, jsonPointer, 'Server Object');
  }

  @override
  void createChildNodes() {
    _createServerVariableNodes();
  }

  void _createServerVariableNodes() {
    variablesNodes = createMapNode<ServerVariableNode>(
      jsonKey: 'variables',
      factory: (json, document, jsonPointer) => ServerVariableNode(json, document, jsonPointer),
    );
  }

  @override
  void createContent() {
    content = Server._(
      $node: this,
      url: json['url'],
      description: json['description'],
      extensions: extractExtensions(json),
    );
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
