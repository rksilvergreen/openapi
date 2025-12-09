import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

import '../openapi_object.dart';
import '../referenceable.dart';
import 'schema/raw_schema/raw_schema.dart';
import 'example.dart';
import 'enums.dart';
import 'header.dart';
import 'json_helpers.dart';

part '_gen/media_type.g.dart';

/// Each Media Type Object provides schema and examples for the media type.
@CopyWith()
@JsonSerializable()
class MediaType implements OpenapiObject {
  // @JsonKey(fromJson: _schemaFromJson, toJson: _schemaToJson)
  final Referenceable<SchemaObject>? schema;
  final dynamic example;
  // @JsonKey(fromJson: _examplesFromJson, toJson: _examplesToJson)
  final Map<String, Referenceable<Example>>? examples;
  final Map<String, Encoding>? encoding;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  MediaType({this.schema, this.example, this.examples, this.encoding, this.extensions});

  factory MediaType.fromJson(Map<String, dynamic> json) {
    final extensions = extractExtensions(json);
    final mediaType = _$MediaTypeFromJson(jsonWithoutExtensions(json));
    return mediaType.copyWith(extensions: extensions);
  }

  @override
  Map<String, dynamic> toJson() => _$MediaTypeToJson(this);
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

/// A single encoding definition applied to a single schema property.
@CopyWith()
@JsonSerializable()
class Encoding implements OpenapiObject {
  final String? contentType;
  // @JsonKey(fromJson: _headersFromJson, toJson: _headersToJson)
  final Map<String, Referenceable<Header>>? headers;
  final ParameterStyle? style;
  final bool? explode;
  final bool allowReserved;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  Encoding({this.contentType, this.headers, this.style, this.explode, this.allowReserved = false, this.extensions});

  factory Encoding.fromJson(Map<String, dynamic> json) {
    final extensions = extractExtensions(json);
    final encoding = _$EncodingFromJson(jsonWithoutExtensions(json));
    return encoding.copyWith(extensions: extensions);
  }

  @override
  Map<String, dynamic> toJson() => _$EncodingToJson(this);
}

// Map<String, Referenceable<Header>>? _headersFromJson(dynamic json) {
//   if (json == null) return null;
//   if (json is! Map) return null;
//   final result = <String, Referenceable<Header>>{};
//   for (final entry in json.entries) {
//     final value = Referenceable.fromJson<Header>(entry.value, Header.fromJson);
//     if (value != null) result[entry.key.toString()] = value;
//   }
//   return result;
// }

// Map<String, dynamic>? _headersToJson(Map<String, Referenceable<Header>>? headers) {
//   if (headers == null) return null;
//   final result = <String, dynamic>{};
//   for (final entry in headers.entries) {
//     result[entry.key] = entry.value.isReference() ? entry.value.asReference() : entry.value.asValue()?.toJson();
//   }
//   return result;
// }
