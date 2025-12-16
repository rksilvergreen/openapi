import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../referencable.dart';
import 'header.dart';
import 'media_type.dart';
import 'link.dart';

class ResponseNode extends OpenApiNode with Referencable {
  ResponseNode._(super.$id, super.json);

  factory ResponseNode(Map<String, dynamic> json, String document, String jsonPointer) =>
      Referencable.getNode<ResponseNode>(
        json,
        document,
        jsonPointer,
        (nodeId, json) => ResponseNode._(nodeId, json),
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

  late final Map<String, HeaderNode>? headersNodes;
  late final Map<String, MediaTypeNode>? contentNodes;
  late final Map<String, LinkNode>? linksNodes;

  late final Response content;

  void _validateStructure() {
    _structureValidated = true;
    final path = $id.jsonPointer;

    // Validate required: description (string)
    final description = ValidationUtils.requireField(json, 'description', path);
    ValidationUtils.requireString(description, ValidationUtils.buildPath(path, 'description'));

    // Validate optional: headers (object)
    if (json.containsKey('headers')) {
      ValidationUtils.requireMap(json['headers'], ValidationUtils.buildPath(path, 'headers'));
    }

    // Validate optional: content (object)
    if (json.containsKey('content')) {
      ValidationUtils.requireMap(json['content'], ValidationUtils.buildPath(path, 'content'));
    }

    // Validate optional: links (object)
    if (json.containsKey('links')) {
      ValidationUtils.requireMap(json['links'], ValidationUtils.buildPath(path, 'links'));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(
      json,
      {'description', 'headers', 'content', 'links'},
      path,
      'Response Object',
    );
  }
  void _createChildNodes() {
    // Create Header nodes
    if (json.containsKey('headers')) {
      final headersMap = json['headers'] as Map<String, dynamic>;
      headersNodes = {};
      for (final entry in headersMap.entries) {
        final headerName = entry.key.toString();
        if (headerName.startsWith('x-')) continue;

        final headerJson = entry.value as Map<String, dynamic>;
        final headerNode = HeaderNode(
          headerJson,
          $id.document,
          ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, 'headers'), headerName),
        );
        headersNodes![headerName] = headerNode;
        if (!OpenApiGraph.i.openApiNodes.containsKey(headerNode.$id.absolutePointer)) {
          OpenApiGraph.i.addOpenApiNode(headerNode);
          OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, headerNode.$id.absolutePointer, 'headers/$headerName'));
          headerNode.create();
        }
      }
    }

    // Create MediaType nodes for content
    if (json.containsKey('content')) {
      final contentMap = json['content'] as Map<String, dynamic>;
      contentNodes = {};
      for (final entry in contentMap.entries) {
        final mediaType = entry.key.toString();
        final mediaTypeJson = entry.value as Map<String, dynamic>;
        final mediaTypeNode = MediaTypeNode(
          NodeId($id.document, ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, 'content'), mediaType)),
          mediaTypeJson,
        );
        contentNodes![mediaType] = mediaTypeNode;
        OpenApiGraph.i.addOpenApiNode(mediaTypeNode);
        OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, mediaTypeNode.$id.absolutePointer, 'content/$mediaType'));
        mediaTypeNode.create();
      }
    }

    // Create Link nodes
    if (json.containsKey('links')) {
      final linksMap = json['links'] as Map<String, dynamic>;
      linksNodes = {};
      for (final entry in linksMap.entries) {
        final linkName = entry.key.toString();
        if (linkName.startsWith('x-')) continue;

        final linkJson = entry.value as Map<String, dynamic>;
        final linkNode = LinkNode(
          linkJson,
          $id.document,
          ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, 'links'), linkName),
        );
        linksNodes![linkName] = linkNode;
        if (!OpenApiGraph.i.openApiNodes.containsKey(linkNode.$id.absolutePointer)) {
          OpenApiGraph.i.addOpenApiNode(linkNode);
          OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, linkNode.$id.absolutePointer, 'links/$linkName'));
          linkNode.create();
        }
      }
    }
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
