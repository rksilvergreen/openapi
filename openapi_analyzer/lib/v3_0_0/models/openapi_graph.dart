import 'dart:io';
import 'package:yaml/yaml.dart';
import 'package:openapi_analyzer/validation_exception.dart';
import '../validation/validation_context.dart';
import '../reference/reference_resolver.dart';
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
import 'openapi_objects/callbacks_map.dart';
import 'openapi_objects/encodings_map.dart';
import 'openapi_objects/examples_map.dart';
import 'openapi_objects/headers_map.dart';
import 'openapi_objects/links_map.dart';
import 'openapi_objects/media_types_map.dart';
import 'openapi_objects/parameters_list.dart';
import 'openapi_objects/parameters_map.dart';
import 'openapi_objects/paths_map.dart';
import 'openapi_objects/request_bodies_map.dart';
import 'openapi_objects/responses_map.dart';
import 'openapi_objects/schema/schemas_list.dart';
import 'openapi_objects/schema/schema_map.dart';
import 'openapi_objects/security_requirements_list.dart';
import 'openapi_objects/security_schemes_map.dart';
import 'openapi_objects/server_list.dart';
import 'openapi_objects/server_variables_map.dart';
import 'openapi_objects/tags_list.dart';

abstract class Node {
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

// abstract class OpenApiNode extends Node {
//   OpenApiNode(super.json, super.document, super.jsonPointer);
// }

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

class OpenApiGraph {
  static late final OpenApiGraph i;

  final File file;
  late final ValidationContext validationContext;
  late final ReferenceResolver referenceResolver;
  final Map<String, dynamic> loadedDocuments = {};
  late final String rootDocumentName;

  OpenApiGraph(this.file) {
    i = this;
  }

  late final OpenApiDocument root;

  OpenApiDocument create({ValidationStrictness strictness = ValidationStrictness.moderate}) {
    // Initialize validation context
    validationContext = ValidationContext();
    referenceResolver = ReferenceResolver(file, validationContext);

    try {
      // Load and parse YAML
      if (!file.existsSync()) {
        throw Exception('File not found: ${file.path}');
      }

      final yamlContent = file.readAsStringSync();
      final yamlDoc = loadYaml(yamlContent);

      // Ensure root is a Map
      if (yamlDoc is! Map) {
        validationContext.addException(
          OpenApiValidationException(
            '/',
            'OpenAPI document root must be an object',
            specReference: 'OpenAPI 3.0.0 - Document Structure',
            severity: ValidationSeverity.critical,
          ),
        );
        validationContext.throwIfFailed(strictness);
      }

      // Store loaded root document
      rootDocumentName = file.uri.pathSegments.last;
      loadedDocuments[rootDocumentName] = yamlDoc;

      // Create root node
      final rootNode = OpenApiDocumentNode(yamlDoc as Map<String, dynamic>, rootDocumentName, '/');
      addNode(rootNode);

      // Trigger three-stage pipeline
      rootNode.create();
      root = rootNode.content;

      // Check for validation failures
      validationContext.throwIfFailed(strictness);

      return root;
    } catch (e) {
      if (e is ValidationFailedException) {
        rethrow;
      }
      print('Error creating OpenAPI graph: $e');
      rethrow;
    }
  }

  final Map<String, Node> nodes = {};
  final List<Edge> edges = [];
  final Map<String, String> _schemaNames = {}; // absolutePointer -> name
  final Map<String, List<String>> _nameRegistry = {}; // name -> list of absolutePointers using this name

  void addNode(Node node) => nodes[node.$id.absolutePointer] = node;

  void addEdge(Node from, Node to, String via, EdgeForm form) {
    final edge = Edge(from, to, via, form);
    edges.add(edge);
    from.$to.add(edge);
    to.$from.add(edge);
  }

  T getNode<T extends Node>(NodeId id) => nodes[id.absolutePointer]! as T;

  /// Registers a name for a schema, handling collisions with deterministic suffixes.
  /// Returns the final unique name (may have _2, _3, etc. suffix if there was a collision).
  String registerSchemaName(String absolutePointer, String baseName) {
    // Check if this node already has a name
    if (_schemaNames.containsKey(absolutePointer)) {
      return _schemaNames[absolutePointer]!;
    }

    // Check for collisions
    String finalName = baseName;
    if (_nameRegistry.containsKey(baseName)) {
      // Collision detected - add suffix
      final existingPointers = _nameRegistry[baseName]!;
      final count = existingPointers.length + 1;
      finalName = '${baseName}_$count';

      // Add this pointer to the registry
      existingPointers.add(absolutePointer);
      _nameRegistry[baseName] = existingPointers;

      // Add low severity validation exception for the collision
      validationContext.addException(
        OpenApiValidationException(
          absolutePointer,
          'Schema name collision: "$baseName" is already used by schemas at: ${existingPointers.join(", ")}',
          specReference: 'Schema Naming',
          severity: ValidationSeverity.low,
        ),
      );
    } else {
      // First use of this name
      _nameRegistry[baseName] = [absolutePointer];
    }

    // Store the final name
    _schemaNames[absolutePointer] = finalName;
    return finalName;
  }

  /// Gets a cached name for a schema if it exists.
  String? getCachedSchemaName(String absolutePointer) {
    return _schemaNames[absolutePointer];
  }

  /// Converts an absolute document path to a relative path for use in NodeId.
  /// Returns just the filename for the main document, or a relative path for external documents.
  String getRelativeDocumentPath(String absolutePath) {
    if (absolutePath == file.path) {
      return rootDocumentName;
    }
    // Get relative path from the base file's directory
    final baseDir = file.parent.path;
    if (absolutePath.startsWith(baseDir)) {
      var relativePath = absolutePath.substring(baseDir.length);
      // Remove leading slash/backslash
      if (relativePath.startsWith(Platform.pathSeparator)) {
        relativePath = relativePath.substring(1);
      }
      return relativePath;
    }
    // If not in the same directory tree, just return the filename
    return absolutePath.split(Platform.pathSeparator).last;
  }

  /// Gets a loaded document by its relative path (as used in NodeId.document).
  /// For external documents, loads them if not already cached.
  Map<dynamic, dynamic> getLoadedDocument(String relativeDocPath) {
    // Check if already loaded
    if (loadedDocuments.containsKey(relativeDocPath)) {
      return loadedDocuments[relativeDocPath]!;
    }

    // If it's not the root document, it must be an external document
    if (relativeDocPath != rootDocumentName) {
      // Convert relative path to absolute path for loading
      final absolutePath = file.parent.path + Platform.pathSeparator + relativeDocPath;
      final externalDoc = referenceResolver.loadExternalDocument(absolutePath);
      // Cache it with the relative path
      loadedDocuments[relativeDocPath] = externalDoc;
      return externalDoc;
    }

    return {};
  }
}

enum EdgeForm { inline, referenced }

class Edge {
  final Node from;
  final Node to;
  final String via;
  final EdgeForm form;

  Edge(this.from, this.to, this.via, this.form);
}

extension EdgeIterableExtension on Iterable<Edge> {
  T? to<T extends Node>(String via) => firstWhereOrNull((edge) => (edge.to is T) && (edge.via == via))!.to as T;

  T? from<T extends Node>(String via) => firstWhereOrNull((edge) => (edge.from is T) && (edge.via == via))!.from as T;
}

extension _FirstWhereOrNull<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (final e in this) {
      if (test(e)) return e;
    }
    return null;
  }
}
