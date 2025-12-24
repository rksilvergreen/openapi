import '../openapi_graph.dart';
import '../validation/validation_utils.dart';
import '../../validation_exception.dart';
import '../edge.dart';
import '../doc_node.dart';
import 'schema.dart';
import 'response.dart';
import 'parameter.dart';
import 'example.dart';
import 'request_body.dart';
import 'header.dart';
import 'security_scheme.dart';
import 'link.dart';
import 'callback.dart';

class ComponentsDocNode extends DocNode with DocInternalNode {
  ComponentsDocNode(super.json, super.document, super.jsonPointer);

  late final SchemasMapDocNode? schemas;
  late final ResponsesMapDocNode? responses;
  late final ParametersMapDocNode? parameters;
  late final ExamplesMapDocNode? examples;
  late final RequestBodiesMapDocNode? requestBodies;
  late final HeadersMapDocNode? headers;
  late final SecuritySchemesMapDocNode? securitySchemes;
  late final LinksMapDocNode? links;
  late final CallbacksMapDocNode? callbacks;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    _validateComponentTypes(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
  }

  void _validateComponentTypes(String jsonPointer) {
    final componentTypes = [
      'schemas',
      'responses',
      'parameters',
      'examples',
      'requestBodies',
      'headers',
      'securitySchemes',
      'links',
      'callbacks',
    ];

    final componentKeyPattern = r'^[a-zA-Z0-9\.\-_]+$';

    for (final componentType in componentTypes) {
      if (json.containsKey(componentType)) {
        _validateComponentType(jsonPointer, componentType, componentKeyPattern);
      }
    }
  }

  void _validateComponentType(String jsonPointer, String componentType, String componentKeyPattern) {
    final componentMap = ValidationUtils.requireMap(
      json[componentType],
      ValidationUtils.buildPointer([jsonPointer, componentType]),
    );

    for (final key in componentMap.keys) {
      final keyStr = key.toString();
      if (!RegExp(componentKeyPattern).hasMatch(keyStr)) {
        OpenApiGraph.i.validationContext.addException(
          OpenApiValidationException(
            ValidationUtils.buildPointer([jsonPointer, componentType, keyStr]),
            'Component key "$keyStr" must match pattern: $componentKeyPattern',
            specReference: 'OpenAPI 3.0.0 - Components Object',
            severity: ValidationSeverity.critical,
          ),
        );
      }

      ValidationUtils.requireMap(componentMap[key], ValidationUtils.buildPointer([jsonPointer, componentType, keyStr]));
    }
  }

  void _validateNoUnknownFields(String jsonPointer) {
    final componentTypes = [
      'schemas',
      'responses',
      'parameters',
      'examples',
      'requestBodies',
      'headers',
      'securitySchemes',
      'links',
      'callbacks',
    ];
    ValidationUtils.validateNoUnknownFields(json, componentTypes.toSet(), jsonPointer, 'Components Object');
  }

  @override
  void createChildNodes() {
    createNode<SchemaDocNode>(jsonKey: 'schemas');
    createNode<ResponsesMapDocNode>(jsonKey: 'responses');
    createNode<ParametersMapDocNode>(jsonKey: 'parameters');
    createNode<ExamplesMapDocNode>(jsonKey: 'examples');
    createNode<RequestBodiesMapDocNode>(jsonKey: 'requestBodies');
    createNode<HeadersMapDocNode>(jsonKey: 'headers');
    createNode<SecuritySchemesMapDocNode>(jsonKey: 'securitySchemes');
    createNode<LinksMapDocNode>(jsonKey: 'links');
    createNode<CallbacksMapDocNode>(jsonKey: 'callbacks');
  }

  @override
  void createContent() {
    schemas = $to.to<SchemasMapDocNode>('schemas');
    responses = $to.to<ResponsesMapDocNode>('responses');
    parameters = $to.to<ParametersMapDocNode>('parameters');
    examples = $to.to<ExamplesMapDocNode>('examples');
    requestBodies = $to.to<RequestBodiesMapDocNode>('requestBodies');
    headers = $to.to<HeadersMapDocNode>('headers');
    securitySchemes = $to.to<SecuritySchemesMapDocNode>('securitySchemes');
    links = $to.to<LinksMapDocNode>('links');
    callbacks = $to.to<CallbacksMapDocNode>('callbacks');
    extensions = extractExtensions(json);
  }
}
