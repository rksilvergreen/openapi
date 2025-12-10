import 'openapi_objects/schema/schema.dart';

abstract class Referencable {
  ReferencableId get $id;
}

class ReferencableId {
  final String document;
  final String relativePath;
  final String absolutePath;

  const ReferencableId(this.document, this.relativePath, this.absolutePath);
}

class OpenApiRegistry {
  static final OpenApiRegistry i = OpenApiRegistry._();

  OpenApiRegistry._();

  final Map<String, Referencable> referencableRegistry = {};
  final Map<String, Schema> edgesRegistry = {};
}

abstract class Edge {
  final String _from;
  final String _to;
  Referencable get from => OpenApiRegistry.i.referencableRegistry[_from]!;
  Referencable get to => OpenApiRegistry.i.referencableRegistry[_to]!;
  Edge(this._from, this._to);
}

abstract class SchemaEdge implements Edge {
  final Schema from;
  final Schema to;
  SchemaEdge(this.from, this.to);
}

enum StructuralType { properties, additionalProperties, items }

abstract class StructuralEdge extends SchemaEdge {
  final StructuralType type;
  StructuralEdge(super.from, super.to, this.type);
}

class PropertiesEdge extends StructuralEdge {
  PropertiesEdge(Schema from, Schema to) : super(from, to, StructuralType.properties);
}

class AdditionalPropertiesEdge extends StructuralEdge {
  AdditionalPropertiesEdge(Schema from, Schema to) : super(from, to, StructuralType.additionalProperties);
}

class ItemsEdge extends StructuralEdge {
  ItemsEdge(Schema from, Schema to) : super(from, to, StructuralType.items);
}

enum ApplicatorType { allOf, oneOf, anyOf }

abstract class ApplicatorEdge extends Edge {
  final ApplicatorType type;
  ApplicatorEdge(super.from, super.to, this.type);
}

class AllOfEdge extends ApplicatorEdge {
  AllOfEdge(Schema from, Schema to) : super(from, to, ApplicatorType.allOf);
}

class OneOfEdge extends ApplicatorEdge {
  OneOfEdge(Schema from, Schema to) : super(from, to, ApplicatorType.oneOf);
}

class AnyOfEdge extends ApplicatorEdge {
  AnyOfEdge(Schema from, Schema to) : super(from, to, ApplicatorType.anyOf);
}

Map<String, Referencable> referenceGraph = {};
