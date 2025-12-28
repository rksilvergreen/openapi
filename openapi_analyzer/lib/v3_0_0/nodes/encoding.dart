import '../doc_nodes/enums_doc_node.dart';
import 'header.dart';
import '../node.dart';
import '../map_node.dart';

class Encoding extends Node {
  String? contentType;
  HeadersMap? headers;
  ParameterStyle? style;
  bool? explode;
  bool allowReserved;
  Map<String, dynamic>? extensions;

  Encoding({this.contentType, this.headers, this.style, this.explode, required this.allowReserved, this.extensions});

}

class EncodingsMap extends MapNode<Encoding> {
  final Map<String, dynamic>? extensions;
  EncodingsMap({this.extensions});
}
