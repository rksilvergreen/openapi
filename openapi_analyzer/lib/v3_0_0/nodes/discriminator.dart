import '../node.dart';

class Discriminator extends Node {
  final String propertyName;
  final Map<String, String>? mapping;
  final Map<String, dynamic>? extensions;

  Discriminator({required this.propertyName, this.mapping, this.extensions});
}