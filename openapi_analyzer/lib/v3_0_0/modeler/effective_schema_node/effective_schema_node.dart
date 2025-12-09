import 'package:openapi_analyzer/v3_0_0/modeler/schema/schema.dart';
import 'package:openapi_analyzer/v3_0_0/modeler/schema_node/schema_node.dart';
import 'package:openapi_analyzer/v3_0_0/modeler/analysis_result/analysis_result.dart';

abstract interface class EffectiveSchemaNode {
  String get $id;
}

mixin SingleTypeEffectiveSchemaNode<T, S extends Schema<T, S>> implements EffectiveSchemaNode {
  String get $id;
  List<EffectiveStructuralEdge>? _structuralEdges;
  List<EffectiveApplicatorEdge>? _applicatorEdges;
  List<EffectiveStructuralEdge> get $structuralEdges =>
      _structuralEdges ??= AnalysisResult.i.effectiveStructuralEdges.where((edge) => edge.from == $id).toList();
  List<EffectiveApplicatorEdge> get $applicatorEdges =>
      _applicatorEdges ??= AnalysisResult.i.effectiveApplicatorEdges.where((edge) => edge.from == $id).toList();
  SingleTypeSchemaNode<T, S> get $schemaNode => AnalysisResult.i.schemaNodes[$id] as SingleTypeSchemaNode<T, S>;
}

class MultiTypeEffectiveSchemaNode implements EffectiveSchemaNode {
  final String $id;
  final List<EffectiveSchemaNode> variants;
  MultiTypeEffectiveSchemaNode({required this.$id, required this.variants});

  List<EffectiveStructuralEdge>? _structuralEdges;
  List<EffectiveApplicatorEdge>? _applicatorEdges;
  List<EffectiveStructuralEdge> get $structuralEdges =>
      _structuralEdges ??= AnalysisResult.i.effectiveStructuralEdges.where((edge) => edge.from == $id).toList();
  List<EffectiveApplicatorEdge> get $applicatorEdges =>
      _applicatorEdges ??= AnalysisResult.i.effectiveApplicatorEdges.where((edge) => edge.from == $id).toList();
  SchemaNode get $schemaNode => AnalysisResult.i.schemaNodes[$id] as SchemaNode;
}
