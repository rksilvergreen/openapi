import 'openapi_objects/schema/schema_node.dart';

abstract class Node {
  NodeId get $id;
}

class NodeId {
  final String document;
  final String relativePath;
  final String absolutePath;

  const NodeId(this.document, this.relativePath, this.absolutePath);
}

abstract class OpenApiNode implements Node {
  NodeId get $id;
}

class OpenApiRegistry {
  static final OpenApiRegistry i = OpenApiRegistry._();

  OpenApiRegistry._();

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

  List<OpenApiNode> getOpenApiNodeParents(OpenApiNode node) =>
      openApiEdges.where((edge) => edge.to == node).map((edge) => edge.from).toList();

  List<Node> getOpenApiNodeChildren(OpenApiNode node) =>
      openApiEdges.where((edge) => edge.from == node).map((edge) => edge.to).toList();

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
  OpenApiNode get from => _$from ??= OpenApiRegistry.i.openApiNodes[_from]!;
  Node get to => _$to ??= OpenApiRegistry.i.openApiNodes[_to] ?? OpenApiRegistry.i.schemaNodes[_to]!;
}

abstract class SchemaEdge extends Edge {
  SchemaEdge(super.from, super.to, super.via);
}

abstract class StructuralEdge extends SchemaEdge {
  late Node? _$from;
  late SchemaNode? _$to;
  Node get from => _$from ??= OpenApiRegistry.i.schemaNodes[_from] ?? OpenApiRegistry.i.openApiNodes[_from]!;
  SchemaNode get to => _$to ??= OpenApiRegistry.i.schemaNodes[_to]!;
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
  SchemaNode get from => _$from ??= OpenApiRegistry.i.schemaNodes[_from]!;
  SchemaNode get to => _$to ??= OpenApiRegistry.i.schemaNodes[_to]!;
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
