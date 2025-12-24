import 'typed_schema.dart';

abstract class NumberTypedSchema extends TypedSchema<double> {
  double? get multipleOf;
  double? get maximum;
  double? get exclusiveMaximum;
  double? get minimum;
  double? get exclusiveMinimum;
  String? get format;
}

