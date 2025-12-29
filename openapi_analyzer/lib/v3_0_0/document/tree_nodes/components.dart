part of '../document.dart';

@CopyWith()
@JsonSerializable()
class Components extends TreeNode {
  final SchemasMap? schemas;
  final ResponsesMap? responses;
  final ParametersMap? parameters;
  final ExamplesMap? examples;
  final RequestBodiesMap? requestBodies;
  final HeadersMap? headers;
  final SecuritySchemesMap? securitySchemes;
  final LinksMap? links;
  final CallbacksMap? callbacks;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  Components({
    this.schemas,
    this.responses,
    this.parameters,
    this.examples,
    this.requestBodies,
    this.headers,
    this.securitySchemes,
    this.links,
    this.callbacks,
    this.extensions,
  });

  factory Components.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final components = _$ComponentsFromJson(_jsonWithoutExtensions(json));
    return components.copyWith(extensions: extensions);
  }
}

