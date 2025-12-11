import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../openapi_graph.dart';
import '../schema_node.dart';
import '../schema_type.dart';

@CopyWith()
@JsonSerializable()
abstract class TypedSchema<T extends TypedSchema<T>> {
  final NodeId $id;
  final SchemaType type;

  TypedSchema(this.$id, this.type);

  SchemaNode? _$node;
  List<T>? _$allOf;
  List<T>? _$oneOf;
  List<T>? _$anyOf;

  SchemaNode get _node => _$node ??= OpenApiRegistry.i.getSchemaNode($id);
  List<T> get allOf => _$allOf ??= _node.allOf.map((node) => node.typed as T).toList();
  List<T> get oneOf => _$oneOf ??= _node.oneOf.map((node) => node.typed as T).toList();
  List<T> get anyOf => _$anyOf ??= _node.anyOf.map((node) => node.typed as T).toList();
}

abstract class SingleTypeTypedSchema<T, S extends SingleTypeTypedSchema<T, S>> extends TypedSchema<S> {
  final T defaultValue;
  final List<T> enumValues;

  SingleTypeTypedSchema(super.$id, super.type, this.defaultValue, this.enumValues);
}
