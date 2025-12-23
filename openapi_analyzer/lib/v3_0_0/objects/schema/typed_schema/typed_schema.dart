import '../schema.dart';
import '../../xml.dart';
import '../../external_documentation.dart';
import '../effective_schema/effective_schema.dart';

abstract class TypedSchema<T> {
  SchemaType get type;
  String? get description;
  bool get readOnly;
  bool get writeOnly;
  XML? get xml;
  ExternalDocumentation? get externalDocs;
  Map<String, dynamic>? get example;
  bool get deprecated;
  bool get nullable;
  T? get defaultValue;
  List<T>? get enumValues;

  List<TypedSchema>? get allOf;
  List<TypedSchema>? get oneOf;
  List<TypedSchema>? get anyOf;

  Schema get raw;
  EffectiveSchema get effective;
}
