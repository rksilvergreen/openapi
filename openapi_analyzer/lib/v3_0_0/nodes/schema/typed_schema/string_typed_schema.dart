import 'typed_schema.dart';

abstract class StringTypedSchema extends TypedSchema<String> {
  int? get maxLength;
  int? get minLength;
  String? get pattern;
  String? get format;
}

