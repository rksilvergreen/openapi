import '../openapi_graph.dart';
import '../validation/validation_utils.dart';
import '../referencable.dart';
import '../doc_node.dart';
import '../edge.dart';
import 'header.dart';
import 'media_type.dart';
import 'link.dart';
import '../naming/naming_utils.dart';
import 'operation.dart';
import 'components.dart';
import 'path_item.dart';
import '../map_doc_node.dart';

class ResponseDocNode extends DocNode with DocInternalNode, Referencable {
  ResponseDocNode(super.json, super.document, super.jsonPointer);

  late final String? description;
  late final HeadersMapDocNode? headers;
  late final MediaTypesMapDocNode? content;
  late final LinksMapDocNode? links;
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
    createNode<HeadersMapDocNode>(jsonKey: 'headers');
    createNode<MediaTypesMapDocNode>(jsonKey: 'content');
    createNode<LinksMapDocNode>(jsonKey: 'links');
  }

  @override
  void createContent() {
    description = json['description'];
    headers = $to.to<HeadersMapDocNode>('headers');
    content = $to.to<MediaTypesMapDocNode>('content');
    links = $to.to<LinksMapDocNode>('links');
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
    final edge = trueParentEdge<ResponsesMapDocNode>();
    if (edge != null) {
      final responsesMapDocNode = edge.from as ResponsesMapDocNode;
      final statusCode = edge.via; // The map key (e.g., "200", "201", "default")

      // Check if parent is an operation
      final operation = responsesMapDocNode.trueParent<OperationDocNode>('responses');
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
    final edge = trueParentEdge<ResponsesMapDocNode>();
    if (edge != null) {
      final responsesMapDocNode = edge.from as ResponsesMapDocNode;
      // Check if parent is components
      if (responsesMapDocNode.trueParentEdge<ComponentsDocNode>('responses') != null) {
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
    final edge = trueParentEdge<ResponsesMapDocNode>();
    if (edge != null) {
      final responsesMapDocNode = edge.from as ResponsesMapDocNode;

      // Check if it's a component response
      if (responsesMapDocNode.trueParentEdge<ComponentsDocNode>('responses') != null) {
        final componentKey = edge.via;
        identity = '${$id.document}#/components/responses/$componentKey';
      } else {
        // It's inline - use document URI, path, method, "responses", statusKey
        final statusCode = edge.via;
        final operation = responsesMapDocNode.trueParent<OperationDocNode>('responses');
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

class ResponsesMapDocNode extends MapDocNode<ResponseDocNode> {
  ResponsesMapDocNode(super.json, super.document, super.jsonPointer);
}
