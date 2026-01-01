part of '../document.dart';

@CopyWith(skipFields: true)
@JsonSerializable()
class Encoding {
  final String? contentType;
  final Map<String, Header>? headers;
  final ParameterStyle? style;
  final bool? explode;
  final bool allowReserved;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic> extensions;

  Encoding({
    required this.contentType,
    required this.headers,
    required this.style,
    required this.explode,
    required this.allowReserved,
    this.extensions = const {},
  });

  factory Encoding.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final encoding = _$EncodingFromJson(_jsonWithoutExtensions(json));
    return encoding.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$EncodingToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@CopyWith(skipFields: true)
@JsonSerializable(createFactory: false)
class EncodingNode extends TreeNode {
  String? contentType;
  HeadersMapNode? get headers => $children?['headers'] as HeadersMapNode?;
  ParameterStyle? style;
  bool? explode;
  bool allowReserved;
  Map<String, dynamic> extensions;

  EncodingNode({
    required this.contentType,
    required this.style,
    required this.explode,
    required this.allowReserved,
    this.extensions = const {},
  });
}

@JsonSerializable(createFactory: false, createToJson: false)
class EncodingsMapNode extends MapTreeNode<EncodingNode> {
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    final children = $children ?? <String, EncodingNode>{};
    for (final entry in children.entries) {
      json[entry.key] = _$EncodingNodeToJson(entry.value);
    }
    return json;
  }
}
