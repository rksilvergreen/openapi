import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

import 'openapi_object.dart';
import 'info.dart';
import 'server.dart';
import 'paths.dart';
import 'components.dart';
import 'security.dart';
import 'tag.dart';
import 'external_documentation.dart';
import 'json_helpers.dart';

part '_gen/openapi_document.g.dart';

/// Root document object of the OpenAPI document.
@CopyWith()
@JsonSerializable()
class OpenApiDocument implements OpenapiObject {
  final String openapi;
  final Info info;
  final List<Server>? servers;
  final Paths paths;
  final Components? components;
  final List<SecurityRequirement>? security;
  final List<Tag>? tags;
  final ExternalDocumentation? externalDocs;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

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
  });

  factory OpenApiDocument.fromJson(Map<String, dynamic> json) {
    final extensions = extractExtensions(json);
    final doc = _$OpenApiDocumentFromJson(jsonWithoutExtensions(json));
    return doc.copyWith(extensions: extensions);
  }

  @override
  Map<String, dynamic> toJson() => _$OpenApiDocumentToJson(this);
}
