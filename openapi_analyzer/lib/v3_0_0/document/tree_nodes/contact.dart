part of '../document.dart';

@CopyWith()
@JsonSerializable()
class Contact extends TreeNode {
  final String? name;
  final String? url;
  final String? email;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? extensions;

  Contact({this.name, this.url, this.email, this.extensions});

  factory Contact.fromJson(Map<String, dynamic> json) {
    final extensions = _extractExtensions(json);
    final contact = _$ContactFromJson(_jsonWithoutExtensions(json));
    return contact.copyWith(extensions: extensions);
  }
}
