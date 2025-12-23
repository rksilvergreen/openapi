import '../openapi_graph.dart';
import '../validation/validation_utils.dart';
import '../node.dart';
import '../edge.dart';
import '../referencable.dart';
import 'media_types_map.dart';
import '../naming/naming_utils.dart';
import 'operation.dart';
import 'request_bodies_map.dart';
import 'components.dart';
import 'path_item.dart';
import 'paths_map.dart';

abstract class RequestBody {
  String? get description;
  bool get required;
  MediaTypesMap get content;
  Map<String, dynamic>? get extensions;
  String get $name;
}

class RequestBodyNode extends Node with InternalNode, Referencable implements RequestBody {
  RequestBodyNode(super.json, super.document, super.jsonPointer);

  late final String? description;
  late final bool required;
  late final MediaTypesMapNode content;
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
    createNode<MediaTypesMapNode>(jsonKey: 'content', required: true);
  }

  @override
  void createContent() {
    description = json['description'];
    required = json['required'];
    content = $to.to<MediaTypesMapNode>('content')!;
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
    final operation = trueParent<OperationNode>('requestBody');
    if (operation != null) {
      return '${operation.$name}Request';
    }
    return null;
  }

  String? _deriveFromComponent() {
    // Check if this is a component request body
    // Path: requestBody ← requestBodiesMap ← components
    final edge = trueParentEdge<RequestBodiesMapNode>();
    if (edge != null) {
      final requestBodiesMapNode = edge.from as RequestBodiesMapNode;
      // Check if parent is components
      if (requestBodiesMapNode.trueParentEdge<ComponentsNode>('requestBodies') != null) {
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
    final edge = trueParentEdge<RequestBodiesMapNode>();
    if (edge != null) {
      final componentKey = edge.via;
      identity = '${$id.document}#/components/requestBodies/$componentKey';
    } else {
      // It's inline - use document URI, path, method, and "/requestBody"
      final operation = trueParent<OperationNode>('requestBody');
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

  Map<String, String>? _getPathAndMethodFromOperation(OperationNode operation) {
    // Operation is connected to PathItem via HTTP method edge
    for (final edge in operation.$from.where((e) => e.from is PathItemNode)) {
      final pathItemNode = edge.from as PathItemNode;
      final method = edge.via; // get_, post, put, etc.

      // Get the path from PathsMap
      for (final pathEdge in pathItemNode.$from.where((e) => e.from is PathsMapNode)) {
        final path = pathEdge.via; // The map key is the path
        return {'path': path, 'method': method};
      }
    }
    return null;
  }
}
