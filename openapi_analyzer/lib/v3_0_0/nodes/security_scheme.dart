import '../doc_nodes/enums_doc_node.dart';
import 'oauth_flow.dart';
import '../node.dart';
import '../map_node.dart';

class SecurityScheme extends Node {
  final SecuritySchemeType type;
  final String? description;
  final String? name;
  final SecuritySchemeIn? in_;
  final String? scheme;
  final String? bearerFormat;
  final OAuthFlows? flows;
  final String? openIdConnectUrl;
  final Map<String, dynamic>? extensions;
  final String $name;

  SecurityScheme({required this.type, this.description, this.name, this.in_, this.scheme, this.bearerFormat, this.flows, this.openIdConnectUrl, this.extensions, required this.$name});
}

class SecuritySchemesMap extends MapNode<SecurityScheme> {
  final Map<String, dynamic>? extensions;
  SecuritySchemesMap({this.extensions});
}

