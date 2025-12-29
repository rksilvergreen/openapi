part of '../document.dart';

@CopyWith()
@JsonSerializable()
class XML extends TreeNode {
  final String? name;
  final String? namespace;
  final String? prefix;
  final bool attribute;
  final bool wrapped;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  XML({
    this.name,
    this.namespace,
    this.prefix,
    required this.attribute,
    required this.wrapped,
    this.extensions,
  });

  factory XML.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final xml = _$XMLFromJson(_jsonWithoutExtensions(json));
    return xml.copyWith(extensions: extensions);
  }
}

