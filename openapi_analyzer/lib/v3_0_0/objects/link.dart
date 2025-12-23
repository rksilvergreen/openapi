import 'dart:collection';
import 'server.dart';

abstract class Link {
  String? get operationRef;
  String? get operationId;
  Map<String, dynamic>? get parameters;
  dynamic get requestBody;
  String? get description;
  Server? get server;
  Map<String, dynamic>? get extensions;
}

abstract class LinksMap implements MapBase<String, Link> {
  Map<String, dynamic>? get extensions;
}
