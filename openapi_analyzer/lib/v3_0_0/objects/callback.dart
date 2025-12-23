import 'dart:collection';
import 'path_item.dart';

abstract class Callback {
  PathsMap get expressions;
  Map<String, dynamic>? get extensions;
  String get $name;
}

abstract class CallbacksMap implements MapBase<String, Callback> {
  Map<String, dynamic>? get extensions;
}
