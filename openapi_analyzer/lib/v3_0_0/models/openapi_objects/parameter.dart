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

class ParameterNode extends OpenApiNode with Referencable {
  ParameterNode._(super.$id, super.json);

  factory ParameterNode(Map<String, dynamic> json, String document, String jsonPointer) =>
      Referencable.getNode<ParameterNode>(json, document, jsonPointer, (nodeId, json) => ParameterNode._(nodeId, json));

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
  late final Map<String, MediaTypeNode>? contentNodes;

  late final Parameter content;

  void _validateStructure() {
    _structureValidated = true;
    final jsonPointer = $id.jsonPointer;

    _validateName(jsonPointer);
    _validateIn(jsonPointer);
    _validateDescription(jsonPointer);
    _validateRequired(jsonPointer);
    _validateDeprecated(jsonPointer);
    _validateAllowEmptyValue(jsonPointer);
    _validateSchema(jsonPointer);
    _validateStyle(jsonPointer);
    _validateExplode(jsonPointer);
    _validateAllowReserved(jsonPointer);
    _validateExamples(jsonPointer);
    _validateContent(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
  }

  void _validateName(String jsonPointer) {
    final name = ValidationUtils.requireField(json, 'name', jsonPointer);
    ValidationUtils.requireString(name, ValidationUtils.buildPath(jsonPointer, 'name'));
  }

  void _validateIn(String jsonPointer) {
    final inValue = ValidationUtils.requireField(json, 'in', jsonPointer);
    ValidationUtils.requireString(inValue, ValidationUtils.buildPath(jsonPointer, 'in'));
    ValidationUtils.validateEnum(inValue as String, [
      'query',
      'header',
      'path',
      'cookie',
    ], ValidationUtils.buildPath(jsonPointer, 'in'));

    // If in=path, required must be true
    if (inValue == 'path') {
      if (!json.containsKey('required') || json['required'] != true) {
        OpenApiGraph.i.validationContext.addException(
          OpenApiValidationException(
            ValidationUtils.buildPath(jsonPointer, 'required'),
            'Parameter with in=path must have required=true',
            specReference: 'OpenAPI 3.0.0 - Parameter Object',
            severity: ValidationSeverity.critical,
          ),
        );
      }
    }
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

  void _validateSchema(String jsonPointer) {
    if (json.containsKey('schema')) {
      ValidationUtils.requireMap(json['schema'], ValidationUtils.buildPath(jsonPointer, 'schema'));
    }
  }

  void _validateStyle(String jsonPointer) {
    if (json.containsKey('style')) {
      ValidationUtils.requireString(json['style'], ValidationUtils.buildPath(jsonPointer, 'style'));
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

  void _validateNoUnknownFields(String jsonPointer) {
    ValidationUtils.validateNoUnknownFields(
      json,
      {
        'name',
        'in',
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
      'Parameter Object',
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
    examplesNodes = createMapNode<ExampleNode>(
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
    content = Parameter._(
      $node: this,
      name: json['name'],
      in_: ParameterLocation.values.firstWhere((e) => e.value == json['in']),
      description: json['description'],
      required_: json['required'],
      deprecated: json['deprecated'],
      allowEmptyValue: json['allowEmptyValue'],
      style: json['style'] != null ? ParameterStyle.values.firstWhere((e) => e.value == json['style']) : null,
      explode: json['explode'],
      allowReserved: json['allowReserved'],
      example: json['example'],
      content: json['content'],
      extensions: extractExtensions(json),
    );
    _contentCreated = true;
  }
}

/// Describes a single operation parameter.
class Parameter {
  final ParameterNode $node;
  final String name;
  final ParameterLocation in_;
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
  final Map<String, MediaType>? content;
  final Map<String, dynamic>? extensions;

  Parameter._({
    required this.$node,
    required this.name,
    required this.in_,
    this.description,
    this.required_ = false,
    this.deprecated = false,
    this.allowEmptyValue = false,
    this.style,
    this.explode,
    this.allowReserved = false,
    this.example,
    this.content,
    this.extensions,
  });
}
