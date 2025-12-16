import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../referencable.dart';
import '../node_creation_helpers.dart';
import 'header.dart';
import 'media_type.dart';
import 'link.dart';

class ResponseNode extends OpenApiNode with Referencable {
  ResponseNode._(super.$id, super.json);

  factory ResponseNode(Map<String, dynamic> json, String document, String jsonPointer) =>
      Referencable.getNode<ResponseNode>(json, document, jsonPointer, (nodeId, json) => ResponseNode._(nodeId, json));

  void create() {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final Map<String, HeaderNode>? headersNodes;
  late final Map<String, MediaTypeNode>? contentNodes;
  late final Map<String, LinkNode>? linksNodes;

  late final Response content;

  void _validateStructure() {
    _structureValidated = true;
    final jsonPointer = $id.jsonPointer;

    _validateDescription(jsonPointer);
    _validateHeaders(jsonPointer);
    _validateContent(jsonPointer);
    _validateLinks(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
  }

  void _validateDescription(String jsonPointer) {
    final description = ValidationUtils.requireField(json, 'description', jsonPointer);
    ValidationUtils.requireString(description, ValidationUtils.buildPath(jsonPointer, 'description'));
  }

  void _validateHeaders(String jsonPointer) {
    if (json.containsKey('headers')) {
      ValidationUtils.requireMap(json['headers'], ValidationUtils.buildPath(jsonPointer, 'headers'));
    }
  }

  void _validateContent(String jsonPointer) {
    if (json.containsKey('content')) {
      ValidationUtils.requireMap(json['content'], ValidationUtils.buildPath(jsonPointer, 'content'));
    }
  }

  void _validateLinks(String jsonPointer) {
    if (json.containsKey('links')) {
      ValidationUtils.requireMap(json['links'], ValidationUtils.buildPath(jsonPointer, 'links'));
    }
  }

  void _validateNoUnknownFields(String jsonPointer) {
    ValidationUtils.validateNoUnknownFields(
      json,
      {'description', 'headers', 'content', 'links'},
      jsonPointer,
      'Response Object',
    );
  }

  void _createChildNodes() {
    _createHeadersNodes();
    _createContentNodes();
    _createLinksNodes();
  }

  void _createHeadersNodes() {
    headersNodes = createReferencableMapNode<HeaderNode>(
      jsonKey: 'headers',
      factory: (json, document, jsonPointer) => HeaderNode(json, document, jsonPointer),
    );
  }

  void _createContentNodes() {
    contentNodes = createMapNode<MediaTypeNode>(jsonKey: 'content', factory: (id, json) => MediaTypeNode(id, json));
  }

  void _createLinksNodes() {
    linksNodes = createReferencableMapNode<LinkNode>(
      jsonKey: 'links',
      factory: (json, document, jsonPointer) => LinkNode(json, document, jsonPointer),
    );
  }

  void _createContent() {
    content = Response._($node: this, description: json['description'], extensions: extractExtensions(json));
    _contentCreated = true;
  }
}

/// Describes a single response from an API Operation.
class Response {
  final ResponseNode $node;
  final String description;
  Map<String, Header>? get headers => $node.headersNodes?.map((k, v) => MapEntry(k, v.content));
  Map<String, MediaType>? get content => $node.contentNodes?.map((k, v) => MapEntry(k, v.content));
  Map<String, Link>? get links => $node.linksNodes?.map((k, v) => MapEntry(k, v.content));
  final Map<String, dynamic>? extensions;

  Response._({required this.$node, required this.description, this.extensions});
}
