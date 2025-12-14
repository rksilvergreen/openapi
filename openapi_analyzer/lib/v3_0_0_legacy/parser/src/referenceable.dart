import 'package:json_annotation/json_annotation.dart';
import 'openapi_object.dart';

/// A wrapper that can hold either a reference ($ref) or an actual object.
@JsonSerializable(createFactory: false, createToJson: false)
class Referenceable<T extends OpenapiObject> {
  final String? _ref;

  // @JsonKey(includeFromJson: false, includeToJson: false)
  final T? _value;

  Referenceable(this._ref, this._value);

  Referenceable.reference(String ref) : _ref = ref, _value = null;
  Referenceable.value(T? value) : _ref = null, _value = value;

  /// Returns true if this is a reference.
  bool isReference() => _ref != null;

  /// Returns the reference string if this is a reference, null otherwise.
  String? asReference() => _ref;

  /// Returns the actual value if this is not a reference, null otherwise.
  T? asValue() => _value;

  /// Gets the value, throwing if this is a reference.
  T get value {
    if (_ref != null) {
      throw StateError('Cannot get value from a reference: $_ref');
    }
    if (_value == null) {
      throw StateError('Value is null');
    }
    return value;
  }

  /// Parses a Referenceable<T> from JSON.
  /// Returns null if json is null.
  /// Accepts either a string (reference), or a Map (reference object or actual value).
  factory Referenceable.fromJson(dynamic json) {
    if (json == null) return Referenceable<T>.value(null);

    if (json is String) {
      // It's a reference string
      return Referenceable<T>.reference(json);
    }
    if (json is Map<String, dynamic>) {
      // Check if it's a reference object with $ref
      if (json.containsKey(r'$ref')) {
        final ref = json[r'$ref'];
        if (ref is String) {
          return Referenceable<T>.reference(ref);
        }
      }
      // It's an actual object, parse it
      return Referenceable<T>.value(OpenapiObject.fromJson<T>(json));
    }
    throw ArgumentError('Expected String or Map for Referenceable, got ${json.runtimeType}');
  }

  dynamic toJson() {
    if (isReference()) return asReference();
    return asValue()?.toJson();
  }
}
