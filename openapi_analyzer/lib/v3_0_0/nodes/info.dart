import 'contact.dart';
import 'license.dart';
import '../node.dart';

class Info extends Node {
  final String title;
  final String? description;
  final String? termsOfService;
  final Contact? contact;
  final License? license;
  final String version;
  final Map<String, dynamic>? extensions;

  Info({
    required this.title,
    this.description,
    this.termsOfService,
    this.contact,
    this.license,
    required this.version,
    this.extensions,
  });
}
