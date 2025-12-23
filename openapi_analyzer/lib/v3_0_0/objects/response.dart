import 'dart:collection';
import 'header.dart';
import 'media_type.dart';
import 'link.dart';

abstract class Response {
  String? get description;
  HeadersMap? get headers;
  MediaTypesMap? get content;
  LinksMap? get links;
  Map<String, dynamic>? get extensions;
  String get $name;
}

abstract class ResponsesMap implements MapBase<String, Response> {
  Map<String, dynamic>? get extensions;
}

