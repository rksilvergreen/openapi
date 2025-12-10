import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import '../schema_node.dart';
import '../../../openapi_graph.dart';

@CopyWith()
@JsonSerializable()
abstract class EffectiveSchema<T, S extends EffectiveSchema<T, S>> {
  final ReferencableId $id;

  EffectiveSchema(this.$id);

  List<S> get allOf => (referenceGraph[$id] as Schema).allOf.map((schema) => schema.effective as S).toList();
  List<S> get oneOf => (referenceGraph[$id] as Schema).oneOf.map((schema) => schema.effective as S).toList();
  List<S> get anyOf => (referenceGraph[$id] as Schema).anyOf.map((schema) => schema.effective as S).toList();
}