import 'dart:collection';
import 'operation.dart';
import 'server.dart';
import 'parameter.dart';

abstract class PathItem {
  Operation? get get_;
  Operation? get put;
  Operation? get post;
  Operation? get delete;
  Operation? get options;
  Operation? get head;
  Operation? get patch;
  Operation? get trace;
  ServerList? get servers;
  ParametersList? get parameters;
  Map<String, dynamic>? get extensions;
}

abstract class PathsMap implements MapBase<String, PathItem> {
  Map<String, dynamic>? get extensions;
}

