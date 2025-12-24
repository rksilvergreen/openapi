import '../openapi_graph.dart';
import '../validation/validation_utils.dart';
import '../doc_node.dart';
import '../edge.dart';
import '../referencable.dart';
import 'media_type.dart';
import '../naming/naming_utils.dart';
import 'operation.dart';
import 'components.dart';
import 'path_item.dart';
import '../map_doc_node.dart';

class RequestBodyDocNode extends DocNode with DocInternalNode, Referencable {
  RequestBodyDocNode(super.json, super.document, super.jsonPointer);

  late final String? description;
  late final bool required;
  late final MediaTypesMapDocNode content;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    _validateContent(jsonPointer);
    _validateDescription(jsonPointer);
    _validateRequired(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
  }

  void _validateContent(String jsonPointer) {
    final content = ValidationUtils.requireField(json, 'content', jsonPointer);
    ValidationUtils.requireMap(content, ValidationUtils.buildPointer([jsonPointer, 'content']));
  }

  void _validateDescription(String jsonPointer) {
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPointer([jsonPointer, 'description']));
    }
  }

  void _validateRequired(String jsonPointer) {
    if (json.containsKey('required')) {
      ValidationUtils.requireBool(json['required'], ValidationUtils.buildPointer([jsonPointer, 'required']));
    }
  }

  void _validateNoUnknownFields(String jsonPointer) {
    ValidationUtils.validateNoUnknownFields(
      json,
      {'description', 'content', 'required'},
      jsonPointer,
      'Request Body Object',
    );
  }

  @override
  void createChildNodes() {
    createNode<MediaTypesMapDocNode>(jsonKey: 'content', required: true);
  }

  @override
  void createContent() {
    description = json['description'];
    required = json['required'];
    content = $to.to<MediaTypesMapDocNode>('content')!;
    extensions = extractExtensions(json);
  }

  @override
  String get $name {
    // Check if we already computed a name for this request body
    final cached = OpenApiGraph.i.nameRegistry.getCachedRequestBodyName($id.absolutePointer);
    if (cached != null) return cached;

    // Compute the base name using the naming algorithm
    String baseName = _computeBaseName();

    // Sanitize and register the name (handles collisions)
    final sanitized = NamingUtils.toValidDartIdentifier(baseName);
    return OpenApiGraph.i.nameRegistry.registerRequestBodyName($id.absolutePointer, sanitized);
  }

  String _computeBaseName() {
    // Step 1: Derive from the owning operation
    final operationBased = _deriveFromOperation();
    if (operationBased != null) return operationBased;

    // Step 2: If it's a component, use the component key
    final componentBased = _deriveFromComponent();
    if (componentBased != null) return componentBased;

    // Step 3: Hash-based fallback
    return _generateHashFallback();
  }

  String? _deriveFromOperation() {
    // Check if this request body is attached to an operation
    // Path: requestBody ← operation
    final operation = trueParent<OperationDocNode>('requestBody');
    if (operation != null) {
      return '${operation.$name}Request';
    }
    return null;
  }

  String? _deriveFromComponent() {
    // Check if this is a component request body
    // Path: requestBody ← requestBodiesMap ← components
    final edge = trueParentEdge<RequestBodiesMapDocNode>();
    if (edge != null) {
      final requestBodiesMapDocNode = edge.from as RequestBodiesMapDocNode;
      // Check if parent is components
      if (requestBodiesMapDocNode.trueParentEdge<ComponentsDocNode>('requestBodies') != null) {
        final componentKey = edge.via; // The map key
        return NamingUtils.toPascalCase(componentKey);
      }
    }
    return null;
  }

  String _generateHashFallback() {
    // Create a deterministic hash from the identity
    String identity;

    // Check if it's a component
    final edge = trueParentEdge<RequestBodiesMapDocNode>();
    if (edge != null) {
      final componentKey = edge.via;
      identity = '${$id.document}#/components/requestBodies/$componentKey';
    } else {
      // It's inline - use document URI, path, method, and "/requestBody"
      final operation = trueParent<OperationDocNode>('requestBody');
      if (operation != null) {
        // Get path and method from the operation
        final pathAndMethod = _getPathAndMethodFromOperation(operation);
        if (pathAndMethod != null) {
          identity = '${$id.document}|${pathAndMethod['path']}|${pathAndMethod['method']}|/requestBody';
        } else {
          identity = $id.absolutePointer;
        }
      } else {
        identity = $id.absolutePointer;
      }
    }

    final codeUnits = identity.codeUnits;
    final hash = codeUnits.fold<int>(0, (prev, code) => (prev * 31 + code) & 0xFFFFFFFF);
    final shortHash = hash.toRadixString(16).padLeft(8, '0').substring(0, 6);
    return 'Request_$shortHash';
  }

  Map<String, String>? _getPathAndMethodFromOperation(OperationDocNode operation) {
    // Operation is connected to PathItem via HTTP method edge
    for (final edge in operation.$from.where((e) => e.from is PathItemDocNode)) {
      final pathItemNode = edge.from as PathItemDocNode;
      final method = edge.via; // get_, post, put, etc.

      // Get the path from PathsMap
      for (final pathEdge in pathItemNode.$from.where((e) => e.from is PathsMapDocNode)) {
        final path = pathEdge.via; // The map key is the path
        return {'path': path, 'method': method};
      }
    }
    return null;
  }
}

class RequestBodiesMapDocNode extends MapDocNode<RequestBodyDocNode> {
  RequestBodiesMapDocNode(super.json, super.document, super.jsonPointer);
}
