import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../../../validation_exception.dart';
import '../node_creation_helpers.dart';
import 'schema/schema_node.dart';
import 'schema/effective_schema/effective_schema.dart';
import 'example.dart';
import 'encoding.dart';
import 'examples_map.dart';
import 'encodings_map.dart';

abstract class MediaType {
  EffectiveSchema? get schema;
  dynamic get example;
  ExamplesMap? get examples;
  EncodingsMap? get encoding;
  Map<String, dynamic>? get extensions;
}

class MediaTypeNode extends OpenApiNode with InternalNode implements MediaType {
  MediaTypeNode(super.json, super.document, super.jsonPointer);

  late final EffectiveSchema? schema;
  late final dynamic example;
  late final ExamplesMapNode? examples;
  late final EncodingsMapNode? encoding;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    _validateSchema(jsonPointer);
    _validateExamples(jsonPointer);
    _validateEncoding(jsonPointer);
    _validateExampleMutualExclusivity(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
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

  void _validateEncoding(String jsonPointer) {
    if (json.containsKey('encoding')) {
      ValidationUtils.requireMap(json['encoding'], ValidationUtils.buildPointer([jsonPointer, 'encoding']));
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

  @override
  void createChildNodes() {
    createNode<SchemaNode>(jsonKey: 'schema');
    createNode<ExamplesMapNode>(jsonKey: 'examples');
    createNode<EncodingsMapNode>(jsonKey: 'encoding');
  }

  @override
  void createContent() {
    schema = $to.to<SchemaNode>('schema');
    example = json['example'];
    examples = $to.to<ExamplesMapNode>('examples');
    encoding = $to.to<EncodingsMapNode>('encoding');
    extensions = extractExtensions(json);
  }
}
