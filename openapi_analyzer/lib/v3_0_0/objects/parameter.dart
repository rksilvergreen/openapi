import 'dart:collection';
import '../src/openapi_objects/enums.dart';
import '../src/openapi_objects/schema/schema.dart';
import 'example.dart';
import 'media_type.dart';

abstract class Parameter {
  String get name;
  ParameterLocation get in_;
  String? get description;
  bool get required_;
  bool get deprecated;
  bool get allowEmptyValue;
  ParameterStyle? get style;
  bool? get explode;
  bool get allowReserved;
  Schema? get schema;
  dynamic get example;
  ExamplesMap? get examples;
  MediaTypesMap? get content;
  Map<String, dynamic>? get extensions;
  String get $name;
}

abstract class ParametersList implements ListBase<Parameter> {}

abstract class ParametersMap implements MapBase<String, Parameter> {
  Map<String, dynamic>? get extensions;
}
