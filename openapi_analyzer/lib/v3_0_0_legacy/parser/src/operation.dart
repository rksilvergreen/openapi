import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

import 'openapi_object.dart';
import 'referenceable.dart';
import 'parameter.dart';
import 'request_body.dart';
import 'response.dart';
import 'callback.dart';
import 'security.dart';
import 'server.dart';
import 'external_documentation.dart';
import 'json_helpers.dart';

part '_gen/operation.g.dart';

/// Describes a single API operation on a path.
@CopyWith()
@JsonSerializable()
class Operation implements OpenapiObject {
  final List<String>? tags;
  final String? summary;
  final String? description;
  final ExternalDocumentation? externalDocs;
  final String? operationId;
  // @JsonKey(fromJson: _parametersFromJson, toJson: _parametersToJson)
  final List<Referenceable<Parameter>>? parameters;
  // @JsonKey(fromJson: _requestBodyFromJson, toJson: _requestBodyToJson)
  final Referenceable<RequestBody>? requestBody;
  final Map<String, Referenceable<Response>> responses;
  // @JsonKey(fromJson: _callbacksFromJson, toJson: _callbacksToJson)
  final Map<String, Referenceable<Callback>>? callbacks;
  final bool deprecated;
  final List<SecurityRequirement>? security;
  final List<Server>? servers;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  Operation({
    this.tags,
    this.summary,
    this.description,
    this.externalDocs,
    this.operationId,
    this.parameters,
    this.requestBody,
    required this.responses,
    this.callbacks,
    this.deprecated = false,
    this.security,
    this.servers,
    this.extensions,
  });

  factory Operation.fromJson(Map<String, dynamic> json) {
    final extensions = extractExtensions(json);
    final operation = _$OperationFromJson(jsonWithoutExtensions(json));
    return operation.copyWith(extensions: extensions);
  }

  @override
  Map<String, dynamic> toJson() => _$OperationToJson(this);
}

// List<Referenceable<Parameter>>? _parametersFromJson(dynamic json) {
//   if (json == null) return null;
//   if (json is! List) return null;
//   return json.map((item) => Referenceable.fromJson<Parameter>(item, Parameter.fromJson)).whereType<Referenceable<Parameter>>().toList();
// }

// Referenceable<RequestBody>? _requestBodyFromJson(dynamic json) =>
//     Referenceable.fromJson<RequestBody>(json, RequestBody.fromJson);

// Map<String, Referenceable<Callback>>? _callbacksFromJson(dynamic json) {
//   if (json == null) return null;
//   if (json is! Map) return null;
//   final result = <String, Referenceable<Callback>>{};
//   for (final entry in json.entries) {
//     final value = Referenceable.fromJson<Callback>(entry.value, Callback.fromJson);
//     if (value != null) result[entry.key.toString()] = value;
//   }
//   return result;
// }

// List<dynamic>? _parametersToJson(List<Referenceable<Parameter>>? parameters) {
//   if (parameters == null) return null;
//   return parameters.map((p) {
//     if (p.isReference()) return p.asReference();
//     return p.asValue()?.toJson();
//   }).toList();
// }

// dynamic _requestBodyToJson(Referenceable<RequestBody>? requestBody) {
//   if (requestBody == null) return null;
//   if (requestBody.isReference()) return requestBody.asReference();
//   return requestBody.asValue()?.toJson();
// }

// Map<String, dynamic>? _callbacksToJson(Map<String, Referenceable<Callback>>? callbacks) {
//   if (callbacks == null) return null;
//   final result = <String, dynamic>{};
//   for (final entry in callbacks.entries) {
//     result[entry.key] = entry.value.isReference() ? entry.value.asReference() : entry.value.asValue()?.toJson();
//   }
//   return result;
// }
