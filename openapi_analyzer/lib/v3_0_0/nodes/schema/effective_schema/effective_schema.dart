import '../schema.dart';
import '../typed_schema/typed_schema.dart';
import '../../xml.dart';
import '../../external_documentation.dart';

abstract class EffectiveSchema<T extends EffectiveSchema<T>> {
  SchemaType get type;
  String? get description;
  bool get readOnly;
  bool get writeOnly;
  XML? get xml;
  ExternalDocumentation? get externalDocs;
  Map<String, dynamic>? get example;
  bool get deprecated;
  bool get nullable;

  List<EffectiveSchema>? get allOf;
  List<EffectiveSchema>? get oneOf;
  List<EffectiveSchema>? get anyOf;

  Schema get raw;
  TypedSchema get typed;
}