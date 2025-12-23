import 'dart:collection';

abstract class Response {
  String? get description;
  HeadersMap? get headers;
  MediaTypesMap? get content;
  LinksMap? get links;
  Map<String, dynamic>? get extensions;
  String get $name;
}

// Forward declarations
abstract class HeadersMap {}
abstract class MediaTypesMap {}
abstract class LinksMap {}

abstract class ResponsesMap implements MapBase<String, Response> {
  Map<String, dynamic>? get extensions;
}

