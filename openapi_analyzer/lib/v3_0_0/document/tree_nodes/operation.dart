part of '../document.dart';

@CopyWith(skipFields: true)
@JsonSerializable()
class Operation {
  final ExternalDocumentation? externalDocs;
  final List<Parameter>? parameters;
  final RequestBody? requestBody;
  @JsonKey(required: true, disallowNullValue: true)
  final Map<String, Response> responses;
  final Map<String, Callback>? callbacks;
  final List<SecurityRequirement>? security;
  final List<Server>? servers;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic> extensions;

  Operation({
    this.externalDocs,
    this.parameters,
    this.requestBody,
    required this.responses,
    this.callbacks,
    this.security,
    this.servers,
    this.extensions = const {},
  });

  factory Operation.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final operation = _$OperationFromJson(_jsonWithoutExtensions(json));
    return operation.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$OperationToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@CopyWith(skipFields: true)
@JsonSerializable(createFactory: false)
class OperationNode extends TreeNode {
  ExternalDocumentationNode? get externalDocs => $children?['externalDocs'] as ExternalDocumentationNode?;
  ParametersListNode? get parameters => $children?['parameters'] as ParametersListNode?;
  RequestBodyNode? get requestBody => $children?['requestBody'] as RequestBodyNode?;
  ResponsesMapNode? get responses => $children?['responses'] as ResponsesMapNode?;
  CallbacksMapNode? get callbacks => $children?['callbacks'] as CallbacksMapNode?;
  SecurityRequirementsList? get security => $children?['security'] as SecurityRequirementsList?;
  ServerList? get servers => $children?['servers'] as ServerList?;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic> extensions;

  OperationNode({
    this.extensions = const {},
  });

  Map<String, dynamic> toJson() {
    final json = _$OperationNodeToJson(this);
    json.addAll(extensions);
    return json;
  }
}
