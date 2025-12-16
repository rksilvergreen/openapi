import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
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
    final path = $id.jsonPointer;

    // Validate required: content (map of MediaType objects)
    final content = ValidationUtils.requireField(json, 'content', path);
    ValidationUtils.requireMap(content, ValidationUtils.buildPath(path, 'content'));

    // Validate optional: description (string)
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPath(path, 'description'));
    }

    // Validate optional: required (boolean)
    if (json.containsKey('required')) {
      ValidationUtils.requireBool(json['required'], ValidationUtils.buildPath(path, 'required'));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(json, {'description', 'content', 'required'}, path, 'Request Body Object');
  }

  void _createChildNodes() {
    // Create MediaType nodes for content
    final contentMap = json['content'] as Map<String, dynamic>;
    contentNodes = {};
    for (final entry in contentMap.entries) {
      final mediaType = entry.key.toString();
      final mediaTypeJson = entry.value as Map<String, dynamic>;
      final mediaTypeNode = MediaTypeNode(
        NodeId(
          $id.document,
          ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, 'content'), mediaType),
        ),
        mediaTypeJson,
      );
      contentNodes[mediaType] = mediaTypeNode;
      OpenApiGraph.i.addOpenApiNode(mediaTypeNode);
      OpenApiGraph.i.addOpenApiEdge(
        OpenApiEdge($id.absolutePointer, mediaTypeNode.$id.absolutePointer, 'content/$mediaType'),
      );
      mediaTypeNode.create();
    }
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
