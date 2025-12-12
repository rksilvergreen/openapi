import '../../openapi_graph.dart';
import 'raw_schema.dart';
import 'typed_schema/typed_schema.dart';
import 'effective_schema/effective_schema.dart';
import '../external_documentation.dart';
import '../xml.dart';

class SchemaNode extends Node {
  SchemaNode(super.$id, super.json) {
    _validateStructure();
    _createRaw();
    _createTyped();
    _createChildNodes();
    _createEffective();
  }

  bool _isStructuralValidationPassed = false;
  bool _isRawSet = false;
  bool isTypedSet = false;
  bool isEffectiveSet = false;

  bool get isStructuralValidated => _isStructuralValidationPassed;
  bool get isRawSet => _isRawSet;
  bool get isTypedSchemaSet => isTypedSet;
  bool get isEffectiveSchemaSet => isEffectiveSet;

  late final List<SchemaNode>? allOfNodes;
  late final List<SchemaNode>? oneOfNodes;
  late final List<SchemaNode>? anyOfNodes;
  late final Map<String, SchemaNode>? propertiesNodes;
  late final SchemaNode? additionalPropertiesNode;
  late final SchemaNode? itemsNode;

  late final ExternalDocumentationNode? externalDocsNode;
  late final XMLNode? xmlNode;

  late final RawSchema raw;
  late final TypedSchema typed;
  late final EffectiveSchema effective;

  void _validateStructure() {}
  void _createChildNodes() {}
  void _createRaw() {}
  void _createTyped() {}
  void _createEffective() {}
}
