part of '../document.dart';

class Encoding {
  final String? contentType;
  final HeadersMap? headers;
  final ParameterStyle? style;
  final bool? explode;
  final bool allowReserved;
  final Map<String, dynamic>? extensions;

  Encoding({
    required this.contentType,
    required this.headers,
    required this.style,
    required this.explode,
    required this.allowReserved,
    this.extensions,
  });
}

@CopyWith(skipFields: true)
@JsonSerializable()
class EncodingNode extends TreeNode {
  final String? contentType;
  // final HeadersMap? headers;
  HeadersMap? get headers => _$children['headers']?.child as HeadersMap?;
  final ParameterStyle? style;
  final bool? explode;
  final bool allowReserved;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  EncodingNode({
    required this.contentType,
    HeadersMap? headers,
    required this.style,
    required this.explode,
    required this.allowReserved,
    this.extensions,
  }) {
    _$children['headers'] = headers == null ? null : Edge(this, headers, 'headers');
  }

  factory EncodingNode.from(Encoding encoding) {
    
  }

  factory EncodingNode.fromJson(Map<String, dynamic> json) {
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

@JsonSerializable(createFactory: false, createToJson: false)
class EncodingsMap extends MapTreeNode<Encoding> {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  EncodingsMap(Map<String, Encoding> encodings, {this.extensions}) : super(encodings);

  factory EncodingsMap.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final map = _jsonWithoutExtensions(json);
    return EncodingsMap(map.map((key, value) => MapEntry(key, Encoding.fromJson(value))), extensions: extensions);
  }

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
