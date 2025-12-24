import 'contact.dart';
import 'license.dart';

abstract class Info {
  String get title;
  String? get description;
  String? get termsOfService;
  Contact? get contact;
  License? get license;
  String get version;
  Map<String, dynamic>? get extensions;
}

