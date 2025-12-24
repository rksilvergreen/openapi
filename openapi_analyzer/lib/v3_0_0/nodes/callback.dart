import 'dart:collection';
import 'package:openapi_analyzer/v3_0_0/openapi_object.dart';
import 'path_item.dart';

abstract class Callback extends OpenApiObject {
  PathsMap get expressions;
  Map<String, dynamic>? get extensions;
  String get $name;
}

abstract class CallbacksMap implements MapBase<String, Callback> {
  Map<String, dynamic>? get extensions;
}