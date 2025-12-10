import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

import '../openapi_object.dart';
import '../openapi_graph.dart';
import 'info.dart';
import 'server.dart';
import 'paths.dart';
import 'components.dart';
import 'security.dart';
import 'tag.dart';
import 'external_documentation.dart';

part '_gen/openapi_document.g.dart';

class OpenApiDocumentNode implements OpenApiNode {
  final NodeId $id;
  OpenApiDocumentNode({required this.$id});

 

  validate(Map<String, dynamic> json) {} // not recursive


  void createChildNodes(Map<String, dynamic> json) {
  }

  late InfoNode info;

  createContent(Map<String, dynamic> json) {
    
  }

   OpenApiDocument content;
}

/// Root document object of the OpenAPI document.
@CopyWith()
@JsonSerializable()
class OpenApiDocument {
  final NodeId $id;
  OpenApiDocumentNode? _$node;
  OpenApiDocumentNode get _node => _$node ??= OpenApiRegistry.i.openApiNodes[$id.absolutePath]! as OpenApiDocumentNode;
  final String openapi;
  Info get info => _node.info.content;
  // final Info info;
  final List<Server>? servers;
  final Paths paths;
  final Components? components;
  final List<SecurityRequirement>? security;
  final List<Tag>? tags;
  final ExternalDocumentation? externalDocs;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  OpenApiDocument({
    required this.$id,
    required this.openapi,
    required this.info,
    this.servers,
    required this.paths,
    this.components,
    this.security,
    this.tags,
    this.externalDocs,
    this.extensions,
  });

  factory OpenApiDocument.fromJson(Map<String, dynamic> json) {
    validate(json);
    Info info = Info.fromJson(json['info']);
    
    // final extensions = OpenapiObject.extractExtensions(json);
    // final doc = _$OpenApiDocumentFromJson(OpenapiObject.jsonWithoutExtensions(json));
    // return doc.copyWith(extensions: extensions);
  }

  static validate(Map<String, dynamic> json) {}

  static createChildNodes(Map<String, dynamic> json) {}



  static _createInfo(Map<String, dynamic> json) {
    OpenApiRegistry.i.addOpenApiNode(Info.fromJson(json));
  }

  @override
  Map<String, dynamic> toJson() => _$OpenApiDocumentToJson(this);
}
