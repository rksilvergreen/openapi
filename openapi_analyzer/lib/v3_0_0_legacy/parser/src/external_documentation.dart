import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

import 'openapi_object.dart';
import 'json_helpers.dart';

part '_gen/external_documentation.g.dart';

/// Additional external documentation.
@CopyWith()
@JsonSerializable()
class ExternalDocumentation implements OpenapiObject {
  final String? description;
  final String url;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  ExternalDocumentation({this.description, required this.url, this.extensions});

  factory ExternalDocumentation.fromJson(Map<String, dynamic> json) {
    final extensions = extractExtensions(json);
    final externalDocs = _$ExternalDocumentationFromJson(jsonWithoutExtensions(json));
    return externalDocs.copyWith(extensions: extensions);
  }

  @override
  Map<String, dynamic> toJson() => _$ExternalDocumentationToJson(this);
}
