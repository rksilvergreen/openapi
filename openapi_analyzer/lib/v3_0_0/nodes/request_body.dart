import 'dart:collection';
import 'media_type.dart';

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
