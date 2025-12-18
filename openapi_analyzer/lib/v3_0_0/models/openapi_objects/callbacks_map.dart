import 'callback.dart';
import '../map_node.dart';
import 'dart:collection';

abstract class CallbacksMap implements MapBase<String, Callback> {
  Map<String, dynamic>? get extensions;
}

class CallbacksMapNode extends MapNode<CallbackNode, Callback> implements CallbacksMap {
  CallbacksMapNode(super.json, super.document, super.jsonPointer);
}
