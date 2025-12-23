import 'info.dart';
import 'server.dart';
import 'path_item.dart';
import 'components.dart';
import 'security_requirement.dart';
import 'tag.dart';
import 'external_documentation.dart';

abstract class OpenApiDocument {
  String get openapi;
  Info get info;
  ServerList? get servers;
  PathsMap get paths;
  Components? get components;
  SecurityRequirementsList? get security;
  TagsList? get tags;
  ExternalDocumentation? get externalDocs;
  Map<String, dynamic>? get extensions;
  String get $name;
}

