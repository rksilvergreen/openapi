import '../node.dart';

class Contact extends Node {
  final String? name;
  final String? url;
  final String? email;
  final Map<String, dynamic>? extensions;

  Contact({this.name, this.url, this.email, this.extensions});
}