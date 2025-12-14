import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

import 'openapi_object.dart';
import 'enums.dart';
import 'referenceable.dart';
import 'schema_object.dart';
import 'example.dart';
import 'media_type.dart';
import 'json_helpers.dart';

part '_gen/parameter.g.dart';

/// Describes a single operation parameter.
@CopyWith()
@JsonSerializable()
class Parameter implements OpenapiObject {
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
  // @JsonKey(fromJson: _schemaFromJson, toJson: _schemaToJson)
  final Referenceable<SchemaObject>? schema;
  final dynamic example;
  // @JsonKey(fromJson: _examplesFromJson, toJson: _examplesToJson)
  final Map<String, Referenceable<Example>>? examples;
  final Map<String, MediaType>? content;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  Parameter({
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
    final extensions = extractExtensions(json);
    final parameter = _$ParameterFromJson(jsonWithoutExtensions(json));
    // Handle required_ based on in_ location
    final required_ = parameter.in_ == ParameterLocation.path ? true : parameter.required_;
    return parameter.copyWith(required_: required_, extensions: extensions);
  }

  @override
  Map<String, dynamic> toJson() => _$ParameterToJson(this);
}

// Referenceable<SchemaObject>? _schemaFromJson(dynamic json) =>
//     Referenceable.fromJson<SchemaObject>(json, SchemaObject.fromJson);

// dynamic _schemaToJson(Referenceable<SchemaObject>? schema) {
//   if (schema == null) return null;
//   if (schema.isReference()) return schema.asReference();
//   return schema.asValue()?.toJson();
// }

// Map<String, Referenceable<Example>>? _examplesFromJson(dynamic json) {
//   if (json == null) return null;
//   if (json is! Map) return null;
//   final result = <String, Referenceable<Example>>{};
//   for (final entry in json.entries) {
//     final value = Referenceable.fromJson<Example>(entry.value, Example.fromJson);
//     if (value != null) result[entry.key.toString()] = value;
//   }
//   return result;
// }

// Map<String, dynamic>? _examplesToJson(Map<String, Referenceable<Example>>? examples) {
//   if (examples == null) return null;
//   final result = <String, dynamic>{};
//   for (final entry in examples.entries) {
//     result[entry.key] = entry.value.isReference() ? entry.value.asReference() : entry.value.asValue()?.toJson();
//   }
//   return result;
// }
