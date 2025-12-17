import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import 'external_documentation.dart';

class TagNode extends OpenApiNode {
  TagNode(Map<String, dynamic> json, String document, String jsonPointer)
      : super(NodeId(document, jsonPointer), json);

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final ExternalDocumentationNode? externalDocsNode;

  late final Tag content;

  void create() {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  void _validateStructure() {
    _structureValidated = true;
    final jsonPointer = $id.jsonPointer;

    // Validate required: name (non-empty string)
    final name = ValidationUtils.requireField(json, 'name', jsonPointer);
    ValidationUtils.requireNonEmptyString(name, ValidationUtils.buildPointer([jsonPointer, 'name']));

    // Validate optional: description (string)
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPointer([jsonPointer, 'description']));
    }

    // Validate optional: externalDocs (object)
    if (json.containsKey('externalDocs')) {
      ValidationUtils.requireMap(json['externalDocs'], ValidationUtils.buildPointer([jsonPointer, 'externalDocs']));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(
      json,
      {'name', 'description', 'externalDocs'},
      jsonPointer,
      'Tag Object',
    );
  }
  void _createChildNodes() {
    // Create ExternalDocs node
    if (json.containsKey('externalDocs')) {
      final externalDocsJson = json['externalDocs'] as Map<String, dynamic>;
      externalDocsNode = ExternalDocumentationNode(
        externalDocsJson,
        $id.document,
        ValidationUtils.buildPointer([$id.jsonPointer, 'externalDocs']),
      );
      OpenApiGraph.i.addOpenApiNode(externalDocsNode!);
      OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, externalDocsNode!.$id.absolutePointer, 'externalDocs'));
      externalDocsNode!.create();
    }
  }

  void _createContent() {
    content = Tag._(
      $node: this,
      name: json['name'],
      description: json['description'],
      extensions: extractExtensions(json),
    );
    _contentCreated = true;
  }
}

/// Adds metadata to a single tag that is used by the Operation Object.
class Tag {
  final TagNode $node;
  final String name;
  final String? description;
  ExternalDocumentation? get externalDocs => $node.externalDocsNode?.content;
  final Map<String, dynamic>? extensions;

  Tag._({required this.$node, required this.name, this.description, this.extensions});
}
