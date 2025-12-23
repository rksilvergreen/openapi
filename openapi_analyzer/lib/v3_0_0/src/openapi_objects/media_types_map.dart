import 'media_type.dart';
import '../map_node.dart';
import 'dart:collection';
import 'package:openapi_analyzer/v3_0_0/objects/media_type.dart';

class MediaTypesMapNode extends MapNode<MediaTypeNode, MediaType> implements MediaTypesMap {
  MediaTypesMapNode(super.json, super.document, super.jsonPointer);
}
