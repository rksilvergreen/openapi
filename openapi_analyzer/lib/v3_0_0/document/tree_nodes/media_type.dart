part of '../document.dart';

@CopyWith()
@JsonSerializable()
class MediaType extends TreeNode {
  final SchemasMap? schema;
  final dynamic example;
  final ExamplesMap? examples;
  final EncodingsMap? encoding;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  MediaType({this.schema, this.example, this.examples, this.encoding, this.extensions});

  factory MediaType.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final mediaType = _$MediaTypeFromJson(_jsonWithoutExtensions(json));
    return mediaType.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$MediaTypeToJson(this);
    if (extensions != null) {
      json.addAll(extensions!);
    }
    return json;
  }
}

@JsonSerializable(createFactory: false, createToJson: false)
class MediaTypesMap extends MapTreeNode<MediaType> {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  MediaTypesMap(Map<String, MediaType> mediaTypes, {this.extensions}) : super(mediaTypes);

  factory MediaTypesMap.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final map = _jsonWithoutExtensions(json);
    return MediaTypesMap(map.map((key, value) => MapEntry(key, MediaType.fromJson(value))), extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    for (final entry in entries) {
      json[entry.key] = _$MediaTypeToJson(entry.value);
    }
    if (extensions != null) {
      json.addAll(extensions!);
    }
    return json;
  }
}
