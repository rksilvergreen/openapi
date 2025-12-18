import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../../../validation_exception.dart';
import '../node_creation_helpers.dart';
import 'schema/schema_node.dart';
import 'responses_map.dart';
import 'parameters_map.dart';
import 'examples_map.dart';
import 'request_bodies_map.dart';
import 'headers_map.dart';
import 'security_schemes_map.dart';
import 'links_map.dart';
import 'callbacks_map.dart';

abstract class Components {
  Map<String, SchemaNode>? get schemas;
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

class ComponentsNode extends OpenApiNode with InternalNode implements Components {
  ComponentsNode(super.json, super.document, super.jsonPointer);

  late final Map<String, SchemaNode>? schemas;
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
    _createSchemasNodes();
    createNode<ResponsesMapNode>(jsonKey: 'responses');
    createNode<ParametersMapNode>(jsonKey: 'parameters');
    createNode<ExamplesMapNode>(jsonKey: 'examples');
    createNode<RequestBodiesMapNode>(jsonKey: 'requestBodies');
    createNode<HeadersMapNode>(jsonKey: 'headers');
    createNode<SecuritySchemesMapNode>(jsonKey: 'securitySchemes');
    createNode<LinksMapNode>(jsonKey: 'links');
    createNode<CallbacksMapNode>(jsonKey: 'callbacks');
  }

  void _createSchemasNodes() {
    if (json.containsKey('schemas')) {
      final schemasMap = json['schemas'] as Map<String, dynamic>;
      for (final entry in schemasMap.entries) {
        final schemaName = entry.key.toString();
        final schemaJson = entry.value as Map<String, dynamic>;
        final schemaNode = SchemaNode(
          schemaJson,
          $id.document,
          ValidationUtils.buildPointer([$id.jsonPointer, 'schemas', schemaName]),
        );
        if (!OpenApiGraph.i.schemaNodes.containsKey(schemaNode.$id.absolutePointer)) {
          OpenApiGraph.i.addSchemaNode(schemaNode);
          OpenApiGraph.i.addSchemaStructuralEdge(RootEdge($id.absolutePointer, schemaNode.$id.absolutePointer));
          schemaNode.create();
        }
      }
    }
  }

  @override
  void createContent() {
    if (json.containsKey('schemas')) {
      final schemasMap = <String, SchemaNode>{};
      final schemasJson = json['schemas'] as Map<String, dynamic>;
      for (final entry in schemasJson.entries) {
        final schemaName = entry.key.toString();
        final schemaPointer = ValidationUtils.buildPointer([$id.jsonPointer, 'schemas', schemaName]);
        final schemaId = NodeId($id.document, schemaPointer);
        schemasMap[schemaName] = OpenApiGraph.i.schemaNodes[schemaId.absolutePointer]!;
      }
      schemas = schemasMap;
    } else {
      schemas = null;
    }
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
