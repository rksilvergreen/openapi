part of '../document.dart';

@CopyWith()
@JsonSerializable()
class Operation extends TreeNode {
  final ExternalDocumentation? externalDocs;
  final ParametersList? parameters;
  final RequestBody? requestBody;
  final ResponsesMap responses;
  final CallbacksMap? callbacks;
  final SecurityRequirementsList? security;
  final ServerList? servers;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  Operation({
    this.externalDocs,
    this.parameters,
    this.requestBody,
    required this.responses,
    this.callbacks,
    this.security,
    this.servers,
    this.extensions,
  });

  factory Operation.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final operation = _$OperationFromJson(_jsonWithoutExtensions(json));
    return operation.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$OperationToJson(this);
    if (extensions != null) {
      json.addAll(extensions!);
    }
    return json;
  }
}
