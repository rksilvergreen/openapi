import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

import 'openapi_object.dart';
import 'referenceable.dart';
import 'schema_object.dart';
import 'response.dart';
import 'parameter.dart';
import 'example.dart';
import 'request_body.dart';
import 'header.dart';
import 'security.dart';
import 'link.dart';
import 'callback.dart';
import 'json_helpers.dart';

part '_gen/components.g.dart';

/// Holds a set of reusable objects for different aspects of the OAS.
@CopyWith()
@JsonSerializable()
class Components implements OpenapiObject {
  // @JsonKey(fromJson: _schemasFromJson, toJson: _schemasToJson)
  final Map<String, Referenceable<SchemaObject>>? schemas;
  // @JsonKey(fromJson: _responsesFromJson, toJson: _responsesToJson)
  final Map<String, Referenceable<Response>>? responses;
  // @JsonKey(fromJson: _parametersFromJson, toJson: _parametersToJson)
  final Map<String, Referenceable<Parameter>>? parameters;
  // @JsonKey(fromJson: _examplesFromJson, toJson: _examplesToJson)
  final Map<String, Referenceable<Example>>? examples;
  // @JsonKey(fromJson: _requestBodiesFromJson, toJson: _requestBodiesToJson)
  final Map<String, Referenceable<RequestBody>>? requestBodies;
  // @JsonKey(fromJson: _headersFromJson, toJson: _headersToJson)
  final Map<String, Referenceable<Header>>? headers;
  // @JsonKey(fromJson: _securitySchemesFromJson, toJson: _securitySchemesToJson)
  final Map<String, Referenceable<SecurityScheme>>? securitySchemes;
  // @JsonKey(fromJson: _linksFromJson, toJson: _linksToJson)
  final Map<String, Referenceable<Link>>? links;
  // @JsonKey(fromJson: _callbacksFromJson, toJson: _callbacksToJson)
  final Map<String, Referenceable<Callback>>? callbacks;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  Components({
    this.schemas,
    this.responses,
    this.parameters,
    this.examples,
    this.requestBodies,
    this.headers,
    this.securitySchemes,
    this.links,
    this.callbacks,
    this.extensions,
  });

  factory Components.fromJson(Map<String, dynamic> json) {
    final extensions = extractExtensions(json);
    final components = _$ComponentsFromJson(jsonWithoutExtensions(json));
    return components.copyWith(extensions: extensions);
  }

  @override
  Map<String, dynamic> toJson() => _$ComponentsToJson(this);
}

// Map<String, Referenceable<SchemaObject>>? _schemasFromJson(dynamic json) {
//   if (json == null) return null;
//   if (json is! Map) return null;
//   final result = <String, Referenceable<SchemaObject>>{};
//   for (final entry in json.entries) {
//     final value = Referenceable.fromJson<SchemaObject>(entry.value, SchemaObject.fromJson);
//     if (value != null) {
//       result[entry.key.toString()] = value;
//     }
//   }
//   return result;
// }

// Map<String, Referenceable<Response>>? _responsesFromJson(dynamic json) {
//   if (json == null) return null;
//   if (json is! Map) return null;
//   final result = <String, Referenceable<Response>>{};
//   for (final entry in json.entries) {
//     final value = Referenceable.fromJson<Response>(entry.value, Response.fromJson);
//     if (value != null) result[entry.key.toString()] = value;
//   }
//   return result;
// }

// Map<String, Referenceable<Parameter>>? _parametersFromJson(dynamic json) {
//   if (json == null) return null;
//   if (json is! Map) return null;
//   final result = <String, Referenceable<Parameter>>{};
//   for (final entry in json.entries) {
//     final value = Referenceable.fromJson<Parameter>(entry.value, Parameter.fromJson);
//     if (value != null) result[entry.key.toString()] = value;
//   }
//   return result;
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

// Map<String, Referenceable<RequestBody>>? _requestBodiesFromJson(dynamic json) {
//   if (json == null) return null;
//   if (json is! Map) return null;
//   final result = <String, Referenceable<RequestBody>>{};
//   for (final entry in json.entries) {
//     final value = Referenceable.fromJson<RequestBody>(entry.value, RequestBody.fromJson);
//     if (value != null) result[entry.key.toString()] = value;
//   }
//   return result;
// }

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

// Map<String, Referenceable<SecurityScheme>>? _securitySchemesFromJson(dynamic json) {
//   if (json == null) return null;
//   if (json is! Map) return null;
//   final result = <String, Referenceable<SecurityScheme>>{};
//   for (final entry in json.entries) {
//     final value = Referenceable.fromJson<SecurityScheme>(entry.value, SecurityScheme.fromJson);
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

// Map<String, dynamic>? _schemasToJson(Map<String, Referenceable<SchemaObject>>? schemas) {
//   if (schemas == null) return null;
//   final result = <String, dynamic>{};
//   for (final entry in schemas.entries) {
//     result[entry.key] = entry.value.isReference() ? entry.value.asReference() : entry.value.asValue()?.toJson();
//   }
//   return result;
// }

// Map<String, dynamic>? _responsesToJson(Map<String, Referenceable<Response>>? responses) {
//   if (responses == null) return null;
//   final result = <String, dynamic>{};
//   for (final entry in responses.entries) {
//     result[entry.key] = entry.value.isReference() ? entry.value.asReference() : entry.value.asValue()?.toJson();
//   }
//   return result;
// }

// Map<String, dynamic>? _parametersToJson(Map<String, Referenceable<Parameter>>? parameters) {
//   if (parameters == null) return null;
//   final result = <String, dynamic>{};
//   for (final entry in parameters.entries) {
//     result[entry.key] = entry.value.isReference() ? entry.value.asReference() : entry.value.asValue()?.toJson();
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

// Map<String, dynamic>? _requestBodiesToJson(Map<String, Referenceable<RequestBody>>? requestBodies) {
//   if (requestBodies == null) return null;
//   final result = <String, dynamic>{};
//   for (final entry in requestBodies.entries) {
//     result[entry.key] = entry.value.isReference() ? entry.value.asReference() : entry.value.asValue()?.toJson();
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

// Map<String, dynamic>? _securitySchemesToJson(Map<String, Referenceable<SecurityScheme>>? securitySchemes) {
//   if (securitySchemes == null) return null;
//   final result = <String, dynamic>{};
//   for (final entry in securitySchemes.entries) {
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

// Map<String, dynamic>? _callbacksToJson(Map<String, Referenceable<Callback>>? callbacks) {
//   if (callbacks == null) return null;
//   final result = <String, dynamic>{};
//   for (final entry in callbacks.entries) {
//     result[entry.key] = entry.value.isReference() ? entry.value.asReference() : entry.value.asValue()?.toJson();
//   }
//   return result;
// }
