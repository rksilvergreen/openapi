import 'dart:io';
import 'package:yaml/yaml.dart';
import 'package:openapi_analyzer/v3_0_0/models/openapi_objects/openapi_document.dart';
import 'package:openapi_analyzer/validation_exception.dart';
import '../validation/validation_context.dart';
import '../reference/reference_resolver.dart';
import 'openapi_objects/schema/schema_node.dart';

abstract class Node {
  final NodeId $id;
  final Map<String, dynamic> json;
  Node(this.$id, this.json);

  Map<String, dynamic>? extractExtensions(Map<String, dynamic> json) {
    final extensions = <String, dynamic>{};
    for (final entry in json.entries) {
      if (entry.key.startsWith('x-')) {
        extensions[entry.key] = entry.value;
      }
    }
    return extensions.isEmpty ? null : extensions;
  }
}

class NodeId {
  final String document;
  final String relativePath;
  final String absolutePath;

  const NodeId(this.document, this.relativePath) : absolutePath = '$document$relativePath';
}

abstract class OpenApiNode extends Node {
  OpenApiNode(super.$id, super.json);

  bool get structureValidated;
  bool get contentCreated;
}

class OpenApiGraph {
  static late final OpenApiGraph i;

  final File file;
  late final ValidationContext validationContext;
  late final ReferenceResolver referenceResolver;
  final Map<String, dynamic> loadedDocuments = {};

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
      loadedDocuments[file.path] = yamlDoc;

      // Create root node (triggers three-stage pipeline)
      final rootId = NodeId(file.uri.pathSegments.last, '/');
      final rootNode = OpenApiDocumentNode(rootId, yamlDoc as Map);
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

  final Map<String, OpenApiNode> openApiNodes = {};
  final Map<String, SchemaNode> schemaNodes = {};
  final List<OpenApiEdge> openApiEdges = [];
  final List<StructuralEdge> schemaStructuralEdges = [];
  final List<ApplicatorEdge> schemaApplicatorEdges = [];

  void addOpenApiNode(OpenApiNode node) => openApiNodes[node.$id.absolutePath] = node;

  void addSchemaNode(SchemaNode node) => schemaNodes[node.$id.absolutePath] = node;

  void addOpenApiEdge(OpenApiEdge edge) => openApiEdges.add(edge);

  void addSchemaStructuralEdge(StructuralEdge edge) => schemaStructuralEdges.add(edge);

  void addSchemaApplicatorEdge(ApplicatorEdge edge) => schemaApplicatorEdges.add(edge);

  T getOpenApiNode<T extends OpenApiNode>(NodeId id) => openApiNodes[id.absolutePath]! as T;

  List<OpenApiNode> getOpenApiNodeParents(OpenApiNode node) =>
      openApiEdges.where((edge) => edge.to == node).map((edge) => edge.from).toList();

  List<Node> getOpenApiNodeChildren(OpenApiNode node) =>
      openApiEdges.where((edge) => edge.from == node).map((edge) => edge.to).toList();

  SchemaNode getSchemaNode(NodeId id) => schemaNodes[id.absolutePath]!;

  List<Node> getSchemaNodeStructuralParents<T extends StructuralEdge>(SchemaNode node) =>
      schemaStructuralEdges.where((edge) => edge is T && edge.to == node).map((edge) => edge.from).toList();

  List<SchemaNode> getSchemaNodeStructuralChildren<T extends StructuralEdge>(SchemaNode node) =>
      schemaStructuralEdges.where((edge) => edge is T && edge.from == node).map((edge) => edge.to).toList();

  List<SchemaNode> getSchemaNodeApplicatorParents<T extends ApplicatorEdge>(SchemaNode node) =>
      schemaApplicatorEdges.where((edge) => edge is T && edge.to == node).map((edge) => edge.from).toList();

  List<SchemaNode> getSchemaNodeApplicatorChildren<T extends ApplicatorEdge>(SchemaNode node) =>
      schemaApplicatorEdges.where((edge) => edge is T && edge.from == node).map((edge) => edge.to).toList();

  List<SchemaNode> getStructuralSchemaRoots() =>
      schemaStructuralEdges.where((edge) => edge is RootEdge).map((edge) => edge.to).toList();
}

abstract class Edge {
  final String _from;
  final String _to;
  final String via;

  Edge(this._from, this._to, this.via);

  Node get from;
  Node get to;
}

class OpenApiEdge extends Edge {
  OpenApiEdge(super.from, super.to, super.via);

  late OpenApiNode? _$from;
  late Node? _$to;
  OpenApiNode get from => _$from ??= OpenApiGraph.i.openApiNodes[_from]!;
  Node get to => _$to ??= OpenApiGraph.i.openApiNodes[_to] ?? OpenApiGraph.i.schemaNodes[_to]!;
}

abstract class SchemaEdge extends Edge {
  SchemaEdge(super.from, super.to, super.via);
}

abstract class StructuralEdge extends SchemaEdge {
  late Node? _$from;
  late SchemaNode? _$to;
  Node get from => _$from ??= OpenApiGraph.i.schemaNodes[_from] ?? OpenApiGraph.i.openApiNodes[_from]!;
  SchemaNode get to => _$to ??= OpenApiGraph.i.schemaNodes[_to]!;
  StructuralEdge(super.from, super.to, super.via);
}

class RootEdge extends StructuralEdge {
  RootEdge(String from, String to) : super(from, to, 'root');
}

class PropertiesEdge extends StructuralEdge {
  PropertiesEdge(String from, String to) : super(from, to, 'properties');
}

class AdditionalPropertiesEdge extends StructuralEdge {
  AdditionalPropertiesEdge(String from, String to) : super(from, to, 'additionalProperties');
}

class ItemsEdge extends StructuralEdge {
  ItemsEdge(String from, String to) : super(from, to, 'items');
}

abstract class ApplicatorEdge extends SchemaEdge {
  late SchemaNode? _$from;
  late SchemaNode? _$to;
  SchemaNode get from => _$from ??= OpenApiGraph.i.schemaNodes[_from]!;
  SchemaNode get to => _$to ??= OpenApiGraph.i.schemaNodes[_to]!;
  ApplicatorEdge(super.from, super.to, super.via);
}

class AllOfEdge extends ApplicatorEdge {
  AllOfEdge(String from, String to) : super(from, to, 'allOf');
}

class OneOfEdge extends ApplicatorEdge {
  OneOfEdge(String from, String to) : super(from, to, 'oneOf');
}

class AnyOfEdge extends ApplicatorEdge {
  AnyOfEdge(String from, String to) : super(from, to, 'anyOf');
}
