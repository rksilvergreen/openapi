import 'dart:io';
import 'package:yaml/yaml.dart';
import 'package:openapi_analyzer/validation_exception.dart';
import 'validation/validation_context.dart';
import 'reference/reference_resolver.dart';
import 'name_registry.dart';
import 'doc_nodes/openapi_document_doc_node.dart';
import 'node.dart';
import 'edge.dart';

class OpenApiGraph {
  static late final OpenApiGraph i;

  final File file;
  late final ValidationContext validationContext;
  late final ReferenceResolver referenceResolver;
  late final NameRegistry nameRegistry;
  final Map<String, dynamic> loadedDocuments = {};
  late final String rootDocumentName;

  OpenApiGraph(this.file) {
    i = this;
  }

  late final OpenApiDocumentNode root;

  OpenApiDocumentNode create({ValidationStrictness strictness = ValidationStrictness.moderate}) {
    // Initialize validation context
    validationContext = ValidationContext();
    referenceResolver = ReferenceResolver(file, validationContext);
    nameRegistry = NameRegistry(validationContext);

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