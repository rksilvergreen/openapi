import 'media_type.dart';
import '../map_node.dart';
import 'dart:collection';

abstract class MediaTypesMap implements MapBase<String, MediaType> {
  Map<String, dynamic>? get extensions;
}

class MediaTypesMapNode extends MapNode<MediaTypeNode, MediaType> implements MediaTypesMap {
  MediaTypesMapNode(super.json, super.document, super.jsonPointer);
}
