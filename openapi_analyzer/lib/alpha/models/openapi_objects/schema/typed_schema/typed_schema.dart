import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../referencable.dart';

@CopyWith()
@JsonSerializable()
abstract class TypedSchema<T extends TypedSchema<T>> {
  final ReferencableId $id;
  final List<String> _allOf;
  final List<String> _oneOf;
  final List<String> _anyOf;

  TypedSchema(
    this.$id,
    this._allOf,
    this._oneOf,
    this._anyOf,
  );

  List<T> get allOf => _allOf.map((id) => referenceGraph[id] as T).toList();

}