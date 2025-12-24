import '../openapi_graph.dart';
import '../validation/validation_utils.dart';
import '../../validation_exception.dart';
import '../doc_node.dart';
import '../edge.dart';
import 'schema.dart';
import 'example.dart';
import 'encoding.dart';
import '../map_doc_node.dart';

class MediaTypeDocNode extends DocNode with DocInternalNode {
  MediaTypeDocNode(super.json, super.document, super.jsonPointer);

  late final SchemasMapDocNode? schema;
  late final dynamic example;
  late final ExamplesMapDocNode? examples;
  late final EncodingsMapDocNode? encoding;
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
    createNode<SchemaDocNode>(jsonKey: 'schema');
    createNode<ExamplesMapDocNode>(jsonKey: 'examples');
    createNode<EncodingsMapDocNode>(jsonKey: 'encoding');
  }

  @override
  void createContent() {
    schema = $to.to<SchemasMapDocNode>('schema');
    example = json['example'];
    examples = $to.to<ExamplesMapDocNode>('examples');
    encoding = $to.to<EncodingsMapDocNode>('encoding');
    extensions = extractExtensions(json);
  }
}

class MediaTypesMapDocNode extends MapDocNode<MediaTypeDocNode> {
  MediaTypesMapDocNode(super.json, super.document, super.jsonPointer);
}
