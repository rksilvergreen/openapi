import 'dart:collection';
import '../src/openapi_objects/enums.dart';
import 'example.dart';
import 'media_type.dart';
import 'schema/schema.dart';

/// Header Object follows the structure of the Parameter Object.
abstract class Header {
  String? get description;
  bool get required_;
  bool get deprecated;
  bool get allowEmptyValue;
  ParameterStyle? get style;
  bool? get explode;
  bool get allowReserved;
  SchemasMap? get schema;
  dynamic get example;
  ExamplesMap? get examples;
  MediaTypesMap? get content;
  Map<String, dynamic>? get extensions;
  String get $name;
}

abstract class HeadersMap implements MapBase<String, Header> {
  Map<String, dynamic>? get extensions;
}

