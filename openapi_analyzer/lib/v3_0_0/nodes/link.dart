import 'server.dart';
import '../node.dart';
import '../map_node.dart';

class Link extends Node {
  final String? operationRef;
  final String? operationId;
  final Map<String, dynamic>? parameters;
  final dynamic requestBody;
  final String? description;
  final Server? server;
  final Map<String, dynamic>? extensions;

  Link({this.operationRef, this.operationId, this.parameters, this.requestBody, this.description, this.server, this.extensions});
}

class LinksMap extends MapNode<Link> {
  final Map<String, dynamic>? extensions;
  LinksMap({this.extensions});
}
