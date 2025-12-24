import 'callback.dart';
import 'response.dart';
import 'parameter.dart';
import 'example.dart';
import 'request_body.dart';
import 'header.dart';
import 'security_scheme.dart';
import 'link.dart';
import 'schema/schema.dart';
import '../node.dart';

class Components extends Node {
  final SchemasMap? schemas;
  final ResponsesMap? responses;
  final ParametersMap? parameters;
  final ExamplesMap? examples;
  final RequestBodiesMap? requestBodies;
  final HeadersMap? headers;
  final SecuritySchemesMap? securitySchemes;
  final LinksMap? links;
  final CallbacksMap? callbacks;
  final Map<String, dynamic>? extensions;

  Components({this.schemas, this.responses, this.parameters, this.examples, this.requestBodies, this.headers, this.securitySchemes, this.links, this.callbacks, this.extensions});
}