import 'header.dart';
import 'media_type.dart';
import 'link.dart';
import '../node.dart';
import '../map_node.dart';

class Response extends Node {
  final String? description;
  final HeadersMap? headers;
  final MediaTypesMap? content;
  final LinksMap? links;
  final Map<String, dynamic>? extensions;
  final String $name;

  Response({this.description, this.headers, this.content, this.links, this.extensions, required this.$name});
}

class ResponsesMap extends MapNode<Response> {
  final Map<String, dynamic>? extensions;
  ResponsesMap({this.extensions});
}

