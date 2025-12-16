import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../../../validation_exception.dart';
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
  ComponentsNode(super.$id, super.json);

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
    final path = $id.jsonPointer;

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
          ValidationUtils.buildPath(path, componentType),
        );

        // Validate each component key matches pattern
        for (final key in componentMap.keys) {
          final keyStr = key.toString();
          if (!RegExp(componentKeyPattern).hasMatch(keyStr)) {
            OpenApiGraph.i.validationContext.addException(
              OpenApiValidationException(
                ValidationUtils.buildPath(ValidationUtils.buildPath(path, componentType), keyStr),
                'Component key "$keyStr" must match pattern: $componentKeyPattern',
                specReference: 'OpenAPI 3.0.0 - Components Object',
                severity: ValidationSeverity.critical,
              ),
            );
          }

          // Validate component value is an object
          ValidationUtils.requireMap(
            componentMap[key],
            ValidationUtils.buildPath(ValidationUtils.buildPath(path, componentType), keyStr),
          );
        }
      }
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(json, componentTypes.toSet(), path, 'Components Object');
  }

  void _createChildNodes() {
    // Create Schema nodes
    if (json.containsKey('schemas')) {
      final schemasMap = json['schemas'] as Map<String, dynamic>;
      schemasNodes = {};
      for (final entry in schemasMap.entries) {
        final schemaName = entry.key.toString();
        if (schemaName.startsWith('x-')) continue;

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
    if (json.containsKey('responses')) {
      final responsesMap = json['responses'] as Map<String, dynamic>;
      responsesNodes = {};
      for (final entry in responsesMap.entries) {
        final responseName = entry.key.toString();
        if (responseName.startsWith('x-')) continue;

        final responseJson = entry.value as Map<String, dynamic>;
        final responseNode = ResponseNode(
          responseJson,
          $id.document,
          ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, 'responses'), responseName),
        );
        responsesNodes![responseName] = responseNode;
        if (!OpenApiGraph.i.openApiNodes.containsKey(responseNode.$id.absolutePointer)) {
          OpenApiGraph.i.addOpenApiNode(responseNode);
          OpenApiGraph.i.addOpenApiEdge(
            OpenApiEdge($id.absolutePointer, responseNode.$id.absolutePointer, 'responses/$responseName'),
          );
          responseNode.create();
        }
      }
    }

    // Create Parameter nodes
    if (json.containsKey('parameters')) {
      final parametersMap = json['parameters'] as Map<String, dynamic>;
      parametersNodes = {};
      for (final entry in parametersMap.entries) {
        final parameterName = entry.key.toString();
        if (parameterName.startsWith('x-')) continue;

        final parameterJson = entry.value as Map<String, dynamic>;
        final parameterNode = ParameterNode(
          parameterJson,
          $id.document,
          ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, 'parameters'), parameterName),
        );
        parametersNodes![parameterName] = parameterNode;
        if (!OpenApiGraph.i.openApiNodes.containsKey(parameterNode.$id.absolutePointer)) {
          OpenApiGraph.i.addOpenApiNode(parameterNode);
          OpenApiGraph.i.addOpenApiEdge(
            OpenApiEdge($id.absolutePointer, parameterNode.$id.absolutePointer, 'parameters/$parameterName'),
          );
          parameterNode.create();
        }
      }
    }

    // Create Example nodes
    if (json.containsKey('examples')) {
      final examplesMap = json['examples'] as Map<String, dynamic>;
      examplesNodes = {};
      for (final entry in examplesMap.entries) {
        final exampleName = entry.key.toString();
        if (exampleName.startsWith('x-')) continue;

        final exampleJson = entry.value as Map<String, dynamic>;
        final exampleNode = ExampleNode(
          exampleJson,
          $id.document,
          ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, 'examples'), exampleName),
        );
        examplesNodes![exampleName] = exampleNode;
        if (!OpenApiGraph.i.openApiNodes.containsKey(exampleNode.$id.absolutePointer)) {
          OpenApiGraph.i.addOpenApiNode(exampleNode);
          OpenApiGraph.i.addOpenApiEdge(
            OpenApiEdge($id.absolutePointer, exampleNode.$id.absolutePointer, 'examples/$exampleName'),
          );
          exampleNode.create();
        }
      }
    }

    // Create RequestBody nodes
    if (json.containsKey('requestBodies')) {
      final requestBodiesMap = json['requestBodies'] as Map<String, dynamic>;
      requestBodiesNodes = {};
      for (final entry in requestBodiesMap.entries) {
        final requestBodyName = entry.key.toString();
        if (requestBodyName.startsWith('x-')) continue;

        final requestBodyJson = entry.value as Map<String, dynamic>;
        final requestBodyNode = RequestBodyNode(
          requestBodyJson,
          $id.document,
          ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, 'requestBodies'), requestBodyName),
        );
        requestBodiesNodes![requestBodyName] = requestBodyNode;
        if (!OpenApiGraph.i.openApiNodes.containsKey(requestBodyNode.$id.absolutePointer)) {
          OpenApiGraph.i.addOpenApiNode(requestBodyNode);
          OpenApiGraph.i.addOpenApiEdge(
            OpenApiEdge($id.absolutePointer, requestBodyNode.$id.absolutePointer, 'requestBodies/$requestBodyName'),
          );
          requestBodyNode.create();
        }
      }
    }

    // Create Header nodes
    if (json.containsKey('headers')) {
      final headersMap = json['headers'] as Map<String, dynamic>;
      headersNodes = {};
      for (final entry in headersMap.entries) {
        final headerName = entry.key.toString();
        if (headerName.startsWith('x-')) continue;

        final headerJson = entry.value as Map<String, dynamic>;
        final headerNode = HeaderNode(
          headerJson,
          $id.document,
          ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, 'headers'), headerName),
        );
        headersNodes![headerName] = headerNode;
        if (!OpenApiGraph.i.openApiNodes.containsKey(headerNode.$id.absolutePointer)) {
          OpenApiGraph.i.addOpenApiNode(headerNode);
          OpenApiGraph.i.addOpenApiEdge(
            OpenApiEdge($id.absolutePointer, headerNode.$id.absolutePointer, 'headers/$headerName'),
          );
          headerNode.create();
        }
      }
    }

    // Create SecurityScheme nodes
    if (json.containsKey('securitySchemes')) {
      final securitySchemesMap = json['securitySchemes'] as Map<String, dynamic>;
      securitySchemesNodes = {};
      for (final entry in securitySchemesMap.entries) {
        final schemeName = entry.key.toString();
        if (schemeName.startsWith('x-')) continue;

        final schemeJson = entry.value as Map<String, dynamic>;
        final schemeNode = SecuritySchemeNode(
          schemeJson,
          $id.document,
          ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, 'securitySchemes'), schemeName),
        );
        securitySchemesNodes![schemeName] = schemeNode;
        if (!OpenApiGraph.i.openApiNodes.containsKey(schemeNode.$id.absolutePointer)) {
          OpenApiGraph.i.addOpenApiNode(schemeNode);
          OpenApiGraph.i.addOpenApiEdge(
            OpenApiEdge($id.absolutePointer, schemeNode.$id.absolutePointer, 'securitySchemes/$schemeName'),
          );
          schemeNode.create();
        }
      }
    }

    // Create Link nodes
    if (json.containsKey('links')) {
      final linksMap = json['links'] as Map<String, dynamic>;
      linksNodes = {};
      for (final entry in linksMap.entries) {
        final linkName = entry.key.toString();
        if (linkName.startsWith('x-')) continue;

        final linkJson = entry.value as Map<String, dynamic>;
        final linkNode = LinkNode(
          linkJson,
          $id.document,
          ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, 'links'), linkName),
        );
        linksNodes![linkName] = linkNode;
        if (!OpenApiGraph.i.openApiNodes.containsKey(linkNode.$id.absolutePointer)) {
          OpenApiGraph.i.addOpenApiNode(linkNode);
          OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePointer, linkNode.$id.absolutePointer, 'links/$linkName'));
          linkNode.create();
        }
      }
    }

    // Create Callback nodes
    if (json.containsKey('callbacks')) {
      final callbacksMap = json['callbacks'] as Map<String, dynamic>;
      callbacksNodes = {};
      for (final entry in callbacksMap.entries) {
        final callbackName = entry.key.toString();
        if (callbackName.startsWith('x-')) continue;

        final callbackJson = entry.value as Map<String, dynamic>;
        final callbackNode = CallbackNode(
          callbackJson,
          $id.document,
          ValidationUtils.buildPath(ValidationUtils.buildPath($id.jsonPointer, 'callbacks'), callbackName),
        );
        callbacksNodes![callbackName] = callbackNode;
        if (!OpenApiGraph.i.openApiNodes.containsKey(callbackNode.$id.absolutePointer)) {
          OpenApiGraph.i.addOpenApiNode(callbackNode);
          OpenApiGraph.i.addOpenApiEdge(
            OpenApiEdge($id.absolutePointer, callbackNode.$id.absolutePointer, 'callbacks/$callbackName'),
          );
          callbackNode.create();
        }
      }
    }
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
