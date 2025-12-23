import 'callback.dart';
import 'response.dart';
import 'parameter.dart';
import 'example.dart';
import 'request_body.dart';
import 'header.dart';
import 'security_scheme.dart';
import 'link.dart';
import 'schema/schema.dart';


abstract class Components {
  SchemasMap? get schemas;
  ResponsesMap? get responses;
  ParametersMap? get parameters;
  ExamplesMap? get examples;
  RequestBodiesMap? get requestBodies;
  HeadersMap? get headers;
  SecuritySchemesMap? get securitySchemes;
  LinksMap? get links;
  CallbacksMap? get callbacks;
  Map<String, dynamic>? get extensions;
}