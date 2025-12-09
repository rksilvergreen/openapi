import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

import '../openapi_object.dart';
import 'server.dart';
import 'json_helpers.dart';

part '_gen/link.g.dart';

/// Link object represents a possible design-time link for a response.
@CopyWith()
@JsonSerializable()
class Link implements OpenapiObject {
  final String? operationRef;
  final String? operationId;
  final Map<String, dynamic>? parameters;
  final dynamic requestBody;
  final String? description;
  final Server? server;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  Link({
    this.operationRef,
    this.operationId,
    this.parameters,
    this.requestBody,
    this.description,
    this.server,
    this.extensions,
  });

  factory Link.fromJson(Map<String, dynamic> json) {
    final extensions = extractExtensions(json);
    final link = _$LinkFromJson(jsonWithoutExtensions(json));
    return link.copyWith(extensions: extensions);
  }

  @override
  Map<String, dynamic> toJson() => _$LinkToJson(this);
}
