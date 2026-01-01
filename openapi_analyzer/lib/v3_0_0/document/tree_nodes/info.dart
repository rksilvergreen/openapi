part of '../document.dart';

@CopyWith(skipFields: true)
@JsonSerializable()
class Info {
  @JsonKey(required: true, disallowNullValue: true)
  final String title;
  final String? description;
  final String? termsOfService;
  final Contact? contact;
  final License? license;
  @JsonKey(required: true, disallowNullValue: true)
  final String version;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic> extensions;

  Info({
    required this.title,
    this.description,
    this.termsOfService,
    this.contact,
    this.license,
    required this.version,
    this.extensions = const {},
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final info = _$InfoFromJson(_jsonWithoutExtensions(json));
    return info.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$InfoToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@CopyWith(skipFields: true)
@JsonSerializable(createFactory: false)
class InfoNode extends TreeNode {
  String title;
  String? description;
  String? termsOfService;
  ContactNode? get contact => $children?['contact'] as ContactNode?;
  LicenseNode? get license => $children?['license'] as LicenseNode?;
  String version;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic> extensions;

  InfoNode({
    required this.title,
    this.description,
    this.termsOfService,
    required this.version,
    this.extensions = const {},
  });

  Map<String, dynamic> toJson() {
    final json = _$InfoNodeToJson(this);
    json.addAll(extensions);
    return json;
  }
}

