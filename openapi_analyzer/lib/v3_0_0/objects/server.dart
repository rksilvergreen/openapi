import 'dart:collection';

abstract class Server {
  String get url;
  String? get description;
  ServerVariablesMap? get variables;
  Map<String, dynamic>? get extensions;
  String get $name;
}

abstract class ServerList implements ListBase<Server> {}

abstract class ServerVariable {
  List<String>? get enum_;
  String get default_;
  String? get description;
  Map<String, dynamic>? get extensions;
}

abstract class ServerVariablesMap implements MapBase<String, ServerVariable> {
  Map<String, dynamic>? get extensions;
}

