import 'dart:collection';

void main() {
  final val = Referenceable<int>.fromJson({});
  print(val.value);
}

/// A wrapper that can hold either a reference ($ref) or an actual object.
class Referenceable<T> {
  final String? _ref;
  final T? _value;

  Referenceable.reference(String ref) : _ref = ref, _value = null;
  Referenceable.value(T value) : _ref = null, _value = value;

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
    return _value as T;
  }

  factory Referenceable.fromJson(dynamic json) {
    if (json is String) {
      // It's a reference string
      return Referenceable<T>.reference(json);
    }
    if (json is Map) {
      // Check if it's a reference object with $ref
      if (json.containsKey(r'$ref')) {
        final ref = json[r'$ref'];
        if (ref is String) {
          return Referenceable<T>.reference(ref);
        }
      }
      // It's an actual object, parse it
      return Referenceable<T>.value(getValue<T>());
    }
    throw ArgumentError('Expected String or Map for Referenceable, got ${json.runtimeType}');
  }
}

getValue<T>() {
  if (T == int) {
    return 1;
  }
  if (T == String) {
    return 'sdf';
  }
  if (T == bool) {
    return true;
  }
  if (T == double) {
    return 1.0;
  }
}
