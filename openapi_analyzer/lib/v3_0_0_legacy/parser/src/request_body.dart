import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

import 'openapi_object.dart';
import 'media_type.dart';
import 'json_helpers.dart';

part '_gen/request_body.g.dart';

/// Describes a single request body.
@CopyWith()
@JsonSerializable()
class RequestBody implements OpenapiObject {
  final String? description;
  final Map<String, MediaType> content;
  @JsonKey(name: 'required')
  final bool required_;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  RequestBody({this.description, required this.content, this.required_ = false, this.extensions});

  factory RequestBody.fromJson(Map<String, dynamic> json) {
    final extensions = extractExtensions(json);
    final requestBody = _$RequestBodyFromJson(jsonWithoutExtensions(json));
    return requestBody.copyWith(extensions: extensions);
  }

  @override
  Map<String, dynamic> toJson() => _$RequestBodyToJson(this);
}
