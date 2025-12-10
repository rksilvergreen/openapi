import '../../openapi_graph.dart';
import 'raw_schema/raw_schema.dart';
import 'typed_schema/typed_schema.dart';
import 'effective_schema/effective_schema.dart';

class SchemaNode implements Node {
  final NodeId $id;

  SchemaNode(this.$id);

  late final RawSchema raw;
  late final TypedSchema typed;
  late final EffectiveSchema effective;

  List<SchemaNode>? _$allOf;
  List<SchemaNode>? _$oneOf;
  List<SchemaNode>? _$anyOf;
  List<SchemaNode>? _$properties;
  List<SchemaNode>? _$additionalProperties;
  List<SchemaNode>? _$items;

  List<SchemaNode> get allOf => _$allOf ??= OpenApiRegistry.i.getSchemaNodeApplicatorChildren<AllOfEdge>(this);
  List<SchemaNode> get oneOf => _$oneOf ??= OpenApiRegistry.i.getSchemaNodeApplicatorChildren<OneOfEdge>(this);
  List<SchemaNode> get anyOf => _$anyOf ??= OpenApiRegistry.i.getSchemaNodeApplicatorChildren<AnyOfEdge>(this);

  List<SchemaNode> get properties => _$properties ??= OpenApiRegistry.i.getSchemaNodeStructuralChildren<PropertiesEdge>(this);
  List<SchemaNode> get additionalProperties =>
      _$additionalProperties ??= OpenApiRegistry.i.getSchemaNodeStructuralChildren<AdditionalPropertiesEdge>(this);
  List<SchemaNode> get items => _$items ??= OpenApiRegistry.i.getSchemaNodeStructuralChildren<ItemsEdge>(this);

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
