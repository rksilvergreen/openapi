import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

import '../openapi_object.dart';
import 'external_documentation.dart';
import 'json_helpers.dart';

part '_gen/tag.g.dart';

/// Adds metadata to a single tag that is used by the Operation Object.
@CopyWith()
@JsonSerializable()
class Tag implements OpenapiObject {
  final String name;
  final String? description;
  final ExternalDocumentation? externalDocs;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  Tag({
    required this.name,
    this.description,
    this.externalDocs,
    this.extensions,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    final extensions = extractExtensions(json);
    final tag = _$TagFromJson(jsonWithoutExtensions(json));
    return tag.copyWith(extensions: extensions);
  }

  @override
  Map<String, dynamic> toJson() => _$TagToJson(this);
}

