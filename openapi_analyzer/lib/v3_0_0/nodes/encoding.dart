import '../doc_nodes/enums_doc_node.dart';
import 'header.dart';
import '../node.dart';
import '../map_node.dart';

class Encoding extends Node {
  final String? contentType;
  final HeadersMap? headers;
  final ParameterStyle? style;
  final bool? explode;
  final bool allowReserved;
  final Map<String, dynamic>? extensions;
  Encoding({this.contentType, this.headers, this.style, this.explode, required this.allowReserved, this.extensions});
}

class EncodingsMap extends MapNode<Encoding> {
  final Map<String, dynamic>? extensions;
  EncodingsMap({this.extensions});
}