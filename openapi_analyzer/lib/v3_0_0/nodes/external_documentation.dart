import '../node.dart';

class ExternalDocumentation extends Node {
  final String? description;
  final String url;
  final Map<String, dynamic>? extensions;

  ExternalDocumentation({this.description, required this.url, this.extensions});
}