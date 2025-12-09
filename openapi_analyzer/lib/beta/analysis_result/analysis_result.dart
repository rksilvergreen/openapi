import 'package:openapi_analyzer/beta/effective_schema_node/effective_schema_node.dart';
import 'package:openapi_analyzer/beta/schema_node/schema_node.dart';

class AnalysisResult {
  AnalysisResult._();

  static final AnalysisResult i = AnalysisResult._();

  final Map<String, SchemaNode> schemaNodes = {};
  final List<StructuralEdge> structuralEdges = [];
  final List<ApplicatorEdge> applicatorEdges = [];

  final Map<String, EffectiveSchemaNode> effectiveSchemaNodes = {};
  final List<EffectiveStructuralEdge> effectiveStructuralEdges = [];
  final List<EffectiveApplicatorEdge> effectiveApplicatorEdges = [];
}

class StructuralEdge {
  final SchemaNode from;
  final SchemaNode to;
  // more properties to be added
  StructuralEdge({required this.from, required this.to});
}

class ApplicatorEdge {
  final SchemaNode from;
  final SchemaNode to;
  // more properties to be added
  ApplicatorEdge({required this.from, required this.to});
}

class EffectiveStructuralEdge {
  final EffectiveSchemaNode from;
  final EffectiveSchemaNode to;
  // more properties to be added
  EffectiveStructuralEdge({required this.from, required this.to});
}

class EffectiveApplicatorEdge {
  final EffectiveSchemaNode from;
  final EffectiveSchemaNode to;
  // more properties to be added
  EffectiveApplicatorEdge({required this.from, required this.to});
}
