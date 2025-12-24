import 'package:openapi_analyzer/validation_exception.dart';
import 'package:collection/collection.dart';
import 'openapi_objects/openapi_document.dart';
import 'openapi_objects/info.dart';
import 'openapi_objects/components.dart';
import 'openapi_objects/operation.dart';
import 'openapi_objects/parameter.dart';
import 'openapi_objects/header.dart';
import 'openapi_objects/response.dart';
import 'openapi_objects/request_body.dart';
import 'openapi_objects/media_type.dart';
import 'openapi_objects/schema/schema.dart';
import 'openapi_objects/server.dart';
import 'openapi_objects/server_variable.dart';
import 'openapi_objects/tag.dart';
import 'openapi_objects/xml.dart';
import 'openapi_objects/security_requirement.dart';
import 'openapi_objects/path_item.dart';
import 'openapi_objects/oauth_flow.dart';
import 'openapi_objects/example.dart';
import 'openapi_objects/encoding.dart';
import 'openapi_objects/discriminator.dart';
import 'openapi_objects/link.dart';
import 'openapi_objects/license.dart';
import 'openapi_objects/contact.dart';
import 'openapi_objects/oauth_flows.dart';
import 'openapi_objects/external_documentation.dart';
import 'openapi_objects/callback.dart';
import 'openapi_objects/security_scheme.dart';
import 'edge.dart';
import 'validation/validation_utils.dart';
import 'openapi_graph.dart';
import 'package:openapi_analyzer/v3_0_0/openapi_object.dart';

abstract class Node implements OpenApiObject {
  final NodeId $id;
  final Map<String, dynamic> json;
  Node(this.json, String document, String jsonPointer) : $id = NodeId(document, jsonPointer);

  final List<Edge> $from = [];
  final List<Edge> $to = [];

  T? parent<T extends Node>(String? via, EdgeForm? form) =>
      $from
              .firstWhereOrNull(
                (edge) => edge.from is T && (via == null || edge.via == via) && (form == null || edge.form == form),
              )
              ?.from
          as T?;

  /// Returns the "true parent" - either the single inline parent or the single referenced parent.
  /// A true parent is:
  /// - The single inline parent (if there's exactly one inline edge), OR
  /// - The single referenced parent (if there's no inline parent and exactly one referenced edge)
  T? trueParent<T extends Node>([String? via]) {
    final edge = trueParentEdge<T>(via);
    return edge?.from as T?;
  }

  /// Returns the edge to the "true parent".
  /// Returns the inline edge if there's exactly one, otherwise the referenced edge if there's exactly one.
  Edge? trueParentEdge<T extends Node>([String? via]) {
    // First, look for inline edges
    final inlineEdges = $from
        .where((edge) => edge.from is T && (via == null || edge.via == via) && edge.form == EdgeForm.inline)
        .toList();

    if (inlineEdges.length == 1) {
      return inlineEdges.first;
    }

    // If no inline edges (or multiple), look for referenced edges
    if (inlineEdges.isEmpty) {
      final referencedEdges = $from
          .where((edge) => edge.from is T && (via == null || edge.via == via) && edge.form == EdgeForm.referenced)
          .toList();

      if (referencedEdges.length == 1) {
        return referencedEdges.first;
      }
    }

    return null;
  }

  Map<String, dynamic>? extractExtensions(Map<String, dynamic> json) {
    final extensions = <String, dynamic>{};
    for (final entry in json.entries) {
      if (entry.key.startsWith('x-')) {
        extensions[entry.key] = entry.value;
      }
    }
    return extensions.isEmpty ? null : extensions;
  }

  void create();

  static T ofType<T extends Node>(Map<String, dynamic> json, String document, String jsonPointer) {
    if (T is CallbacksMapNode) return CallbacksMapNode(json, document, jsonPointer) as T;
    if (T is CallbackNode) return CallbackNode(json, document, jsonPointer) as T;
    if (T is ComponentsNode) return ComponentsNode(json, document, jsonPointer) as T;
    if (T is ContactNode) return ContactNode(json, document, jsonPointer) as T;
    if (T is DiscriminatorNode) return DiscriminatorNode(json, document, jsonPointer) as T;
    if (T is EncodingsMapNode) return EncodingsMapNode(json, document, jsonPointer) as T;
    if (T is EncodingNode) return EncodingNode(json, document, jsonPointer) as T;
    if (T is ExamplesMapNode) return ExamplesMapNode(json, document, jsonPointer) as T;
    if (T is ExampleNode) return ExampleNode(json, document, jsonPointer) as T;
    if (T is ExternalDocumentationNode) return ExternalDocumentationNode(json, document, jsonPointer) as T;
    if (T is HeadersMapNode) return HeadersMapNode(json, document, jsonPointer) as T;
    if (T is HeaderNode) return HeaderNode(json, document, jsonPointer) as T;
    if (T is InfoNode) return InfoNode(json, document, jsonPointer) as T;
    if (T is LicenseNode) return LicenseNode(json, document, jsonPointer) as T;
    if (T is LinksMapNode) return LinksMapNode(json, document, jsonPointer) as T;
    if (T is LinkNode) return LinkNode(json, document, jsonPointer) as T;
    if (T is MediaTypesMapNode) return MediaTypesMapNode(json, document, jsonPointer) as T;
    if (T is MediaTypeNode) return MediaTypeNode(json, document, jsonPointer) as T;
    if (T is OAuthFlowNode) return OAuthFlowNode(json, document, jsonPointer) as T;
    if (T is OAuthFlowsNode) return OAuthFlowsNode(json, document, jsonPointer) as T;
    if (T is OpenApiDocumentNode) return OpenApiDocumentNode(json, document, jsonPointer) as T;
    if (T is OperationNode) return OperationNode(json, document, jsonPointer) as T;
    if (T is ParametersListNode) return ParametersListNode(json, document, jsonPointer) as T;
    if (T is ParametersMapNode) return ParametersMapNode(json, document, jsonPointer) as T;
    if (T is ParameterNode) return ParameterNode(json, document, jsonPointer) as T;
    if (T is PathsMapNode) return PathsMapNode(json, document, jsonPointer) as T;
    if (T is PathItemNode) return PathItemNode(json, document, jsonPointer) as T;
    if (T is RequestBodiesMapNode) return RequestBodiesMapNode(json, document, jsonPointer) as T;
    if (T is RequestBodyNode) return RequestBodyNode(json, document, jsonPointer) as T;
    if (T is ResponsesMapNode) return ResponsesMapNode(json, document, jsonPointer) as T;
    if (T is ResponseNode) return ResponseNode(json, document, jsonPointer) as T;
    if (T is SchemasListNode) return SchemasListNode(json, document, jsonPointer) as T;
    if (T is SchemasMapNode) return SchemasMapNode(json, document, jsonPointer) as T;
    if (T is SchemaNode) return SchemaNode(json, document, jsonPointer) as T;
    if (T is SecurityRequirementsListNode) return SecurityRequirementsListNode(json, document, jsonPointer) as T;
    if (T is SecurityRequirementNode) return SecurityRequirementNode(json, document, jsonPointer) as T;
    if (T is SecuritySchemesMapNode) return SecuritySchemesMapNode(json, document, jsonPointer) as T;
    if (T is SecuritySchemeNode) return SecuritySchemeNode(json, document, jsonPointer) as T;
    if (T is ServerListNode) return ServerListNode(json, document, jsonPointer) as T;
    if (T is ServerVariablesMapNode) return ServerVariablesMapNode(json, document, jsonPointer) as T;
    if (T is ServerNode) return ServerNode(json, document, jsonPointer) as T;
    if (T is ServerVariableNode) return ServerVariableNode(json, document, jsonPointer) as T;
    if (T is TagsListNode) return TagsListNode(json, document, jsonPointer) as T;
    if (T is TagNode) return TagNode(json, document, jsonPointer) as T;
    if (T is XMLNode) return XMLNode(json, document, jsonPointer) as T;

    throw Exception('Unsupported node type: $T');
  }
}

class NodeId {
  final String document;
  final String jsonPointer;
  final String absolutePointer;

  const NodeId(this.document, this.jsonPointer) : absolutePointer = '$document#$jsonPointer';
}

mixin InternalNode on Node {
  @override
  void create() {
    validateStructure();
    createChildNodes();
    createContent();
  }

  void validateStructure();
  void createChildNodes();
  void createContent();
}

mixin LeafNode on Node {
  @override
  void create() {
    validateStructure();
    createContent();
  }

  void validateStructure();
  void createContent();
}

typedef NodeFactory<T> = T Function(Map<String, dynamic> json, String document, String jsonPointer);

/// Extension providing helper methods for creating child nodes.
/// These methods handle the common patterns of node creation, edge addition, and node reuse.
extension NodeCreationHelpers on Node {
  /// Checks if the JSON contains a $ref.
  bool _isRef(Map<String, dynamic> json) {
    return json.containsKey('\$ref');
  }

  /// Resolves a $ref reference, returning the target (json, document, jsonPointer).
  (Map<String, dynamic>, String, String) _resolveRef({
    required Map<String, dynamic> json,
    required String jsonPointer,
  }) {
    final ref = ValidationUtils.requireString(json['\$ref'], ValidationUtils.buildPointer([jsonPointer, '\$ref']));
    ValidationUtils.validateNoUnknownFields(json, {'\$ref'}, jsonPointer, 'Reference Object');
    return OpenApiGraph.i.referenceResolver.resolveReference(ref, jsonPointer);
  }

  bool _containsKey(String jsonKey, bool required) {
    if (!json.containsKey(jsonKey)) {
      if (required) {
        OpenApiGraph.i.validationContext.addException(
          OpenApiValidationException(
            ValidationUtils.buildPointer([$id.jsonPointer, jsonKey]),
            'Required field "$jsonKey" is missing',
            specReference: 'OpenAPI 3.0.0 Specification',
            severity: ValidationSeverity.critical,
          ),
        );
      }
      return false;
    }
    return true;
  }

  /// Gets an existing node or creates a new one, handling edge creation.
  /// Returns the existing node if found, otherwise creates and returns a new node.
  T _getOrCreateNode<T extends Node>({
    required Map<String, dynamic> json,
    required String document,
    required String jsonPointer,
    required bool isRef,
    required String via,
  }) {
    // Determine the 'form' argument: use referenced for refs, inline otherwise
    final form = isRef ? EdgeForm.referenced : EdgeForm.inline;

    // Check if node already exists at the resolved location
    final absolutePointer = '$document#$jsonPointer';
    final existingNode = OpenApiGraph.i.nodes[absolutePointer] as T?;

    if (existingNode != null) {
      OpenApiGraph.i.addEdge(this, existingNode, via, form);
      return existingNode;
    }

    // Create new node
    final childNode = Node.ofType<T>(json, document, jsonPointer);
    OpenApiGraph.i.addNode(childNode);
    OpenApiGraph.i.addEdge(this, childNode, via, form);
    childNode.create();
    return childNode;
  }

  /// Creates a single node (handles $ref resolution and node reuse for referencable nodes).
  /// Returns the existing node if it was already created (for referencable nodes), otherwise creates and returns a new one.
  T? createNode<T extends Node>({required String jsonKey, bool required = false}) {
    if (!_containsKey(jsonKey, required)) {
      return null;
    }

    final originalJson = json[jsonKey] as Map<String, dynamic>;
    final originalDocument = $id.document;
    final originalJsonPointer = ValidationUtils.buildPointer([$id.jsonPointer, jsonKey]);

    final isRef = _isRef(originalJson);
    final (resolvedJson, resolvedDocument, resolvedJsonPointer) = isRef
        ? _resolveRef(json: originalJson, jsonPointer: originalJsonPointer)
        : (originalJson, originalDocument, originalJsonPointer);

    return _getOrCreateNode<T>(
      json: resolvedJson,
      document: resolvedDocument,
      jsonPointer: resolvedJsonPointer,
      isRef: isRef,
      via: jsonKey,
    );
  }

  /// Creates a list of nodes (handles $ref resolution and node reuse for referencable nodes).
  List<T>? createListNode<T extends Node>() {
    final list = json as List;
    final nodes = <T>[];
    for (var i = 0; i < list.length; i++) {
      final originalJson = list[i] as Map<String, dynamic>;
      final originalDocument = $id.document;
      final originalJsonPointer = ValidationUtils.buildPointer([$id.jsonPointer, '$i']);

      final isRef = _isRef(originalJson);
      final (resolvedJson, resolvedDocument, resolvedJsonPointer) = isRef
          ? _resolveRef(json: originalJson, jsonPointer: originalJsonPointer)
          : (originalJson, originalDocument, originalJsonPointer);

      final registeredNode = _getOrCreateNode<T>(
        json: resolvedJson,
        document: resolvedDocument,
        jsonPointer: resolvedJsonPointer,
        isRef: isRef,
        via: '$i',
      );
      nodes.add(registeredNode);
    }

    return nodes;
  }

  Map<String, T>? createMapNode<T extends Node>() {
    final nodes = <String, T>{};
    for (final entry in json.entries) {
      final key = entry.key.toString();
      final originalJson = entry.value as Map<String, dynamic>;
      final originalDocument = $id.document;
      final originalJsonPointer = ValidationUtils.buildPointer([$id.jsonPointer, key]);

      final isRef = _isRef(originalJson);
      final (resolvedJson, resolvedDocument, resolvedJsonPointer) = isRef
          ? _resolveRef(json: originalJson, jsonPointer: originalJsonPointer)
          : (originalJson, originalDocument, originalJsonPointer);

      final registeredNode = _getOrCreateNode<T>(
        json: resolvedJson,
        document: resolvedDocument,
        jsonPointer: resolvedJsonPointer,
        isRef: isRef,
        via: key,
      );
      nodes[key] = registeredNode;
    }

    return nodes;
  }
}