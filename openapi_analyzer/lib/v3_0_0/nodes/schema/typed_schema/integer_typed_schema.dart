import 'typed_schema.dart';

abstract class IntegerTypedSchema extends TypedSchema<int> {
  double? get multipleOf;
  int? get maximum;
  int? get exclusiveMaximum;
  int? get minimum;
  int? get exclusiveMinimum;
  String? get format;
}
