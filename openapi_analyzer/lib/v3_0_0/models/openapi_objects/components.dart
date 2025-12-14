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
    final path = $id.relativePath;

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
          NodeId(
            $id.document,
            ValidationUtils.buildPath(ValidationUtils.buildPath($id.relativePath, 'schemas'), schemaName),
          ),
          schemaJson,
        );
        schemasNodes![schemaName] = schemaNode;
        OpenApiGraph.i.addSchemaNode(schemaNode);
        OpenApiGraph.i.addSchemaStructuralEdge(RootEdge($id.absolutePath, schemaNode.$id.absolutePath));
        schemaNode.create();
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
          NodeId(
            $id.document,
            ValidationUtils.buildPath(ValidationUtils.buildPath($id.relativePath, 'responses'), responseName),
          ),
          responseJson,
        );
        responsesNodes![responseName] = responseNode;
        OpenApiGraph.i.addOpenApiNode(responseNode);
        OpenApiGraph.i.addOpenApiEdge(
          OpenApiEdge($id.absolutePath, responseNode.$id.absolutePath, 'responses/$responseName'),
        );
        responseNode.create();
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
          NodeId(
            $id.document,
            ValidationUtils.buildPath(ValidationUtils.buildPath($id.relativePath, 'parameters'), parameterName),
          ),
          parameterJson,
        );
        parametersNodes![parameterName] = parameterNode;
        OpenApiGraph.i.addOpenApiNode(parameterNode);
        OpenApiGraph.i.addOpenApiEdge(
          OpenApiEdge($id.absolutePath, parameterNode.$id.absolutePath, 'parameters/$parameterName'),
        );
        parameterNode.create();
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
          NodeId(
            $id.document,
            ValidationUtils.buildPath(ValidationUtils.buildPath($id.relativePath, 'examples'), exampleName),
          ),
          exampleJson,
        );
        examplesNodes![exampleName] = exampleNode;
        OpenApiGraph.i.addOpenApiNode(exampleNode);
        OpenApiGraph.i.addOpenApiEdge(
          OpenApiEdge($id.absolutePath, exampleNode.$id.absolutePath, 'examples/$exampleName'),
        );
        exampleNode.create();
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
          NodeId(
            $id.document,
            ValidationUtils.buildPath(ValidationUtils.buildPath($id.relativePath, 'requestBodies'), requestBodyName),
          ),
          requestBodyJson,
        );
        requestBodiesNodes![requestBodyName] = requestBodyNode;
        OpenApiGraph.i.addOpenApiNode(requestBodyNode);
        OpenApiGraph.i.addOpenApiEdge(
          OpenApiEdge($id.absolutePath, requestBodyNode.$id.absolutePath, 'requestBodies/$requestBodyName'),
        );
        requestBodyNode.create();
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
          NodeId(
            $id.document,
            ValidationUtils.buildPath(ValidationUtils.buildPath($id.relativePath, 'headers'), headerName),
          ),
          headerJson,
        );
        headersNodes![headerName] = headerNode;
        OpenApiGraph.i.addOpenApiNode(headerNode);
        OpenApiGraph.i.addOpenApiEdge(
          OpenApiEdge($id.absolutePath, headerNode.$id.absolutePath, 'headers/$headerName'),
        );
        headerNode.create();
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
          NodeId(
            $id.document,
            ValidationUtils.buildPath(ValidationUtils.buildPath($id.relativePath, 'securitySchemes'), schemeName),
          ),
          schemeJson,
        );
        securitySchemesNodes![schemeName] = schemeNode;
        OpenApiGraph.i.addOpenApiNode(schemeNode);
        OpenApiGraph.i.addOpenApiEdge(
          OpenApiEdge($id.absolutePath, schemeNode.$id.absolutePath, 'securitySchemes/$schemeName'),
        );
        schemeNode.create();
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
          NodeId(
            $id.document,
            ValidationUtils.buildPath(ValidationUtils.buildPath($id.relativePath, 'links'), linkName),
          ),
          linkJson,
        );
        linksNodes![linkName] = linkNode;
        OpenApiGraph.i.addOpenApiNode(linkNode);
        OpenApiGraph.i.addOpenApiEdge(OpenApiEdge($id.absolutePath, linkNode.$id.absolutePath, 'links/$linkName'));
        linkNode.create();
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
          NodeId(
            $id.document,
            ValidationUtils.buildPath(ValidationUtils.buildPath($id.relativePath, 'callbacks'), callbackName),
          ),
          callbackJson,
        );
        callbacksNodes![callbackName] = callbackNode;
        OpenApiGraph.i.addOpenApiNode(callbackNode);
        OpenApiGraph.i.addOpenApiEdge(
          OpenApiEdge($id.absolutePath, callbackNode.$id.absolutePath, 'callbacks/$callbackName'),
        );
        callbackNode.create();
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
