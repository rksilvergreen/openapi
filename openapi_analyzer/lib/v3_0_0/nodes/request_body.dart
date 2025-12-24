import 'media_type.dart';
import '../node.dart';
import '../map_node.dart';

class RequestBody extends Node {
  final String? description;
  final bool required;
  final MediaTypesMap content;
  final Map<String, dynamic>? extensions;
  final String $name;

  RequestBody({this.description, required this.required, required this.content, this.extensions, required this.$name});
}

class RequestBodiesMap extends MapNode<RequestBody> {
  final Map<String, dynamic>? extensions;
  RequestBodiesMap({this.extensions});
}
