import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../../../validation_exception.dart';
import 'header.dart';
import 'media_type.dart';
import 'link.dart';

class ResponseNode extends OpenApiNode {
  ResponseNode(super.$id, super.json);

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

    // Check for $ref - if present, only validate $ref
    if (json.containsKey('\$ref')) {
      final refValue = ValidationUtils.requireString(json['\$ref'], ValidationUtils.buildPath(path, '\$ref'));
      ValidationUtils.validateRefFormat(refValue, ValidationUtils.buildPath(path, '\$ref'));
      // When $ref is present, no other properties should exist (except description per spec errata)
      ValidationUtils.validateNoUnknownFields(
        json,
        {'\$ref', 'description'},
        path,
        'Reference Object',
      );
      return;
    }

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
    // Handle $ref - if present, we don't create child nodes
    if (_handleRef()) {
      return;
    }

    // Create Header nodes
    if (json.containsKey('headers')) {
      final headersMap = json['headers'] as Map<String, dynamic>;
      headersNodes = {};
      for (final entry in headersMap.entries) {
        final headerName = entry.key.toString();
        if (headerName.startsWith('x-')) continue;

        final headerJson = entry.value as Map<String, dynamic>;
        final headerNode = HeaderNode(
          NodeId($id.document, ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, 'headers'), headerName)),
          headerJson
        );
        headersNodes![headerName] = headerNode;
        OpenApiGraph.i.addOpenApiNode(headerNode);
        OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, headerNode.$id.absolutePointer, 'headers/$headerName'));
        headerNode.create();
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
          NodeId($id.document, ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, 'links'), linkName)),
          linkJson,
        );
        linksNodes![linkName] = linkNode;
        OpenApiGraph.i.addOpenApiNode(linkNode);
        OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, linkNode.$id.absolutePointer, 'links/$linkName'));
        linkNode.create();
      }
    }
  }

  /// Handles $ref resolution. Returns true if $ref was present, false otherwise.
  bool _handleRef() {
    if (!json.containsKey('\$ref')) {
      return false;
    }

    final ref = json['\$ref'] as String;
    final resolved = OpenApiGraph.i.referenceResolver.parseReference(ref, $id.jsonPointer);

    // Load document
    Map<dynamic, dynamic> targetDoc;
    if (resolved.isExternal) {
      targetDoc = OpenApiGraph.i.referenceResolver.loadExternalDocument(resolved.documentPath);
    } else {
      targetDoc = OpenApiGraph.i.getLoadedDocument($id.document);
    }

    // Resolve pointer within document
    final targetJson = OpenApiGraph.i.referenceResolver.resolvePointer(targetDoc, resolved.jsonPointer);

    if (targetJson == null) {
      OpenApiGraph.i.validationContext.addException(
        OpenApiValidationException(
          $id.jsonPointer,
          'Reference not found: $ref',
          specReference: 'OpenAPI 3.0.0 - Reference Object',
          severity: ValidationSeverity.critical,
        ),
      );
      return true;
    }

    // For Response references, we don't create a separate node - the reference is transparent
    // The consumer will need to resolve this reference when accessing the content
    return true;
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
