import '../openapi_graph.dart';
import '../validation/validation_utils.dart';
import '../../../validation_exception.dart';
import '../edge.dart';
import '../node.dart';
import 'schema/schema.dart';
import 'responses_map.dart';
import 'parameters_map.dart';
import 'examples_map.dart';
import 'request_bodies_map.dart';
import 'headers_map.dart';
import 'security_schemes_map.dart';
import 'links_map.dart';
import 'callback.dart';
import 'schema/schema_map.dart';

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