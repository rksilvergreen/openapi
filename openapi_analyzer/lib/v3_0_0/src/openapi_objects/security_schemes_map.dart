import 'security_scheme.dart';
import '../map_node.dart';
import 'dart:collection';
import 'package:openapi_analyzer/v3_0_0/objects/security_scheme.dart';

class SecuritySchemesMapNode extends MapNode<SecuritySchemeNode, SecurityScheme> implements SecuritySchemesMap {
  SecuritySchemesMapNode(super.json, super.document, super.jsonPointer);
}

