import 'dart:collection';
import '../src/openapi_objects/paths_map.dart';

abstract class Callback {
  PathsMap get expressions;
  Map<String, dynamic>? get extensions;
  String get $name;
}

abstract class CallbacksMap implements MapBase<String, Callback> {
  Map<String, dynamic>? get extensions;
}
