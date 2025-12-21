import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../../../validation_exception.dart';
import '../node_creation_helpers.dart';
import 'schema/schema.dart';
import 'responses_map.dart';
import 'parameters_map.dart';
import 'examples_map.dart';
import 'request_bodies_map.dart';
import 'headers_map.dart';
import 'security_schemes_map.dart';
import 'links_map.dart';
import 'callbacks_map.dart';
import 'schema/schema_map.dart';

abstract class Components {
  SchemasMap? get schemas;
  ResponsesMap? get responses;
  ParametersMap? get parameters;
  ExamplesMap? get examples;
  RequestBodiesMap? get requestBodies;
  HeadersMap? get headers;
  SecuritySchemesMap? get securitySchemes;
  LinksMap? get links;
  CallbacksMap? get callbacks;
  Map<String, dynamic>? get extensions;
}

class ComponentsNode extends Node with InternalNode implements Components {
  ComponentsNode(super.json, super.document, super.jsonPointer);

  late final SchemasMapNode? schemas;
  late final ResponsesMapNode? responses;
  late final ParametersMapNode? parameters;
  late final ExamplesMapNode? examples;
  late final RequestBodiesMapNode? requestBodies;
  late final HeadersMapNode? headers;
  late final SecuritySchemesMapNode? securitySchemes;
  late final LinksMapNode? links;
  late final CallbacksMapNode? callbacks;
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
    createNode<SchemaNode>(jsonKey: 'schemas');
    createNode<ResponsesMapNode>(jsonKey: 'responses');
    createNode<ParametersMapNode>(jsonKey: 'parameters');
    createNode<ExamplesMapNode>(jsonKey: 'examples');
    createNode<RequestBodiesMapNode>(jsonKey: 'requestBodies');
    createNode<HeadersMapNode>(jsonKey: 'headers');
    createNode<SecuritySchemesMapNode>(jsonKey: 'securitySchemes');
    createNode<LinksMapNode>(jsonKey: 'links');
    createNode<CallbacksMapNode>(jsonKey: 'callbacks');
  }

  @override
  void createContent() {
    schemas = $to.to<SchemasMapNode>('schemas');
    responses = $to.to<ResponsesMapNode>('responses');
    parameters = $to.to<ParametersMapNode>('parameters');
    examples = $to.to<ExamplesMapNode>('examples');
    requestBodies = $to.to<RequestBodiesMapNode>('requestBodies');
    headers = $to.to<HeadersMapNode>('headers');
    securitySchemes = $to.to<SecuritySchemesMapNode>('securitySchemes');
    links = $to.to<LinksMapNode>('links');
    callbacks = $to.to<CallbacksMapNode>('callbacks');
    extensions = extractExtensions(json);
  }
}
