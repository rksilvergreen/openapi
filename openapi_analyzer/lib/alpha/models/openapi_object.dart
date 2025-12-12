import 'openapi_objects/callback.dart';
import 'openapi_objects/components.dart';
import 'openapi_objects/discriminator.dart';
import 'openapi_objects/example.dart';
import 'openapi_objects/external_documentation.dart';
import 'openapi_objects/header.dart';
import 'openapi_objects/info.dart';
import 'openapi_objects/link.dart';
import 'openapi_objects/media_type.dart';
import 'openapi_objects/openapi_document.dart';
import 'openapi_objects/operation.dart';
import 'openapi_objects/parameter.dart';
import 'openapi_objects/paths.dart';
import 'openapi_objects/request_body.dart';
import 'openapi_objects/response.dart';
import 'openapi_objects/schema/raw_schema.dart';
import 'openapi_objects/security.dart';
import 'openapi_objects/server.dart';
import 'openapi_objects/tag.dart';
import 'openapi_objects/xml.dart';

abstract class OpenapiObject {
  /// Helper function to extract x-* extension fields from JSON map.
  static Map<String, dynamic>? extractExtensions(Map<String, dynamic> json) {
    final extensions = <String, dynamic>{};
    for (final entry in json.entries) {
      if (entry.key.startsWith('x-')) {
        extensions[entry.key] = entry.value;
      }
    }
    return extensions.isEmpty ? null : extensions;
  }

  /// Helper function to create a copy of JSON map without x-* fields.
  static Map<String, dynamic> jsonWithoutExtensions(Map<String, dynamic> json) {
    final result = <String, dynamic>{};
    for (final entry in json.entries) {
      if (!entry.key.startsWith('x-')) {
        result[entry.key] = entry.value;
      }
    }
    return result;
  }

  Map<String, dynamic> toJson();

  static fromJson<T>(Map<String, dynamic> json) {
    switch (T) {
      case Callback:
        return Callback.fromJson(json);
      case Components:
        return Components.fromJson(json);
      case Discriminator:
        return Discriminator.fromJson(json);
      case Example:
        return Example.fromJson(json);
      case ExternalDocumentation:
        return ExternalDocumentation.fromJson(json);
      case Header:
        return Header.fromJson(json);
      case Info:
        return Info.fromJson(json);
      case Link:
        return Link.fromJson(json);
      case MediaType:
        return MediaType.fromJson(json);
      case OpenApiDocument:
        return OpenApiDocument.fromJson(json);
      case Operation:
        return Operation.fromJson(json);
      case Parameter:
        return Parameter.fromJson(json);
      case Paths:
        return Paths.fromJson(json);
      case RequestBody:
        return RequestBody.fromJson(json);
      case Response:
        return Response.fromJson(json);
      case SchemaObject:
        return SchemaObject.fromJson(json);
      case SecurityRequirement:
        return SecurityRequirement.fromJson(json);
      case SecurityScheme:
        return SecurityScheme.fromJson(json);
      case Server:
        return Server.fromJson(json);
      case Tag:
        return Tag.fromJson(json);
      case XML:
        return XML.fromJson(json);
      default:
        throw ArgumentError('Invalid OpenAPI object type: $T');
    }
  }
}
