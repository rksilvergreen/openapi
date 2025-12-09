import 'package:openapi_analyzer/beta/schema/schema.dart';
import 'package:openapi_analyzer/beta/analysis_result/analysis_result.dart';
import 'package:openapi_analyzer/beta/effective_schema_node/effective_schema_node.dart';

abstract interface class SchemaNode {
  String get $id;
}

mixin SingleTypeSchemaNode<T, S extends Schema<T, S>> implements SchemaNode {
  List<StructuralEdge>? _structuralEdges;
  List<ApplicatorEdge>? _applicatorEdges;
  List<StructuralEdge> get $structuralEdges =>
      _structuralEdges ??= AnalysisResult.i.structuralEdges.where((edge) => edge.from == $id).toList();
  List<ApplicatorEdge> get $applicatorEdges =>
      _applicatorEdges ??= AnalysisResult.i.applicatorEdges.where((edge) => edge.from == $id).toList();
  SingleTypeEffectiveSchemaNode<T, S> get $effectiveSchemaNode =>
      AnalysisResult.i.effectiveSchemaNodes[$id] as SingleTypeEffectiveSchemaNode<T, S>;
}

class MultiTypeSchemaNode implements SchemaNode {
  final String $id;
  final String $documentUri;
  final String $structuralPath;
  final List<SchemaNode> variants;
  MultiTypeSchemaNode({
    required this.$id,
    required this.$documentUri,
    required this.$structuralPath,
    required this.variants,
  });

  List<StructuralEdge>? _structuralEdges;
  List<ApplicatorEdge>? _applicatorEdges;
  List<StructuralEdge> get $structuralEdges =>
      _structuralEdges ??= AnalysisResult.i.structuralEdges.where((edge) => edge.from == $id).toList();
  List<ApplicatorEdge> get $applicatorEdges =>
      _applicatorEdges ??= AnalysisResult.i.applicatorEdges.where((edge) => edge.from == $id).toList();
  EffectiveSchemaNode get $effectiveSchemaNode => AnalysisResult.i.effectiveSchemaNodes[$id] as EffectiveSchemaNode;
}
