import 'dart:collection';

abstract class RequestBody {
  String? get description;
  bool get required;
  MediaTypesMap get content;
  Map<String, dynamic>? get extensions;
  String get $name;
}

abstract class RequestBodiesMap implements MapBase<String, RequestBody> {
  Map<String, dynamic>? get extensions;
}

// Forward declaration
abstract class MediaTypesMap {}

