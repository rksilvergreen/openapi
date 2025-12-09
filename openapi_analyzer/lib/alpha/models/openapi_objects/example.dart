import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

import '../openapi_object.dart';
import 'json_helpers.dart';

part '_gen/example.g.dart';

/// Example object for media type examples.
@CopyWith()
@JsonSerializable()
class Example implements OpenapiObject {
  final String? summary;
  final String? description;
  final dynamic value;
  final String? externalValue;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  Example({this.summary, this.description, this.value, this.externalValue, this.extensions});

  factory Example.fromJson(Map<String, dynamic> json) {
    final extensions = extractExtensions(json);
    final example = _$ExampleFromJson(jsonWithoutExtensions(json));
    return example.copyWith(extensions: extensions);
  }

  @override
  Map<String, dynamic> toJson() => _$ExampleToJson(this);
}
