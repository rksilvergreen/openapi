import 'dart:collection';
import '../doc_nodes/enums_doc_node.dart';
import 'oauth_flow.dart';

abstract class SecurityScheme {
  SecuritySchemeType get type;
  String? get description;
  String? get name;
  SecuritySchemeIn? get in_;
  String? get scheme;
  String? get bearerFormat;
  OAuthFlows? get flows;
  String? get openIdConnectUrl;
  Map<String, dynamic>? get extensions;
  String get $name;
}

abstract class SecuritySchemesMap implements MapBase<String, SecurityScheme> {
  Map<String, dynamic>? get extensions;
}

