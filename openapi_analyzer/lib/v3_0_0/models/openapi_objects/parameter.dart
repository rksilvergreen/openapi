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
import 'examples_map.dart';
import 'media_types_map.dart';

abstract class Parameter {
  String get name;
  ParameterLocation get in_;
  String? get description;
  bool get required_;
  bool get deprecated;
  bool get allowEmptyValue;
  ParameterStyle? get style;
  bool? get explode;
  bool get allowReserved;
  EffectiveSchema? get schema;
  dynamic get example;
  ExamplesMap? get examples;
  MediaTypesMap? get content;
  Map<String, dynamic>? get extensions;
}

class ParameterNode extends OpenApiNode with InternalNode, Referencable implements Parameter {
  ParameterNode(Map<String, dynamic> json, String document, String jsonPointer)
    : super(NodeId(document, jsonPointer), json);

  late final String name;
  late final ParameterLocation in_;
  late final String? description;
  late final bool required_;
  late final bool deprecated;
  late final bool allowEmptyValue;
  late final ParameterStyle? style;
  late final bool? explode;
  late final bool allowReserved;
  late final EffectiveSchema? schema;
  late final dynamic example;
  late final ExamplesMapNode? examples;
  late final MediaTypesMapNode? content;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
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
    ValidationUtils.requireString(name, ValidationUtils.buildPointer([jsonPointer, 'name']));
  }

  void _validateIn(String jsonPointer) {
    final inValue = ValidationUtils.requireField(json, 'in', jsonPointer);
    ValidationUtils.requireString(inValue, ValidationUtils.buildPointer([jsonPointer, 'in']));
    ValidationUtils.validateEnum(inValue as String, [
      'query',
      'header',
      'path',
      'cookie',
    ], ValidationUtils.buildPointer([jsonPointer, 'in']));

    // If in=path, required must be true
    if (inValue == 'path') {
      if (!json.containsKey('required') || json['required'] != true) {
        OpenApiGraph.i.validationContext.addException(
          OpenApiValidationException(
            ValidationUtils.buildPointer([jsonPointer, 'required']),
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
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPointer([jsonPointer, 'description']));
    }
  }

  void _validateRequired(String jsonPointer) {
    if (json.containsKey('required')) {
      ValidationUtils.requireBool(json['required'], ValidationUtils.buildPointer([jsonPointer, 'required']));
    }
  }

  void _validateDeprecated(String jsonPointer) {
    if (json.containsKey('deprecated')) {
      ValidationUtils.requireBool(json['deprecated'], ValidationUtils.buildPointer([jsonPointer, 'deprecated']));
    }
  }

  void _validateAllowEmptyValue(String jsonPointer) {
    if (json.containsKey('allowEmptyValue')) {
      ValidationUtils.requireBool(
        json['allowEmptyValue'],
        ValidationUtils.buildPointer([jsonPointer, 'allowEmptyValue']),
      );
    }
  }

  void _validateSchema(String jsonPointer) {
    if (json.containsKey('schema')) {
      ValidationUtils.requireMap(json['schema'], ValidationUtils.buildPointer([jsonPointer, 'schema']));
    }
  }

  void _validateStyle(String jsonPointer) {
    if (json.containsKey('style')) {
      ValidationUtils.requireString(json['style'], ValidationUtils.buildPointer([jsonPointer, 'style']));
    }
  }

  void _validateExplode(String jsonPointer) {
    if (json.containsKey('explode')) {
      ValidationUtils.requireBool(json['explode'], ValidationUtils.buildPointer([jsonPointer, 'explode']));
    }
  }

  void _validateAllowReserved(String jsonPointer) {
    if (json.containsKey('allowReserved')) {
      ValidationUtils.requireBool(json['allowReserved'], ValidationUtils.buildPointer([jsonPointer, 'allowReserved']));
    }
  }

  void _validateExamples(String jsonPointer) {
    if (json.containsKey('examples')) {
      ValidationUtils.requireMap(json['examples'], ValidationUtils.buildPointer([jsonPointer, 'examples']));
    }
  }

  void _validateContent(String jsonPointer) {
    if (json.containsKey('content')) {
      ValidationUtils.requireMap(json['content'], ValidationUtils.buildPointer([jsonPointer, 'content']));
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

  @override
  void createChildNodes() {
    createNode<SchemaNode>(jsonKey: 'schema');
    createNode<ExamplesMapNode>(jsonKey: 'examples');
    createNode<MediaTypesMapNode>(jsonKey: 'content');
  }

  @override
  void createContent() {
    name = json['name'];
    in_ = ParameterLocation.values.firstWhere((e) => e.value == json['in']);
    description = json['description'];
    required_ = json['required'] ?? false;
    deprecated = json['deprecated'] ?? false;
    allowEmptyValue = json['allowEmptyValue'] ?? false;
    style = json['style'] != null ? ParameterStyle.values.firstWhere((e) => e.value == json['style']) : null;
    explode = json['explode'];
    allowReserved = json['allowReserved'] ?? false;
    schema = $to.to<SchemaNode>('schema')?.effective;
    example = json['example'];
    examples = $to.to<ExamplesMapNode>('examples');
    content = $to.to<MediaTypesMapNode>('content');
    extensions = extractExtensions(json);
  }
}
