import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../../../validation_exception.dart';
import '../node_creation_helpers.dart';
import 'schema/schema_node.dart';
import 'response.dart';
import 'parameter.dart';
import 'example.dart';
import 'request_body.dart';
import 'header.dart';
import 'security_scheme.dart';
import 'link.dart';
import 'callback.dart';

class ComponentsNode extends OpenApiNode {
  ComponentsNode(Map<String, dynamic> json, String document, String jsonPointer)
    : super(NodeId(document, jsonPointer), json);

  void create() {
    _validateStructure();
    _createChildNodes();
    _createContent();
  }

  bool _structureValidated = false;
  bool _contentCreated = false;

  bool get structureValidated => _structureValidated;
  bool get contentCreated => _contentCreated;

  late final Map<String, SchemaNode>? schemasNodes;
  late final Map<String, ResponseNode>? responsesNodes;
  late final Map<String, ParameterNode>? parametersNodes;
  late final Map<String, ExampleNode>? examplesNodes;
  late final Map<String, RequestBodyNode>? requestBodiesNodes;
  late final Map<String, HeaderNode>? headersNodes;
  late final Map<String, SecuritySchemeNode>? securitySchemesNodes;
  late final Map<String, LinkNode>? linksNodes;
  late final Map<String, CallbackNode>? callbacksNodes;

  late final Components content;

  void _validateStructure() {
    _structureValidated = true;
    final jsonPointer = $id.jsonPointer;

    // All fields optional: schemas, responses, parameters, examples, requestBodies,
    // headers, securitySchemes, links, callbacks

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

    // Component key pattern: ^[a-zA-Z0-9\.\-_]+$
    final componentKeyPattern = r'^[a-zA-Z0-9\.\-_]+$';

    for (final componentType in componentTypes) {
      if (json.containsKey(componentType)) {
        final componentMap = ValidationUtils.requireMap(
          json[componentType],
          ValidationUtils.buildPath(jsonPointer, componentType),
        );

        // Validate each component key matches pattern
        for (final key in componentMap.keys) {
          final keyStr = key.toString();
          if (!RegExp(componentKeyPattern).hasMatch(keyStr)) {
            OpenApiGraph.i.validationContext.addException(
              OpenApiValidationException(
                ValidationUtils.buildPath(ValidationUtils.buildPath(jsonPointer, componentType), keyStr),
                'Component key "$keyStr" must match pattern: $componentKeyPattern',
                specReference: 'OpenAPI 3.0.0 - Components Object',
                severity: ValidationSeverity.critical,
              ),
            );
          }

          // Validate component value is an object
          ValidationUtils.requireMap(
            componentMap[key],
            ValidationUtils.buildPath(ValidationUtils.buildPath(jsonPointer, componentType), keyStr),
          );
        }
      }
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(json, componentTypes.toSet(), jsonPointer, 'Components Object');
  }

  void _createChildNodes() {
    // Create Schema nodes
    if (json.containsKey('schemas')) {
      final schemasMap = json['schemas'] as Map<String, dynamic>;
      schemasNodes = {};
      for (final entry in schemasMap.entries) {
        final schemaName = entry.key.toString();

        final schemaJson = entry.value as Map<String, dynamic>;
        final schemaNode = SchemaNode(
          schemaJson,
          $id.document,
          ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, 'schemas'), schemaName),
        );
        schemasNodes![schemaName] = schemaNode;
        if (!OpenApiGraph.i.schemaNodes.containsKey(schemaNode.$id.absolutePointer)) {
          OpenApiGraph.i.addSchemaNode(schemaNode);
          OpenApiGraph.i.addSchemaStructuralEdge(RootEdge($id.absolutePointer, schemaNode.$id.absolutePointer));
          schemaNode.create();
        }
      }
    }

    // Create Response nodes
    responsesNodes = createMapNode<ResponseNode>(
      jsonKey: 'responses',
      factory: ({required json, required document, required jsonPointer}) => ResponseNode(json, document, jsonPointer),
    );

    // Create Parameter nodes
    parametersNodes = createMapNode<ParameterNode>(
      jsonKey: 'parameters',
      factory: ({required json, required document, required jsonPointer}) => ParameterNode(json, document, jsonPointer),
    );

    // Create Example nodes
    examplesNodes = createMapNode<ExampleNode>(
      jsonKey: 'examples',
      factory: ({required json, required document, required jsonPointer}) => ExampleNode(json, document, jsonPointer),
    );

    // Create RequestBody nodes
    requestBodiesNodes = createMapNode<RequestBodyNode>(
      jsonKey: 'requestBodies',
      factory: ({required json, required document, required jsonPointer}) =>
          RequestBodyNode(json, document, jsonPointer),
    );

    // Create Header nodes
    headersNodes = createMapNode<HeaderNode>(
      jsonKey: 'headers',
      factory: ({required json, required document, required jsonPointer}) => HeaderNode(json, document, jsonPointer),
    );

    // Create SecurityScheme nodes
    securitySchemesNodes = createMapNode<SecuritySchemeNode>(
      jsonKey: 'securitySchemes',
      factory: ({required json, required document, required jsonPointer}) =>
          SecuritySchemeNode(json, document, jsonPointer),
    );

    // Create Link nodes
    linksNodes = createMapNode<LinkNode>(
      jsonKey: 'links',
      factory: ({required json, required document, required jsonPointer}) => LinkNode(json, document, jsonPointer),
    );

    // Create Callback nodes
    callbacksNodes = createMapNode<CallbackNode>(
      jsonKey: 'callbacks',
      factory: ({required json, required document, required jsonPointer}) => CallbackNode(json, document, jsonPointer),
    );
  }

  void _createContent() {
    content = Components._($node: this, extensions: extractExtensions(json));
    _contentCreated = true;
  }
}

/// Holds a set of reusable objects for different aspects of the OAS.
class Components {
  final ComponentsNode $node;
  Map<String, SchemaNode>? get schemas => $node.schemasNodes;
  Map<String, Response>? get responses => $node.responsesNodes?.map((k, v) => MapEntry(k, v.content));
  Map<String, Parameter>? get parameters => $node.parametersNodes?.map((k, v) => MapEntry(k, v.content));
  Map<String, Example>? get examples => $node.examplesNodes?.map((k, v) => MapEntry(k, v.content));
  Map<String, RequestBody>? get requestBodies => $node.requestBodiesNodes?.map((k, v) => MapEntry(k, v.content));
  Map<String, Header>? get headers => $node.headersNodes?.map((k, v) => MapEntry(k, v.content));
  Map<String, SecurityScheme>? get securitySchemes => $node.securitySchemesNodes?.map((k, v) => MapEntry(k, v.content));
  Map<String, Link>? get links => $node.linksNodes?.map((k, v) => MapEntry(k, v.content));
  Map<String, Callback>? get callbacks => $node.callbacksNodes?.map((k, v) => MapEntry(k, v.content));
  final Map<String, dynamic>? extensions;

  Components._({required this.$node, this.extensions});
}
