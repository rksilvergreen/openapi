import '../../referencable.dart';
import 'raw_schema/raw_schema.dart';
import 'typed_schema/typed_schema.dart';
import 'effective_schema/effective_schema.dart';

class Schema implements Referencable {
  final ReferencableId $id;
  final List<String> _allOf;
  final List<String> _oneOf;
  final List<String> _anyOf;
  final List<String> _additionalProperties;
  final List<String> properties;
  final List<String> patternProperties;
  final List<String> items;

  Schema(this.$id, this._allOf, this._oneOf, this._anyOf);

  late final RawSchema raw;
  late final TypedSchema typed;
  late final EffectiveSchema effective;

  List<Schema> get allOf => _allOf.map((id) => referenceGraph[id] as Schema).toList();
  List<Schema> get oneOf => _oneOf.map((id) => referenceGraph[id] as Schema).toList();
  List<Schema> get anyOf => _anyOf.map((id) => referenceGraph[id] as Schema).toList();

  bool _isStructuralValidationPassed = false;
  bool _isRawSet = false;
  bool isTypedSet = false;
  bool isEffectiveSet = false;

  bool get isStructuralValidated => _isStructuralValidationPassed;
  bool get isRawSet => _isRawSet;
  bool get isTypedSchemaSet => isTypedSet;
  bool get isEffectiveSchemaSet => isEffectiveSet;

  void setStructuralValidated() {
    if (_isStructuralValidationPassed) {
      throw Exception('Structural validation must be set only once');
    }
    _isStructuralValidationPassed = true;
  }

  void setRawSchema(RawSchema raw) {
    if (!_isStructuralValidationPassed) {
      throw Exception('Structural validation must be set before raw schema');
    }
    if (_isRawSet) {
      throw Exception('Raw schema must be set only once');
    }
    this.raw = raw;
    _isRawSet = true;
  }

  void setTypedSchema(TypedSchema typed) {
    if (!_isRawSet) {
      throw Exception('Raw schema must be set before typed schema');
    }
    if (isTypedSet) {
      throw Exception('Typed schema must be set only once');
    }
    this.typed = typed;
    isTypedSet = true;
  }

  void setEffectiveSchema(EffectiveSchema effective) {
    if (!isTypedSet) {
      throw Exception('Typed schema must be set before effective schema');
    }
    if (isEffectiveSet) {
      throw Exception('Effective schema must be set only once');
    }
    this.effective = effective;
    isEffectiveSet = true;
  }
}
