import '../../referencable.dart';
import 'raw_schema/raw_schema.dart';
import 'typed_schema/typed_schema.dart';
import 'effective_schema/effective_schema.dart';

class Schema implements Referencable {
  final ReferencableId $id;
  late final RawSchema rawSchema;
  late final TypedSchema typedSchema;
  late final EffectiveSchema effectiveSchema;

  Schema(this.$id);

  void setRawSchema(RawSchema rawSchema) => this.rawSchema = rawSchema;
  void setTypedSchema(TypedSchema typedSchema) => this.typedSchema = typedSchema;
  void setEffectiveSchema(EffectiveSchema effectiveSchema) => this.effectiveSchema = effectiveSchema;
}
