part of 'document.dart';

/// A wrapper that can hold either a reference ($ref) or an actual object.
@JsonSerializable(createFactory: false, createToJson: false)
class Ref<T> {
  final String? _ref;
  final T? _value;

  Ref.reference(String ref) : _ref = ref, _value = null;
  Ref.value(T value) : _ref = null, _value = value;

  /// Returns true if this is a reference.
  bool isReference() => _ref != null;

  /// Returns the reference string if this is a reference, null otherwise.
  String? asReference() => _ref;

  /// Returns the actual value if this is not a reference, null otherwise.
  T? asValue() => _value;

  factory Ref.fromJson(dynamic json) {
    if (json is String) {
      // It's a reference string
      return Ref<T>.reference(json);
    }
    if (json is Map) {
      // Check if it's a reference object with $ref
      if (json.containsKey(r'$ref')) {
        final ref = json[r'$ref'];
        if (ref is String) {
          return Ref<T>.reference(ref);
        }
      }
      // It's an actual object, parse it
      JsonConstructor<T> fromJson = _jsonConstructor<T>();
      return Ref<T>.value(fromJson(json as Map<String, dynamic>));
    }
    throw ArgumentError('Expected String or Map for Ref, got ${json.runtimeType}');
  }

  Map<String, dynamic> toJson() {
    if (isReference()) {
      return {r'$ref': _ref};
    }
    return (_value as dynamic).toJson();
  }
}

class RefNode<T extends TreeNode> extends TreeNode {
  final String? _ref;
  final T? _value;

  RefNode.reference(String ref) : _ref = ref, _value = null;
  RefNode.value(T value) : _ref = null, _value = value;

  bool isReference() => _ref != null;
  String? asReference() => _ref;
  T? asValue() => _value;

  Map<String, dynamic> toJson() {
    if (isReference()) {
      return {r'$ref': _ref};
    }
    return (_value as dynamic).toJson();
  }
}
