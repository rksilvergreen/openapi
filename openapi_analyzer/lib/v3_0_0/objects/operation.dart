import 'external_documentation.dart';
import 'request_body.dart';
import 'server.dart';
import 'parameter.dart';
import 'response.dart';
import 'callback.dart';
import 'security_requirement.dart';

abstract class Operation {
  ExternalDocumentation? get externalDocs;
  ParametersList? get parameters;
  RequestBody? get requestBody;
  ResponsesMap get responses;
  CallbacksMap? get callbacks;
  SecurityRequirementsList? get security;
  ServerList? get servers;

  String get $name;
}

