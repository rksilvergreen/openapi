import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../node_creation_helpers.dart';
import 'media_type.dart';
import '../referencable.dart';

class RequestBodyNode extends OpenApiNode with Referencable {
  RequestBodyNode._(super.$id, super.json);

  factory RequestBodyNode(Map<String, dynamic> json, String document, String jsonPointer) =>
      Referencable.getNode<RequestBodyNode>(
        json,
        document,
        jsonPointer,
        (nodeId, json) => RequestBodyNode._(nodeId, json),
      );

  void create() {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final Map<String, MediaTypeNode> contentNodes;

  late final RequestBody content;

  void _validateStructure() {
    _structureValidated = true;
    final jsonPointer = $id.jsonPointer;

    _validateContent(jsonPointer);
    _validateDescription(jsonPointer);
    _validateRequired(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
  }

  void _validateContent(String jsonPointer) {
    final content = ValidationUtils.requireField(json, 'content', jsonPointer);
    ValidationUtils.requireMap(content, ValidationUtils.buildPointer([jsonPointer, 'content']));
  }

  void _validateDescription(String jsonPointer) {
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPointer([jsonPointer, 'description']));
    }
  }

  void _validateRequired(String jsonPointer) {
    if (json.containsKey('required')) {
      ValidationUtils.requireBool(json['required'], ValidationUtils.buildPointer([jsonPointer, 'required']));
    }
  }

  void _validateNoUnknownFields(String jsonPointer) {
    ValidationUtils.validateNoUnknownFields(
      json,
      {'description', 'content', 'required'},
      jsonPointer,
      'Request Body Object',
    );
  }

  void _createChildNodes() {
    _createContentNodes();
  }

  void _createContentNodes() {
    contentNodes = createMapNode<MediaTypeNode>(
      jsonKey: 'content',
      required: true,
      factory: ({required json, required document, required jsonPointer}) => MediaTypeNode(json, document, jsonPointer),
    )!;
  }

  void _createContent() {
    content = RequestBody._(
      $node: this,
      description: json['description'],
      required_: json['required'],
      extensions: extractExtensions(json),
    );
    _contentCreated = true;
  }
}

/// Describes a single request body.
class RequestBody {
  final RequestBodyNode $node;
  final String? description;
  Map<String, MediaType> get content => $node.contentNodes.map((k, v) => MapEntry(k, v.content));
  final bool required_;
  final Map<String, dynamic>? extensions;

  RequestBody._({required this.$node, this.description, this.required_ = false, this.extensions});
}
