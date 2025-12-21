import 'dart:io';
import 'package:yaml/yaml.dart';
import 'package:openapi_analyzer/v3_0_0/models/openapi_objects/openapi_document.dart';
import 'package:openapi_analyzer/validation_exception.dart';
import '../validation/validation_context.dart';
import '../reference/reference_resolver.dart';

abstract class Node {
  final NodeId $id;
  final Map<String, dynamic> json;
  Node(this.json, String document, String jsonPointer) : $id = NodeId(document, jsonPointer);

  final List<Edge> $from = [];
  final List<Edge> $to = [];

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

  void addNode(Node node) => nodes[node.$id.absolutePointer] = node;

  void addEdge(Node from, Node to, String via, EdgeForm form) {
    final edge = Edge(from, to, via, form);
    edges.add(edge);
    from.$to.add(edge);
    to.$from.add(edge);
  }

  T getNode<T extends Node>(NodeId id) => nodes[id.absolutePointer]! as T;

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

enum EdgeForm {
  inline,
  referenced,
}

 class Edge {
  final Node from;
  final Node to;
  final String via;
  final EdgeForm form;

  Edge(this.from, this.to, this.via, this.form );
}

extension EdgeIterableExtension on Iterable<Edge> {
  T? to<T extends Node>(String via) => _firstWhereOrNull((edge) => (edge.to is T) && (edge.via == via))!.to as T;

  T? from<T extends Node>(String via) => _firstWhereOrNull((edge) => (edge.from is T) && (edge.via == via))!.from as T;

  Edge? _firstWhereOrNull(bool Function(Edge element) test) {
    for (final e in this) {
      if (test(e)) return e;
    }
    return null;
  }
}