import '../openapi_graph.dart';
import '../validation/validation_utils.dart';
import '../referencable.dart';
import '../node.dart';
import '../edge.dart';
import 'header.dart';
import 'media_type.dart';
import 'link.dart';
import '../naming/naming_utils.dart';
import 'operation.dart';
import 'components.dart';
import 'path_item.dart';
import 'package:openapi_analyzer/v3_0_0/objects/response.dart';
import '../map_node.dart';

class ResponseNode extends Node with InternalNode, Referencable implements Response {
  ResponseNode(super.json, super.document, super.jsonPointer);

  late final String? description;
  late final HeadersMapNode? headers;
  late final MediaTypesMapNode? content;
  late final LinksMapNode? links;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    _validateDescription(jsonPointer);
    _validateHeaders(jsonPointer);
    _validateContent(jsonPointer);
    _validateLinks(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
  }

  void _validateDescription(String jsonPointer) {
    final description = ValidationUtils.requireField(json, 'description', jsonPointer);
    ValidationUtils.requireString(description, ValidationUtils.buildPointer([jsonPointer, 'description']));
  }

  void _validateHeaders(String jsonPointer) {
    if (json.containsKey('headers')) {
      ValidationUtils.requireMap(json['headers'], ValidationUtils.buildPointer([jsonPointer, 'headers']));
    }
  }

  void _validateContent(String jsonPointer) {
    if (json.containsKey('content')) {
      ValidationUtils.requireMap(json['content'], ValidationUtils.buildPointer([jsonPointer, 'content']));
    }
  }

  void _validateLinks(String jsonPointer) {
    if (json.containsKey('links')) {
      ValidationUtils.requireMap(json['links'], ValidationUtils.buildPointer([jsonPointer, 'links']));
    }
  }

  void _validateNoUnknownFields(String jsonPointer) {
    ValidationUtils.validateNoUnknownFields(
      json,
      {'description', 'headers', 'content', 'links'},
      jsonPointer,
      'Response Object',
    );
  }

  @override
  void createChildNodes() {
    createNode<HeadersMapNode>(jsonKey: 'headers');
    createNode<MediaTypesMapNode>(jsonKey: 'content');
    createNode<LinksMapNode>(jsonKey: 'links');
  }

  @override
  void createContent() {
    description = json['description'];
    headers = $to.to<HeadersMapNode>('headers');
    content = $to.to<MediaTypesMapNode>('content');
    links = $to.to<LinksMapNode>('links');
    extensions = extractExtensions(json);
  }

  @override
  String get $name {
    // Check if we already computed a name for this response
    final cached = OpenApiGraph.i.nameRegistry.getCachedResponseName($id.absolutePointer);
    if (cached != null) return cached;

    // Compute the base name using the naming algorithm
    String baseName = _computeBaseName();

    // Sanitize and register the name (handles collisions)
    final sanitized = NamingUtils.toValidDartIdentifier(baseName);
    return OpenApiGraph.i.nameRegistry.registerResponseName($id.absolutePointer, sanitized);
  }

  String _computeBaseName() {
    // Step 1: Derive from operation + status code
    final operationBased = _deriveFromOperation();
    if (operationBased != null) return operationBased;

    // Step 2: If it's a component, use the component key
    final componentBased = _deriveFromComponent();
    if (componentBased != null) return componentBased;

    // Step 3: Hash-based fallback
    return _generateHashFallback();
  }

  String? _deriveFromOperation() {
    // Check if this response is in an operation's responses map
    // Path: response ← responsesMap ← operation
    final edge = trueParentEdge<ResponsesMapNode>();
    if (edge != null) {
      final responsesMapNode = edge.from as ResponsesMapNode;
      final statusCode = edge.via; // The map key (e.g., "200", "201", "default")

      // Check if parent is an operation
      final operation = responsesMapNode.trueParent<OperationNode>('responses');
      if (operation != null) {
        final statusName = NamingUtils.statusCodeToName(statusCode);
        return '${operation.$name}${statusName}Response';
      }
    }
    return null;
  }

  String? _deriveFromComponent() {
    // Check if this is a component response
    // Path: response ← responsesMap ← components
    final edge = trueParentEdge<ResponsesMapNode>();
    if (edge != null) {
      final responsesMapNode = edge.from as ResponsesMapNode;
      // Check if parent is components
      if (responsesMapNode.trueParentEdge<ComponentsNode>('responses') != null) {
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
    final edge = trueParentEdge<ResponsesMapNode>();
    if (edge != null) {
      final responsesMapNode = edge.from as ResponsesMapNode;

      // Check if it's a component response
      if (responsesMapNode.trueParentEdge<ComponentsNode>('responses') != null) {
        final componentKey = edge.via;
        identity = '${$id.document}#/components/responses/$componentKey';
      } else {
        // It's inline - use document URI, path, method, "responses", statusKey
        final statusCode = edge.via;
        final operation = responsesMapNode.trueParent<OperationNode>('responses');
        if (operation != null) {
          // Get path and method from the operation
          final pathAndMethod = _getPathAndMethodFromOperation(operation);
          if (pathAndMethod != null) {
            identity = '${$id.document}|${pathAndMethod['path']}|${pathAndMethod['method']}|responses|$statusCode';
          } else {
            identity = $id.absolutePointer;
          }
        } else {
          identity = $id.absolutePointer;
        }
      }
    } else {
      identity = $id.absolutePointer;
    }

    final codeUnits = identity.codeUnits;
    final hash = codeUnits.fold<int>(0, (prev, code) => (prev * 31 + code) & 0xFFFFFFFF);
    final shortHash = hash.toRadixString(16).padLeft(8, '0').substring(0, 6);
    return 'Response_$shortHash';
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

class ResponsesMapNode extends MapNode<ResponseNode, Response> implements ResponsesMap {
  ResponsesMapNode(super.json, super.document, super.jsonPointer);
}
