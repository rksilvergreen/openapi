import 'info.dart';
import 'server.dart';
import 'path_item.dart';
import 'components.dart';
import 'security_requirement.dart';
import 'tag.dart';
import 'external_documentation.dart';
import '../node.dart';

class OpenApiDocument extends Node {
  final String openapi;
  final Info info;
  final ServerList? servers;
  final PathsMap paths;
  final Components? components;
  final SecurityRequirementsList? security;
  final TagsList? tags;
  final ExternalDocumentation? externalDocs;
  final Map<String, dynamic>? extensions;
  final String $name;

  OpenApiDocument({
    required this.openapi,
    required this.info,
    this.servers,
    required this.paths,
    this.components,
    this.security,
    this.tags,
    this.externalDocs,
    this.extensions,
    required this.$name,
  });
}
