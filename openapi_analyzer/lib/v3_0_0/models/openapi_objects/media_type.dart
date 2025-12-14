import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../../../validation_exception.dart';
import 'schema/schema_node.dart';
import 'schema/effective_schema/effective_schema.dart';
import 'example.dart';
import 'encoding.dart';

class MediaTypeNode extends OpenApiNode {
  MediaTypeNode(super.$id, super.json) {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final SchemaNode? schemaNode;
  late final Map<String, ExampleNode>? examplesNodes;
  late final Map<String, EncodingNode>? encodingNodes;

  late final MediaType content;

  void _validateStructure() {
    _structureValidated = true;
    final path = $id.relativePath;

    // All fields optional: schema, example, examples, encoding

    // Validate optional: schema (object)
    if (json.containsKey('schema')) {
      ValidationUtils.requireMap(json['schema'], ValidationUtils.buildPath(path, 'schema'));
    }

    // Validate optional: examples (object)
    if (json.containsKey('examples')) {
      ValidationUtils.requireMap(json['examples'], ValidationUtils.buildPath(path, 'examples'));
    }

    // Validate optional: encoding (object)
    if (json.containsKey('encoding')) {
      ValidationUtils.requireMap(json['encoding'], ValidationUtils.buildPath(path, 'encoding'));
    }

    // Validate mutual exclusivity: cannot have both example and examples
    if (json.containsKey('example') && json.containsKey('examples')) {
      OpenApiGraph.i.validationContext.addException(OpenApiValidationException(
        path,
        'Media Type Object cannot have both "example" and "examples" fields',
        specReference: 'OpenAPI 3.0.0 - Media Type Object',
        severity: ValidationSeverity.critical,
      ));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(
      json,
      {'schema', 'example', 'examples', 'encoding'},
      path,
      'Media Type Object',
    );
  }
  void _createChildNodes() {
    // Create Schema node (with RootEdge to mark it as a schema root)
    if (json.containsKey('schema')) {
      final schemaJson = json['schema'] as Map<String, dynamic>;
      schemaNode = SchemaNode(
        NodeId($id.document, ValidationUtils.buildPath($id.relativePath, 'schema')),
        schemaJson
      );
      OpenApiGraph.i.addSchemaNode(schemaNode!);
      // Use RootEdge to mark this as a schema root
      OpenApiGraph.i.addSchemaStructuralEdge(RootEdge($id.absolutePath, schemaNode!.$id.absolutePath));
    }

    // Create Example nodes
    if (json.containsKey('examples')) {
      final examplesMap = json['examples'] as Map<String, dynamic>;
      examplesNodes = {};
      for (final entry in examplesMap.entries) {
        final exampleName = entry.key.toString();
        if (exampleName.startsWith('x-')) continue;

        final exampleJson = entry.value as Map<String, dynamic>;
        final exampleNode = ExampleNode(
          NodeId($id.document, ValidationUtils.buildPath(ValidationUtils.buildPath($id.relativePath, 'examples'), exampleName)),
          exampleJson
        );
        examplesNodes![exampleName] = exampleNode;
        OpenApiGraph.i.addOpenApiNode(exampleNode);
        OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePath, exampleNode.$id.absolutePath, 'examples/$exampleName'));
      }
    }

    // Create Encoding nodes
    if (json.containsKey('encoding')) {
      final encodingMap = json['encoding'] as Map<String, dynamic>;
      encodingNodes = {};
      for (final entry in encodingMap.entries) {
        final propertyName = entry.key.toString();
        if (propertyName.startsWith('x-')) continue;

        final encodingJson = entry.value as Map<String, dynamic>;
        final encodingNode = EncodingNode(
          NodeId($id.document, ValidationUtils.buildPath(ValidationUtils.buildPath($id.relativePath, 'encoding'), propertyName)),
          encodingJson
        );
        encodingNodes![propertyName] = encodingNode;
        OpenApiGraph.i.addOpenApiNode(encodingNode);
        OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePath, encodingNode.$id.absolutePath, 'encoding/$propertyName'));
      }
    }
  }
  void _createContent() {
    content = MediaType._($node: this, example: json['example'], extensions: extractExtensions(json));
  }
}

/// Each Media Type Object provides schema and examples for the media type.
class MediaType {
  final MediaTypeNode $node;
  EffectiveSchema? get schema => $node.schemaNode?.effective;
  final dynamic example;
  Map<String, Example>? get examples => $node.examplesNodes?.map((k, v) => MapEntry(k, v.content));
  Map<String, Encoding>? get encoding => $node.encodingNodes?.map((k, v) => MapEntry(k, v.content));
  final Map<String, dynamic>? extensions;

  MediaType._({required this.$node, this.example, this.extensions});
}
