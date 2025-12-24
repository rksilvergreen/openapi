import 'schema/schema.dart';
import 'example.dart';
import 'encoding.dart';
import '../node.dart';
import '../map_node.dart';

class MediaType extends Node {
  final SchemasMap? schema;
  final dynamic example;
  final ExamplesMap? examples;
  final EncodingsMap? encoding;
  final Map<String, dynamic>? extensions;

  MediaType({this.schema, this.example, this.examples, this.encoding, this.extensions});
}

class MediaTypesMap extends MapNode<MediaType> {
  final Map<String, dynamic>? extensions;
  MediaTypesMap({this.extensions});
}

