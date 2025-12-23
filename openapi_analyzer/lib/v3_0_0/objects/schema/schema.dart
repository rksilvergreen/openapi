import 'dart:collection';
import '../../../../validation_exception.dart';
import '../external_documentation.dart';
import '../xml.dart';
import '../discriminator.dart';
import '../operation.dart';
import '../parameter.dart';
import '../components.dart';
import '../media_type.dart';
import '../request_body.dart';
import '../response.dart';
import '../header.dart';
import '../path_item.dart';

/// JSON Schema type values for Schema Objects.
enum SchemaType {
  string('string'),
  number('number'),
  integer('integer'),
  boolean('boolean'),
  array('array'),
  object('object'),
  null_('null'),
  unknown('unknown'),
  multiType('multiType');

  const SchemaType(this.value);
  final String value;
}

abstract class Schema {
  String? get title;
  String? get description;
  dynamic get default_;
  SchemaType? get type;
  String? get format;
  num? get multipleOf;
  num? get maximum;
  num? get exclusiveMaximum;
  num? get minimum;
  num? get exclusiveMinimum;
  int? get maxLength;
  int? get minLength;
  String? get pattern;
  int? get maxItems;
  int? get minItems;
  bool get uniqueItems;
  Schema? get items;
  int? get maxProperties;
  int? get minProperties;
  List<String>? get required_;
  SchemasMap? get properties;
  bool? get additionalPropertiesAllowed;
  Schema? get additionalProperties;
  SchemasList? get allOf;
  SchemasList? get oneOf;
  SchemasList? get anyOf;
  List<dynamic>? get enum_;
  bool get nullable;
  Discriminator? get discriminator;
  bool get readOnly;
  bool get writeOnly;
  XML? get xml;
  ExternalDocumentation? get externalDocs;
  dynamic get example;
  bool get deprecated;
  Map<String, dynamic>? get extensions;

  TypedSchema get $typed;
  EffectiveSchema get $effective;
  String get $name;
}

abstract class SchemasMap implements MapBase<String, Schema> {
  Map<String, dynamic>? get extensions;
}

abstract class SchemasList implements ListBase<Schema> {}
