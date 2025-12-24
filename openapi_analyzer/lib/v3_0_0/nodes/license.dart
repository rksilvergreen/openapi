import '../node.dart';

class License extends Node {
  final String name;
  final String? url;
  final Map<String, dynamic>? extensions;

  License({required this.name, this.url, this.extensions});
}

