import 'package:openapi_analyzer/validation_exception.dart';
import 'package:collection/collection.dart';
import 'doc_nodes/openapi_document.dart';
import 'doc_nodes/info.dart';
import 'doc_nodes/components.dart';
import 'doc_nodes/operation.dart';
import 'doc_nodes/parameter.dart';
import 'doc_nodes/header.dart';
import 'doc_nodes/response.dart';
import 'doc_nodes/request_body.dart';
import 'doc_nodes/media_type.dart';
import 'doc_nodes/schema.dart';
import 'doc_nodes/server.dart';
import 'doc_nodes/server_variable.dart';
import 'doc_nodes/tag.dart';
import 'doc_nodes/xml.dart';
import 'doc_nodes/security_requirement.dart';
import 'doc_nodes/path_item.dart';
import 'doc_nodes/oauth_flow.dart';
import 'doc_nodes/example.dart';
import 'doc_nodes/encoding.dart';
import 'doc_nodes/discriminator.dart';
import 'doc_nodes/link.dart';
import 'doc_nodes/license.dart';
import 'doc_nodes/contact.dart';
import 'doc_nodes/oauth_flows.dart';
import 'doc_nodes/external_documentation.dart';
import 'doc_nodes/callback.dart';
import 'doc_nodes/security_scheme.dart';
import 'edge.dart';
import 'validation/validation_utils.dart';
import 'openapi_graph.dart';
import 'node.dart';

abstract class DocNode extends Node {
  final Map<String, dynamic> json;
  DocNode(this.json, super.document, super.jsonPointer);

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

  static T ofType<T extends DocNode>(Map<String, dynamic> json, String document, String jsonPointer) {
    if (T is CallbacksMapDocNode) return CallbacksMapDocNode(json, document, jsonPointer) as T;
    if (T is CallbackNode) return CallbackNode(json, document, jsonPointer) as T;
    if (T is ComponentsNode) return ComponentsNode(json, document, jsonPointer) as T;
    if (T is ContactNode) return ContactNode(json, document, jsonPointer) as T;
    if (T is DiscriminatorNode) return DiscriminatorNode(json, document, jsonPointer) as T;
    if (T is EncodingsMapDocNode) return EncodingsMapDocNode(json, document, jsonPointer) as T;
    if (T is EncodingNode) return EncodingNode(json, document, jsonPointer) as T;
    if (T is ExamplesMapDocNode) return ExamplesMapDocNode(json, document, jsonPointer) as T;
    if (T is ExampleNode) return ExampleNode(json, document, jsonPointer) as T;
    if (T is ExternalDocumentationNode) return ExternalDocumentationNode(json, document, jsonPointer) as T;
    if (T is HeadersMapDocNode) return HeadersMapDocNode(json, document, jsonPointer) as T;
    if (T is HeaderNode) return HeaderNode(json, document, jsonPointer) as T;
    if (T is InfoNode) return InfoNode(json, document, jsonPointer) as T;
    if (T is LicenseNode) return LicenseNode(json, document, jsonPointer) as T;
    if (T is LinksMapDocNode) return LinksMapDocNode(json, document, jsonPointer) as T;
    if (T is LinkNode) return LinkNode(json, document, jsonPointer) as T;
    if (T is MediaTypesMapDocNode) return MediaTypesMapDocNode(json, document, jsonPointer) as T;
    if (T is MediaTypeNode) return MediaTypeNode(json, document, jsonPointer) as T;
    if (T is OAuthFlowNode) return OAuthFlowNode(json, document, jsonPointer) as T;
    if (T is OAuthFlowsNode) return OAuthFlowsNode(json, document, jsonPointer) as T;
    if (T is OpenApiDocumentNode) return OpenApiDocumentNode(json, document, jsonPointer) as T;
    if (T is OperationNode) return OperationNode(json, document, jsonPointer) as T;
    if (T is ParametersListDocNode) return ParametersListDocNode(json, document, jsonPointer) as T;
    if (T is ParametersMapDocNode) return ParametersMapDocNode(json, document, jsonPointer) as T;
    if (T is ParameterNode) return ParameterNode(json, document, jsonPointer) as T;
    if (T is PathsMapDocNode) return PathsMapDocNode(json, document, jsonPointer) as T;
    if (T is PathItemNode) return PathItemNode(json, document, jsonPointer) as T;
    if (T is RequestBodiesMapDocNode) return RequestBodiesMapDocNode(json, document, jsonPointer) as T;
    if (T is RequestBodyNode) return RequestBodyNode(json, document, jsonPointer) as T;
    if (T is ResponsesMapDocNode) return ResponsesMapDocNode(json, document, jsonPointer) as T;
    if (T is ResponseNode) return ResponseNode(json, document, jsonPointer) as T;
    if (T is SchemasListDocNode) return SchemasListDocNode(json, document, jsonPointer) as T;
    if (T is SchemasMapDocNode) return SchemasMapDocNode(json, document, jsonPointer) as T;
    if (T is SchemaNode) return SchemaNode(json, document, jsonPointer) as T;
    if (T is SecurityRequirementsListDocNode) return SecurityRequirementsListDocNode(json, document, jsonPointer) as T;
    if (T is SecurityRequirementNode) return SecurityRequirementNode(json, document, jsonPointer) as T;
    if (T is SecuritySchemesMapDocNode) return SecuritySchemesMapDocNode(json, document, jsonPointer) as T;
    if (T is SecuritySchemeNode) return SecuritySchemeNode(json, document, jsonPointer) as T;
    if (T is ServerListDocNode) return ServerListDocNode(json, document, jsonPointer) as T;
    if (T is ServerVariablesMapDocNode) return ServerVariablesMapDocNode(json, document, jsonPointer) as T;
    if (T is ServerNode) return ServerNode(json, document, jsonPointer) as T;
    if (T is ServerVariableNode) return ServerVariableNode(json, document, jsonPointer) as T;
    if (T is TagsListDocNode) return TagsListDocNode(json, document, jsonPointer) as T;
    if (T is TagNode) return TagNode(json, document, jsonPointer) as T;
    if (T is XMLNode) return XMLNode(json, document, jsonPointer) as T;
    throw Exception('Unsupported node type: $T');
  }
}

mixin DocInternalNode on DocNode {
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

mixin DocLeafNode on DocNode {
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
extension NodeCreationHelpers on DocNode {
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
  T _getOrCreateNode<T extends DocNode>({
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
    final childNode = DocNode.ofType<T>(json, document, jsonPointer);
    OpenApiGraph.i.addNode(childNode);
    OpenApiGraph.i.addEdge(this, childNode, via, form);
    childNode.create();
    return childNode;
  }

  /// Creates a single node (handles $ref resolution and node reuse for referencable nodes).
  /// Returns the existing node if it was already created (for referencable nodes), otherwise creates and returns a new one.
  T? createNode<T extends DocNode>({required String jsonKey, bool required = false}) {
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
  List<T>? createListDocNode<T extends DocNode>() {
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

  Map<String, T>? createMapDocNode<T extends DocNode>() {
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
