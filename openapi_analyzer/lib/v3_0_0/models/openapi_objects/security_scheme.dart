import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../referencable.dart';
import '../node_creation_helpers.dart';
import 'enums.dart';
import 'oauth_flows.dart';

abstract class SecurityScheme {
  SecuritySchemeType get type;
  String? get description;
  String? get name;
  SecuritySchemeIn? get in_;
  String? get scheme;
  String? get bearerFormat;
  OAuthFlows? get flows;
  String? get openIdConnectUrl;
  Map<String, dynamic>? get extensions;
}

class SecuritySchemeNode extends OpenApiNode with InternalNode, Referencable implements SecurityScheme {
  SecuritySchemeNode(Map<String, dynamic> json, String document, String jsonPointer)
    : super(NodeId(document, jsonPointer), json);

  late final SecuritySchemeType type;
  late final String? description;
  late final String? name;
  late final SecuritySchemeIn? in_;
  late final String? scheme;
  late final String? bearerFormat;
  late final OAuthFlowsNode? flows;
  late final String? openIdConnectUrl;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    // Validate required: type (enum: apiKey, http, oauth2, openIdConnect)
    final type = ValidationUtils.requireField(json, 'type', jsonPointer);
    ValidationUtils.requireString(type, ValidationUtils.buildPointer([jsonPointer, 'type']));
    ValidationUtils.validateEnum(type as String, [
      'apiKey',
      'http',
      'oauth2',
      'openIdConnect',
    ], ValidationUtils.buildPointer([jsonPointer, 'type']));

    // Validate required fields based on type
    if (type == 'apiKey') {
      ValidationUtils.requireField(json, 'name', jsonPointer);
      ValidationUtils.requireString(json['name'], ValidationUtils.buildPointer([jsonPointer, 'name']));

      final inValue = ValidationUtils.requireField(json, 'in', jsonPointer);
      ValidationUtils.requireString(inValue, ValidationUtils.buildPointer([jsonPointer, 'in']));
      ValidationUtils.validateEnum(inValue as String, [
        'query',
        'header',
        'cookie',
      ], ValidationUtils.buildPointer([jsonPointer, 'in']));
    } else if (type == 'http') {
      ValidationUtils.requireField(json, 'scheme', jsonPointer);
      ValidationUtils.requireString(json['scheme'], ValidationUtils.buildPointer([jsonPointer, 'scheme']));
    } else if (type == 'oauth2') {
      ValidationUtils.requireField(json, 'flows', jsonPointer);
      ValidationUtils.requireMap(json['flows'], ValidationUtils.buildPointer([jsonPointer, 'flows']));
    } else if (type == 'openIdConnect') {
      ValidationUtils.requireField(json, 'openIdConnectUrl', jsonPointer);
      ValidationUtils.requireString(
        json['openIdConnectUrl'],
        ValidationUtils.buildPointer([jsonPointer, 'openIdConnectUrl']),
      );
    }

    // Validate optional: description (string)
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPointer([jsonPointer, 'description']));
    }

    // Validate no unknown fields
    ValidationUtils.validateNoUnknownFields(
      json,
      {'type', 'description', 'name', 'in', 'scheme', 'bearerFormat', 'flows', 'openIdConnectUrl'},
      jsonPointer,
      'Security Scheme Object',
    );
  }

  @override
  void createChildNodes() {
    createNode<OAuthFlowsNode>(jsonKey: 'flows');
  }

  @override
  void createContent() {
    type = SecuritySchemeType.values.firstWhere((e) => e.value == json['type']);
    description = json['description'];
    name = json['name'];
    in_ = json['in'] != null ? SecuritySchemeIn.values.firstWhere((e) => e.value == json['in']) : null;
    scheme = json['scheme'];
    bearerFormat = json['bearerFormat'];
    flows = $to.to<OAuthFlowsNode>('flows');
    openIdConnectUrl = json['openIdConnectUrl'];
    extensions = extractExtensions(json);
  }
}
