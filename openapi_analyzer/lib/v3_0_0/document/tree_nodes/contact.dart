part of '../document.dart';

@CopyWith(skipFields: true)
@JsonSerializable()
class Contact {
  final String? name;
  final String? url;
  final String? email;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic> extensions;

  Contact({
    this.name,
    this.url,
    this.email,
    this.extensions = const {},
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final contact = _$ContactFromJson(_jsonWithoutExtensions(json));
    return contact.copyWith(extensions: extensions);
  }

  Map<String, dynamic> toJson() {
    final json = _$ContactToJson(this);
    json.addAll(extensions);
    return json;
  }
}

@CopyWith(skipFields: true)
@JsonSerializable(createFactory: false)
class ContactNode extends TreeNode {
  String? name;
  String? url;
  String? email;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic> extensions;

  ContactNode({
    this.name,
    this.url,
    this.email,
    this.extensions = const {},
  });

  Map<String, dynamic> toJson() {
    final json = _$ContactNodeToJson(this);
    json.addAll(extensions);
    return json;
  }
}
