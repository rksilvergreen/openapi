import 'callback.dart';
import 'components.dart';
import 'discriminator.dart';
import 'example.dart';
import 'external_documentation.dart';
import 'header.dart';
import 'info.dart';
import 'link.dart';
import 'media_type.dart';
import 'openapi_document.dart';
import 'operation.dart';
import 'parameter.dart';
import 'paths.dart';
import 'request_body.dart';
import 'response.dart';
import 'schema_object.dart';
import 'security.dart';
import 'server.dart';
import 'tag.dart';
import 'xml.dart';

abstract interface class OpenapiObject {
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
