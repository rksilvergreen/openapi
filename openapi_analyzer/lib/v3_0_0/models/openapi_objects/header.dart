import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../../../validation_exception.dart';
import '../referencable.dart';
import '../node_creation_helpers.dart';
import 'enums.dart';
import 'schema/schema_node.dart';
import 'schema/effective_schema/effective_schema.dart';
import 'example.dart';
import 'media_type.dart';

class HeaderNode extends OpenApiNode with Referencable {
  HeaderNode._(super.$id, super.json);

  factory HeaderNode(Map<String, dynamic> json, String document, String jsonPointer) =>
      Referencable.getNode<HeaderNode>(json, document, jsonPointer, (nodeId, json) => HeaderNode._(nodeId, json));

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final SchemaNode? schemaNode;
  late final Map<String, ExampleNode>? examplesNodes;
  late final Map<String, MediaTypeNode>? contentNodes;

  late final Header content;

  void create() {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  void _validateStructure() {
    final jsonPointer = $id.jsonPointer;

    _validateDescription(jsonPointer);
    _validateRequired(jsonPointer);
    _validateDeprecated(jsonPointer);
    _validateAllowEmptyValue(jsonPointer);
    _validateStyle(jsonPointer);
    _validateExplode(jsonPointer);
    _validateAllowReserved(jsonPointer);
    _validateSchema(jsonPointer);
    _validateExamples(jsonPointer);
    _validateContent(jsonPointer);
    _validateExampleMutualExclusivity(jsonPointer);
    _validateNoUnknownFields(jsonPointer);

    _structureValidated = true;
  }

  void _validateDescription(String jsonPointer) {
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPath(jsonPointer, 'description'));
    }
  }

  void _validateRequired(String jsonPointer) {
    if (json.containsKey('required')) {
      ValidationUtils.requireBool(json['required'], ValidationUtils.buildPath(jsonPointer, 'required'));
    }
  }

  void _validateDeprecated(String jsonPointer) {
    if (json.containsKey('deprecated')) {
      ValidationUtils.requireBool(json['deprecated'], ValidationUtils.buildPath(jsonPointer, 'deprecated'));
    }
  }

  void _validateAllowEmptyValue(String jsonPointer) {
    if (json.containsKey('allowEmptyValue')) {
      ValidationUtils.requireBool(json['allowEmptyValue'], ValidationUtils.buildPath(jsonPointer, 'allowEmptyValue'));
    }
  }

  void _validateStyle(String jsonPointer) {
    if (json.containsKey('style')) {
      ValidationUtils.validateEnum(
        ValidationUtils.requireString(json['style'], ValidationUtils.buildPath(jsonPointer, 'style')),
        ['simple'],
        ValidationUtils.buildPath(jsonPointer, 'style'),
      );
    }
  }

  void _validateExplode(String jsonPointer) {
    if (json.containsKey('explode')) {
      ValidationUtils.requireBool(json['explode'], ValidationUtils.buildPath(jsonPointer, 'explode'));
    }
  }

  void _validateAllowReserved(String jsonPointer) {
    if (json.containsKey('allowReserved')) {
      ValidationUtils.requireBool(json['allowReserved'], ValidationUtils.buildPath(jsonPointer, 'allowReserved'));
    }
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

  void _validateContent(String jsonPointer) {
    if (json.containsKey('content')) {
      ValidationUtils.requireMap(json['content'], ValidationUtils.buildPath(jsonPointer, 'content'));
    }
  }

  void _validateExampleMutualExclusivity(String jsonPointer) {
    if (json.containsKey('example') && json.containsKey('examples')) {
      OpenApiGraph.i.validationContext.addException(
        OpenApiValidationException(
          jsonPointer,
          'Header Object cannot have both "example" and "examples"',
          specReference: 'OpenAPI 3.0.0 - Header Object',
          severity: ValidationSeverity.critical,
        ),
      );
    }
  }

  void _validateNoUnknownFields(String jsonPointer) {
    ValidationUtils.validateNoUnknownFields(
      json,
      {
        'description',
        'required',
        'deprecated',
        'allowEmptyValue',
        'style',
        'explode',
        'allowReserved',
        'schema',
        'example',
        'examples',
        'content',
      },
      jsonPointer,
      'Header Object',
    );
  }

  void _createChildNodes() {
    _createSchemaNode();
    _createExamplesNodes();
    _createContentNodes();
  }

  void _createSchemaNode() {
    if (json.containsKey('schema')) {
      final schemaJson = json['schema'] as Map<String, dynamic>;
      schemaNode = SchemaNode(schemaJson, $id.document, ValidationUtils.buildPath($id.jsonPointer, 'schema'));
      if (!OpenApiGraph.i.schemaNodes.containsKey(schemaNode!.$id.absolutePointer)) {
        OpenApiGraph.i.addSchemaNode(schemaNode!);
        OpenApiGraph.i.addSchemaStructuralEdge(RootEdge($id.absolutePointer, schemaNode!.$id.absolutePointer));
        schemaNode!.create();
      }
    }
  }

  void _createExamplesNodes() {
    examplesNodes = createReferencableMapNode<ExampleNode>(
      jsonKey: 'examples',
      factory: ({required json, required document, required jsonPointer}) => ExampleNode(json, document, jsonPointer),
    );
  }

  void _createContentNodes() {
    contentNodes = createMapNode<MediaTypeNode>(
      jsonKey: 'content',
      factory: ({required json, required document, required jsonPointer}) => MediaTypeNode(json, document, jsonPointer),
    );
  }

  void _createContent() {
    content = Header._(
      $node: this,
      description: json['description'],
      required_: json['required'],
      deprecated: json['deprecated'],
      allowEmptyValue: json['allowEmptyValue'],
      style: json['style'] != null ? ParameterStyle.values.firstWhere((e) => e.value == json['style']) : null,
      explode: json['explode'],
      allowReserved: json['allowReserved'],
      example: json['example'],
      extensions: extractExtensions(json),
    );
    _contentCreated = true;
  }
}

/// Header Object follows the structure of the Parameter Object.
class Header {
  final HeaderNode $node;
  final String? description;
  final bool required_;
  final bool deprecated;
  final bool allowEmptyValue;
  final ParameterStyle? style;
  final bool? explode;
  final bool allowReserved;
  EffectiveSchema? get schema => $node.schemaNode?.effective;
  final dynamic example;
  Map<String, Example>? get examples => $node.examplesNodes?.map((k, v) => MapEntry(k, v.content));
  Map<String, MediaType>? get content => $node.contentNodes?.map((k, v) => MapEntry(k, v.content));
  final Map<String, dynamic>? extensions;

  Header._({
    required this.$node,
    this.description,
    this.required_ = false,
    this.deprecated = false,
    this.allowEmptyValue = false,
    this.style,
    this.explode,
    this.allowReserved = false,
    this.example,
    this.extensions,
  });
}
