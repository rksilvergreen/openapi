import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

import '../openapi_object.dart';
import 'json_helpers.dart';

part '_gen/xml.g.dart';

/// XML object for XML representation metadata.
@CopyWith()
@JsonSerializable()
class XML implements OpenapiObject {
  final String? name;
  final String? namespace;
  final String? prefix;
  final bool attribute;
  final bool wrapped;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  XML({
    this.name,
    this.namespace,
    this.prefix,
    this.attribute = false,
    this.wrapped = false,
    this.extensions,
  });

  factory XML.fromJson(Map<String, dynamic> json) {
    final extensions = extractExtensions(json);
    final xml = _$XMLFromJson(jsonWithoutExtensions(json));
    return xml.copyWith(extensions: extensions);
  }

  @override
  Map<String, dynamic> toJson() => _$XMLToJson(this);
}

