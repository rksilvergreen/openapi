import 'dart:collection';
import 'external_documentation.dart';

abstract class Tag {
  String get name;
  String? get description;
  ExternalDocumentation? get externalDocs;
  Map<String, dynamic>? get extensions;
}

abstract class TagsList implements ListBase<Tag> {}

