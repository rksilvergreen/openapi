import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../node_creation_helpers.dart';
import 'server_variables_map.dart';

abstract class Server {
  String get url;
  String? get description;
  ServerVariablesMap? get variables;
  Map<String, dynamic>? get extensions;
}

class ServerNode extends Node with InternalNode implements Server {
  ServerNode(super.json, super.document, super.jsonPointer);

  late final String url;
  late final String? description;
  late final ServerVariablesMapNode? variables;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    _validateUrl(jsonPointer);
    _validateDescription(jsonPointer);
    _validateVariables(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
  }

  void _validateUrl(String jsonPointer) {
    final url = ValidationUtils.requireField(json, 'url', jsonPointer);
    ValidationUtils.requireNonEmptyString(url, ValidationUtils.buildPointer([jsonPointer, 'url']));
  }

  void _validateDescription(String jsonPointer) {
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPointer([jsonPointer, 'description']));
    }
  }

  void _validateVariables(String jsonPointer) {
    if (json.containsKey('variables')) {
      ValidationUtils.requireMap(json['variables'], ValidationUtils.buildPointer([jsonPointer, 'variables']));
    }
  }

  void _validateNoUnknownFields(String jsonPointer) {
    ValidationUtils.validateNoUnknownFields(json, {'url', 'description', 'variables'}, jsonPointer, 'Server Object');
  }

  @override
  void createChildNodes() {
    createNode<ServerVariablesMapNode>(jsonKey: 'variables');
  }

  @override
  void createContent() {
    url = json['url'];
    description = json['description'];
    variables = $to.to<ServerVariablesMapNode>('variables');
    extensions = extractExtensions(json);
  }
}
