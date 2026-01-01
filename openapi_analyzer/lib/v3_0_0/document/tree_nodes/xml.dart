part of '../document.dart';

@CopyWith(skipFields: true)
@JsonSerializable()
class XML {
  final String? name;
  final String? namespace;
  final String? prefix;
  @JsonKey(required: true, disallowNullValue: true)
  final bool attribute;
  @JsonKey(required: true, disallowNullValue: true)
  final bool wrapped;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic> extensions;

  XML({
    this.name,
    this.namespace,
    this.prefix,
    required this.attribute,
    required this.wrapped,
    this.extensions = const {},
  });

  factory XML.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final xml = _$XMLFromJson(_jsonWithoutExtensions(json));
    return xml.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$XMLToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@CopyWith(skipFields: true)
@JsonSerializable(createFactory: false)
class XMLNode extends TreeNode {
  String? name;
  String? namespace;
  String? prefix;
  bool attribute;
  bool wrapped;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic> extensions;

  XMLNode({
    this.name,
    this.namespace,
    this.prefix,
    required this.attribute,
    required this.wrapped,
    this.extensions = const {},
  });

  Map<String, dynamic> toJson() {
    final json = _$XMLNodeToJson(this);
    json.addAll(extensions);
    return json;
  }
}

