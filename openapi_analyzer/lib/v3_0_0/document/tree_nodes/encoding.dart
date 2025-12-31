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
  final Map<String, dynamic>? extensions;

  Encoding({
    required this.contentType,
    required this.headers,
    required this.style,
    required this.explode,
    required this.allowReserved,
    this.extensions,
  });

  factory Encoding.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final encoding = _$EncodingFromJson(_jsonWithoutExtensions(json));
    return encoding.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$EncodingToJson(this);
    if (extensions != null) {
      json.addAll(extensions!);
    }
    return json;
  }
}

class EncodingNode extends TreeNode {
  String? contentType;
  HeadersMap? get headers => $children?['headers'] as HeadersMap?;
  ParameterStyle? style;
  bool? explode;
  bool allowReserved;
  Map<String, dynamic>? extensions;

  EncodingNode({
    required this.contentType,
    required this.style,
    required this.explode,
    required this.allowReserved,
    this.extensions,
  });
}

class EncodingsMapNode extends MapTreeNode<EncodingNode> {
  final Map<String, dynamic>? extensions;

  EncodingsMapNode(Map<String, EncodingNode> encodings, {this.extensions}) : super(encodings);

  // factory EncodingsMap.fromJson(Map<String, dynamic> json) {
  //   final extensions = _extractExtensions(json);
  //   final map = _jsonWithoutExtensions(json);
  //   return EncodingsMap(map.map((key, value) => MapEntry(key, Encoding.fromJson(value))), extensions: extensions);
  // }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    for (final entry in entries) {
      json[entry.key] = _$EncodingToJson(entry.value);
    }
    if (extensions != null) {
      json.addAll(extensions!);
    }
    return json;
  }
}
