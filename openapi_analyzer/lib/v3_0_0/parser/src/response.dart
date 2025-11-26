import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

import 'openapi_object.dart';
import 'referenceable.dart';
import 'header.dart';
import 'media_type.dart';
import 'link.dart';
import 'json_helpers.dart';

part '_gen/response.g.dart';

/// Describes a single response from an API Operation.
@CopyWith()
@JsonSerializable()
class Response implements OpenapiObject {
  final String description;
  // @JsonKey(fromJson: _headersFromJson, toJson: _headersToJson)
  final Map<String, Referenceable<Header>>? headers;
  final Map<String, MediaType>? content;
  // @JsonKey(fromJson: _linksFromJson, toJson: _linksToJson)
  final Map<String, Referenceable<Link>>? links;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  Response({
    required this.description,
    this.headers,
    this.content,
    this.links,
    this.extensions,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    final extensions = extractExtensions(json);
    final response = _$ResponseFromJson(jsonWithoutExtensions(json));
    return response.copyWith(extensions: extensions);
  }

  @override
  Map<String, dynamic> toJson() => _$ResponseToJson(this);
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

// Map<String, Referenceable<Link>>? _linksFromJson(dynamic json) {
//   if (json == null) return null;
//   if (json is! Map) return null;
//   final result = <String, Referenceable<Link>>{};
//   for (final entry in json.entries) {
//     final value = Referenceable.fromJson<Link>(entry.value, Link.fromJson);
//     if (value != null) result[entry.key.toString()] = value;
//   }
//   return result;
// }

// /// A container for the expected responses of an operation.
// @CopyWith()
// @JsonSerializable(createFactory: false)
// class Responses implements OpenapiObject {
//   @JsonKey(name: 'default', fromJson: _defaultResponseFromJson, toJson: _defaultResponseToJson)
//   final Referenceable<Response>? default_;
//   @JsonKey(fromJson: _responsesFromJson, toJson: _responsesToJson)
//   final Map<String, Referenceable<Response>> responses;
//   @JsonKey(includeFromJson: false, includeToJson: false)
//   final Map<String, dynamic>? extensions;

//   Responses({
//     this.default_,
//     required this.responses,
//     this.extensions,
//   });

//   factory Responses.fromJson(Map<String, dynamic> json) {
//     final extensions = extractExtensions(json);
//     Referenceable<Response>? default_;
//     final responses = <String, Referenceable<Response>>{};
    
//     for (final entry in json.entries) {
//       final key = entry.key.toString();
//       if (key == 'default') {
//         default_ = _defaultResponseFromJson(entry.value);
//       } else if (!key.startsWith('x-')) {
//         final value = Referenceable.fromJson<Response>(entry.value, Response.fromJson);
//         if (value != null) responses[key] = value;
//       }
//     }
    
//     return Responses(
//       default_: default_,
//       responses: responses,
//       extensions: extensions,
//     );
//   }

//   @override
//   Map<String, dynamic> toJson() => _$ResponsesToJson(this);
// }

// Referenceable<Response>? _defaultResponseFromJson(dynamic json) =>
//     Referenceable.fromJson<Response>(json, Response.fromJson);

// dynamic _defaultResponseToJson(Referenceable<Response>? response) {
//   if (response == null) return null;
//   if (response.isReference()) return response.asReference();
//   return response.asValue()?.toJson();
// }

// // _responsesFromJson is not used since we handle it in the custom fromJson factory
// Map<String, Referenceable<Response>> _responsesFromJson(dynamic json) {
//   if (json is! Map) throw ArgumentError('responses must be a Map');
//   final result = <String, Referenceable<Response>>{};
//   for (final entry in json.entries) {
//     final key = entry.key.toString();
//     if (key != 'default' && !key.startsWith('x-')) {
//       final value = Referenceable.fromJson<Response>(entry.value, Response.fromJson);
//       if (value != null) result[key] = value;
//     }
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

// Map<String, dynamic>? _linksToJson(Map<String, Referenceable<Link>>? links) {
//   if (links == null) return null;
//   final result = <String, dynamic>{};
//   for (final entry in links.entries) {
//     result[entry.key] = entry.value.isReference() ? entry.value.asReference() : entry.value.asValue()?.toJson();
//   }
//   return result;
// }

// Map<String, dynamic> _responsesToJson(Map<String, Referenceable<Response>> responses) {
//   final result = <String, dynamic>{};
//   for (final entry in responses.entries) {
//     result[entry.key] = entry.value.isReference() ? entry.value.asReference() : entry.value.asValue()?.toJson();
//   }
//   return result;
// }
