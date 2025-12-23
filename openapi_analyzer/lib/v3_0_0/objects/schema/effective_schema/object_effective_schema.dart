import 'effective_schema.dart';

abstract class ObjectEffectiveSchema {
  Map<String, EffectiveSchema>? get properties;
  bool get additionalPropertiesAllowed;
  EffectiveSchema? get additionalProperties;
  int? get maxProperties;
  int? get minProperties;
  List<String>? get required;
}

