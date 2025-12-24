import 'dart:collection';
import 'schema/schema.dart';
import 'example.dart';
import 'encoding.dart';

abstract class MediaType {
  SchemasMap? get schema;
  dynamic get example;
  ExamplesMap? get examples;
  EncodingsMap? get encoding;
  Map<String, dynamic>? get extensions;
}

abstract class MediaTypesMap implements MapBase<String, MediaType> {
  Map<String, dynamic>? get extensions;
}

