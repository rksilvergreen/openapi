import 'package:openapi_analyzer/validation_exception.dart';
import 'doc_nodes/openapi_document_doc_node.dart';
import 'doc_nodes/info_doc_node.dart';
import 'doc_nodes/components_doc_node.dart';
import 'doc_nodes/operation_doc_node.dart';
import 'doc_nodes/parameter_doc_node.dart';
import 'doc_nodes/header_doc_node.dart';
import 'doc_nodes/response_doc_node.dart';
import 'doc_nodes/request_body_doc_node.dart';
import 'doc_nodes/media_type_doc_node.dart';
import 'doc_nodes/schema_doc_node.dart';
import 'doc_nodes/server_doc_node.dart';
import 'doc_nodes/server_variable_doc_node.dart';
import 'doc_nodes/tag_doc_node.dart';
import 'doc_nodes/xml_doc_node.dart';
import 'doc_nodes/security_requirement_doc_node.dart';
import 'doc_nodes/path_item_doc_node.dart';
import 'doc_nodes/oauth_flow_doc_node.dart';
import 'doc_nodes/example_doc_node.dart';
import 'doc_nodes/encoding_doc_node.dart';
import 'doc_nodes/discriminator_doc_node.dart';
import 'doc_nodes/link_doc_node.dart';
import 'doc_nodes/license_doc_node.dart';
import 'doc_nodes/contact_doc_node.dart';
import 'doc_nodes/oauth_flows_doc_node.dart';
import 'doc_nodes/external_documentation_doc_node.dart';
import 'doc_nodes/callback_doc_node.dart';
import 'doc_nodes/security_scheme_doc_node.dart';
import 'edge.dart';
import 'validation/validation_utils.dart';
import 'openapi_graph.dart';
import 'node.dart';

abstract class DocNode extends Node {
  final Map<String, dynamic> json;
  DocNode(this.json) : super();

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

  static T ofType<T extends DocNode>(Map<String, dynamic> json) {
    if (T is CallbacksMapDocNode) return CallbacksMapDocNode(json) as T;
    if (T is CallbackDocNode) return CallbackDocNode(json)as T;
    if (T is ComponentsDocNode) return ComponentsDocNode(json)as T;
    if (T is ContactDocNode) return ContactDocNode(json)as T;
    if (T is DiscriminatorDocNode) return DiscriminatorDocNode(json)as T;
    if (T is EncodingsMapDocNode) return EncodingsMapDocNode(json)as T;
    if (T is EncodingDocNode) return EncodingDocNode(json)as T;
    if (T is ExamplesMapDocNode) return ExamplesMapDocNode(json)as T;
    if (T is ExampleDocNode) return ExampleDocNode(json)as T;
    if (T is ExternalDocumentationDocNode) return ExternalDocumentationDocNode(json)as T;
    if (T is HeadersMapDocNode) return HeadersMapDocNode(json)as T;
    if (T is HeaderDocNode) return HeaderDocNode(json)as T;
    if (T is InfoDocNode) return InfoDocNode(json)as T;
    if (T is LicenseDocNode) return LicenseDocNode(json)as T;
    if (T is LinksMapDocNode) return LinksMapDocNode(json)as T;
    if (T is LinkDocNode) return LinkDocNode(json)as T;
    if (T is MediaTypesMapDocNode) return MediaTypesMapDocNode(json)as T;
    if (T is MediaTypeDocNode) return MediaTypeDocNode(json)as T;
    if (T is OAuthFlowDocNode) return OAuthFlowDocNode(json)as T;
    if (T is OAuthFlowsDocNode) return OAuthFlowsDocNode(json)as T;
    if (T is OpenApiDocumentDocNode) return OpenApiDocumentDocNode(json)as T;
    if (T is OperationDocNode) return OperationDocNode(json)as T;
    if (T is ParametersListDocNode) return ParametersListDocNode(json)as T;
    if (T is ParametersMapDocNode) return ParametersMapDocNode(json)as T;
    if (T is ParameterDocNode) return ParameterDocNode(json)as T;
    if (T is PathsMapDocNode) return PathsMapDocNode(json)as T;
    if (T is PathItemDocNode) return PathItemDocNode(json)as T;
    if (T is RequestBodiesMapDocNode) return RequestBodiesMapDocNode(json)as T;
    if (T is RequestBodyDocNode) return RequestBodyDocNode(json)as T;
    if (T is ResponsesMapDocNode) return ResponsesMapDocNode(json)as T;
    if (T is ResponseDocNode) return ResponseDocNode(json)as T;
    if (T is SchemasListDocNode) return SchemasListDocNode(json)as T;
    if (T is SchemasMapDocNode) return SchemasMapDocNode(json)as T;
    if (T is SchemaDocNode) return SchemaDocNode(json)as T;
    if (T is SecurityRequirementsListDocNode) return SecurityRequirementsListDocNode(json)as T;
    if (T is SecurityRequirementDocNode) return SecurityRequirementDocNode(json)as T;
    if (T is SecuritySchemesMapDocNode) return SecuritySchemesMapDocNode(json)as T;
    if (T is SecuritySchemeDocNode) return SecuritySchemeDocNode(json)as T;
    if (T is ServerListDocNode) return ServerListDocNode(json)as T;
    if (T is ServerVariablesMapDocNode) return ServerVariablesMapDocNode(json)as T;
    if (T is ServerDocNode) return ServerDocNode(json)as T;
    if (T is ServerVariableDocNode) return ServerVariableDocNode(json)as T;
    if (T is TagsListDocNode) return TagsListDocNode(json)as T;
    if (T is TagDocNode) return TagDocNode(json)as T;
    if (T is XMLDocNode) return XMLDocNode(json)as T;
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
            ValidationUtils.buildPointer([$id!.jsonPointer, jsonKey]),
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
    final childNode = DocNode.ofType<T>(json);
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
    final originalDocument = $id!.document;
    final originalJsonPointer = ValidationUtils.buildPointer([$id!.jsonPointer, jsonKey]);

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
      final originalDocument = $id!.document;
      final originalJsonPointer = ValidationUtils.buildPointer([$id!.jsonPointer, '$i']);

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
      final originalDocument = $id!.document;
      final originalJsonPointer = ValidationUtils.buildPointer([$id!.jsonPointer, key]);

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
