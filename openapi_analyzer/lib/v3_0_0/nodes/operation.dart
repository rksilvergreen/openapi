import 'external_documentation.dart';
import 'request_body.dart';
import 'server.dart';
import 'parameter.dart';
import 'response.dart';
import 'callback.dart';
import 'security_requirement.dart';
import '../node.dart';

class Operation extends Node {
  final ExternalDocumentation? externalDocs;
  final ParametersList? parameters;
  final RequestBody? requestBody;
  final ResponsesMap responses;
  final CallbacksMap? callbacks;
  final SecurityRequirementsList? security;
  final ServerList? servers;
  final String $name;

  Operation({this.externalDocs, this.parameters, this.requestBody, required this.responses, this.callbacks, this.security, this.servers, required this.$name});
}
