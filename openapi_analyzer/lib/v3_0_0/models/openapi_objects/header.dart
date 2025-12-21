import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../../../validation_exception.dart';
import '../referencable.dart';
import '../node_creation_helpers.dart';
import 'enums.dart';
import 'schema/schema.dart';
import 'examples_map.dart';
import 'media_types_map.dart';
import 'schema/schema_map.dart';

/// Header Object follows the structure of the Parameter Object.
abstract class Header {
  String? get description;
  bool get required_;
  bool get deprecated;
  bool get allowEmptyValue;
  ParameterStyle? get style;
  bool? get explode;
  bool get allowReserved;
  SchemasMap? get schema;
  dynamic get example;
  ExamplesMap? get examples;
  MediaTypesMap? get content;
  Map<String, dynamic>? get extensions;
}

class HeaderNode extends Node with InternalNode, Referencable implements Header {
  HeaderNode(super.json, super.document, super.jsonPointer);

  late final String? description;
  late final bool required_;
  late final bool deprecated;
  late final bool allowEmptyValue;
  late final ParameterStyle? style;
  late final bool? explode;
  late final bool allowReserved;
  late final SchemasMapNode? schema;
  late final dynamic example;
  late final ExamplesMap? examples;
  late final MediaTypesMap? content;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
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

  void _validateStyle(String jsonPointer) {
    if (json.containsKey('style')) {
      ValidationUtils.validateEnum(
        ValidationUtils.requireString(json['style'], ValidationUtils.buildPointer([jsonPointer, 'style'])),
        ['simple'],
        ValidationUtils.buildPointer([jsonPointer, 'style']),
      );
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

  void _validateSchema(String jsonPointer) {
    if (json.containsKey('schema')) {
      ValidationUtils.requireMap(json['schema'], ValidationUtils.buildPointer([jsonPointer, 'schema']));
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

  @override
  void createChildNodes() {
    createNode<SchemaNode>(jsonKey: 'schema');
    createNode<ExamplesMapNode>(jsonKey: 'examples');
    createNode<MediaTypesMapNode>(jsonKey: 'content');
  }

  @override
  void createContent() {
    description = json['description'];
    required_ = json['required'];
    deprecated = json['deprecated'];
    allowEmptyValue = json['allowEmptyValue'];
    style = json['style'] != null ? ParameterStyle.values.firstWhere((e) => e.value == json['style']) : null;
    explode = json['explode'];
    allowReserved = json['allowReserved'];
    schema = $to.to<SchemasMapNode>('schema');
    example = json['example'];
    examples = $to.to<ExamplesMapNode>('examples');
    content = $to.to<MediaTypesMapNode>('content');
    extensions = extractExtensions(json);
  }
}
