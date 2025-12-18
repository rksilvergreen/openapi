import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../node_creation_helpers.dart';
import 'server_variable.dart';
import 'server_variables_map.dart';

abstract class Server {
  String get url;
  String? get description;
  ServerVariablesMap? get variables;
  Map<String, dynamic>? get extensions;
}

class ServerNode extends OpenApiNode with InternalNode implements Server {
  ServerNode(Map<String, dynamic> json, String document, String jsonPointer)
    : super(NodeId(document, jsonPointer), json);

  late final String url;
  late final String? description;
  late final ServerVariablesMapNode? variables;
  late final Map<String, dynamic>? extensions;

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
    createMapNode<ServerVariablesMapNode>(jsonKey: 'variables');
  }

  @override
  void createContent() {
    url = json['url'];
    description = json['description'];
    variables = $to.to<ServerVariablesMapNode>('variables');
    extensions = extractExtensions(json);
  }
}
