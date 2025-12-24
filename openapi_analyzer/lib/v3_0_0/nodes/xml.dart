import '../node.dart';

class XML extends Node {
  final String? name;
  final String? namespace;
  final String? prefix;
  final bool attribute;
  final bool wrapped;
  final Map<String, dynamic>? extensions;

  XML({this.name, this.namespace, this.prefix, required this.attribute, required this.wrapped, this.extensions});
}

