import 'dart:collection';

abstract class Example {
  String? get summary;
  String? get description;
  dynamic get value;
  String? get externalValue;
  Map<String, dynamic>? get extensions;
}

abstract class ExamplesMap implements MapBase<String, Example> {
  Map<String, dynamic>? get extensions;
}