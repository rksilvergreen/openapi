import 'dart:collection';

abstract class Encoding {
  String? get contentType;
  HeadersMap? get headers;
  ParameterStyle? get style;
  bool? get explode;
  bool get allowReserved;
  Map<String, dynamic>? get extensions;
}

abstract class EncodingsMap implements MapBase<String, Encoding> {
  Map<String, dynamic>? get extensions;
}