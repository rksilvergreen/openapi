import 'security_scheme.dart';
import '../map_node.dart';
import 'dart:collection';

abstract class SecuritySchemesMap implements MapBase<String, SecurityScheme> {
  Map<String, dynamic>? get extensions;
}

class SecuritySchemesMapNode extends MapNode<SecuritySchemeNode, SecurityScheme> implements SecuritySchemesMap {
  SecuritySchemesMapNode(super.json, super.document, super.jsonPointer);
}

