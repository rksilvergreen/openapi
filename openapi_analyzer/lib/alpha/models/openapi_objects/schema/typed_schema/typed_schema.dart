import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../referencable.dart';
import '../schema.dart';
import '../schema_type.dart';

@CopyWith()
@JsonSerializable()
abstract class TypedSchema<T extends TypedSchema<T>> {
  final ReferencableId $id;
  final SchemaType type;

  TypedSchema(this.$id, this.type);

  List<T> get allOf => (referenceGraph[$id] as Schema).allOf.map((schema) => schema.typed as T).toList();
  List<T> get oneOf => (referenceGraph[$id] as Schema).oneOf.map((schema) => schema.typed as T).toList();
  List<T> get anyOf => (referenceGraph[$id] as Schema).anyOf.map((schema) => schema.typed as T).toList();
}

abstract class SingleTypeTypedSchema<T, S extends SingleTypeTypedSchema<T, S>> extends TypedSchema<S> {
  final T defaultValue;
  final List<T> enumValues;
  
  SingleTypeTypedSchema(super.$id, super.type, this.defaultValue, this.enumValues);
}
