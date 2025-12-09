import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

import '../openapi_object.dart';
import '../referencable.dart';
import 'enums.dart';
import 'schema/raw_schema/raw_schema.dart';
import 'example.dart';
import 'media_type.dart';

part '_gen/parameter.g.dart';

/// Describes a single operation parameter.
@CopyWith()
@JsonSerializable()
class Parameter implements Referencable {
  final ReferencableId $id;
  final String name;
  @JsonKey(name: 'in')
  final ParameterLocation in_;
  final String? description;
  @JsonKey(name: 'required')
  final bool required_;
  final bool deprecated;
  final bool allowEmptyValue;
  final ParameterStyle? style;
  final bool? explode;
  final bool allowReserved;
  final Referenceable<SchemaObject>? schema;
  final dynamic example;
  final Map<String, Referenceable<Example>>? examples;
  final Map<String, MediaType>? content;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  Parameter({
    required this.$id,
    required this.name,
    required this.in_,
    this.description,
    this.required_ = false,
    this.deprecated = false,
    this.allowEmptyValue = false,
    this.style,
    this.explode,
    this.allowReserved = false,
    this.schema,
    this.example,
    this.examples,
    this.content,
    this.extensions,
  });

  factory Parameter.fromJson(Map<String, dynamic> json) {
    final extensions = OpenapiObject.extractExtensions(json);
    final parameter = _$ParameterFromJson(OpenapiObject.jsonWithoutExtensions(json));
    // Handle required_ based on in_ location
    final required_ = parameter.in_ == ParameterLocation.path ? true : parameter.required_;
    return parameter.copyWith(required_: required_, extensions: extensions);
  }

  @override
  Map<String, dynamic> toJson() => _$ParameterToJson(this);
}