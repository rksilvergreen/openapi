import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../../../validation_exception.dart';
import '../node_creation_helpers.dart';
import 'schema/schema_node.dart';
import 'schema/effective_schema/effective_schema.dart';
import 'example.dart';
import 'encoding.dart';

class MediaTypeNode extends OpenApiNode {
  MediaTypeNode(super.$id, super.json);

  void create() {
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
    final jsonPointer = $id.jsonPointer;

    _validateSchema(jsonPointer);
    _validateExamples(jsonPointer);
    _validateEncoding(jsonPointer);
    _validateExampleMutualExclusivity(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
  }

  void _validateSchema(String jsonPointer) {
    if (json.containsKey('schema')) {
      ValidationUtils.requireMap(json['schema'], ValidationUtils.buildPath(jsonPointer, 'schema'));
    }
  }

  void _validateExamples(String jsonPointer) {
    if (json.containsKey('examples')) {
      ValidationUtils.requireMap(json['examples'], ValidationUtils.buildPath(jsonPointer, 'examples'));
    }
  }

  void _validateEncoding(String jsonPointer) {
    if (json.containsKey('encoding')) {
      ValidationUtils.requireMap(json['encoding'], ValidationUtils.buildPath(jsonPointer, 'encoding'));
    }
  }

  void _validateExampleMutualExclusivity(String jsonPointer) {
    if (json.containsKey('example') && json.containsKey('examples')) {
      OpenApiGraph.i.validationContext.addException(
        OpenApiValidationException(
          jsonPointer,
          'Media Type Object cannot have both "example" and "examples" fields',
          specReference: 'OpenAPI 3.0.0 - Media Type Object',
          severity: ValidationSeverity.critical,
        ),
      );
    }
  }

  void _validateNoUnknownFields(String jsonPointer) {
    ValidationUtils.validateNoUnknownFields(
      json,
      {'schema', 'example', 'examples', 'encoding'},
      jsonPointer,
      'Media Type Object',
    );
  }

  void _createChildNodes() {
    _createSchemaNode();
    _createExamplesNodes();
    _createEncodingNodes();
  }

  void _createSchemaNode() {
    if (json.containsKey('schema')) {
      final schemaJson = json['schema'] as Map<String, dynamic>;
      schemaNode = SchemaNode(schemaJson, $id.document, ValidationUtils.buildPath($id.jsonPointer, 'schema'));
      if (!OpenApiGraph.i.schemaNodes.containsKey(schemaNode!.$id.absolutePointer)) {
        OpenApiGraph.i.addSchemaNode(schemaNode!);
        // Use RootEdge to mark this as a schema root
        OpenApiGraph.i.addSchemaStructuralEdge(RootEdge($id.absolutePointer, schemaNode!.$id.absolutePointer));
        schemaNode!.create();
      }
    }
  }

  void _createExamplesNodes() {
    examplesNodes = createReferencableMapNode<ExampleNode>(
      jsonKey: 'examples',
      factory: (json, document, jsonPointer) => ExampleNode(json, document, jsonPointer),
    );
  }

  void _createEncodingNodes() {
    encodingNodes = createMapNode<EncodingNode>(jsonKey: 'encoding', factory: (id, json) => EncodingNode(id, json));
  }

  void _createContent() {
    content = MediaType._($node: this, example: json['example'], extensions: extractExtensions(json));
    _contentCreated = true;
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
