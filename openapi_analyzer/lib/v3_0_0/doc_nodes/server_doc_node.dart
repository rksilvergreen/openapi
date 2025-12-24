import '../openapi_graph.dart';
import '../validation/validation_utils.dart';
import '../doc_node.dart';
import '../edge.dart';
import 'server_variable_doc_node.dart';
import '../naming/naming_utils.dart';
import 'openapi_document_doc_node.dart';
import 'path_item_doc_node.dart';
import 'operation_doc_node.dart';
import '../list_doc_node.dart';

class ServerDocNode extends DocNode with DocInternalNode {
  ServerDocNode(super.json);

  late final String url;
  late final String? description;
  late final ServerVariablesMapDocNode? variables;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id!.jsonPointer;

    _validateUrl(jsonPointer);
    _validateDescription(jsonPointer);
    _validateVariables(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
  }

  void _validateUrl(String jsonPointer) {
    final url = ValidationUtils.requireField(json, 'url', jsonPointer);
    ValidationUtils.requireNonEmptyString(url, ValidationUtils.buildPointer([jsonPointer, 'url']));
  }

  void _validateDescription(String jsonPointer) {
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPointer([jsonPointer, 'description']));
    }
  }

  void _validateVariables(String jsonPointer) {
    if (json.containsKey('variables')) {
      ValidationUtils.requireMap(json['variables'], ValidationUtils.buildPointer([jsonPointer, 'variables']));
    }
  }

  void _validateNoUnknownFields(String jsonPointer) {
    ValidationUtils.validateNoUnknownFields(json, {'url', 'description', 'variables'}, jsonPointer, 'Server Object');
  }

  @override
  void createChildNodes() {
    createNode<ServerVariablesMapDocNode>(jsonKey: 'variables');
  }

  @override
  void createContent() {
    url = json['url'];
    description = json['description'];
    variables = $to.to<ServerVariablesMapDocNode>('variables');
    extensions = extractExtensions(json);
  }

  @override
  String get $name {
    // Check if we already computed a name for this server
    final cached = OpenApiGraph.i.nameRegistry.getCachedServerName($id!.absolutePointer);
    if (cached != null) return cached;

    // Compute the base name using the naming algorithm
    String baseName = _computeBaseName();

    // Sanitize and register the name (handles collisions)
    final sanitized = NamingUtils.toValidDartIdentifier(baseName);
    return OpenApiGraph.i.nameRegistry.registerServerName($id!.absolutePointer, sanitized);
  }

  String _computeBaseName() {
    // Step 1: Derive from URL
    final urlBased = _deriveFromUrl();
    if (urlBased != null) return urlBased;

    // Step 2: Derive from context + index
    final contextBased = _deriveFromContext();
    if (contextBased != null) return contextBased;

    // Step 3: Hash-based fallback
    return _generateHashFallback();
  }

  String? _deriveFromUrl() {
    if (url.isEmpty) return null;

    try {
      final uri = Uri.parse(url);

      // Prefer hostname if available
      if (uri.host.isNotEmpty) {
        // Extract hostname and convert to PascalCase
        // e.g., "api.example.com" -> "ApiExampleCom"
        final hostParts = uri.host.split('.');
        final hostToken = hostParts.map((part) => NamingUtils.toPascalCase(part)).join();

        // Optionally include environment hint if obvious
        String? envHint;
        final lowerHost = uri.host.toLowerCase();
        if (lowerHost.contains('dev') || lowerHost.contains('development')) {
          envHint = 'Dev';
        } else if (lowerHost.contains('staging') || lowerHost.contains('stage')) {
          envHint = 'Staging';
        } else if (lowerHost.contains('prod') || lowerHost.contains('production')) {
          envHint = 'Prod';
        } else if (lowerHost.contains('sandbox')) {
          envHint = 'Sandbox';
        }

        if (envHint != null) {
          return '${hostToken}${envHint}Server';
        }
        return '${hostToken}Server';
      }

      // If no hostname (relative URL), use the first path segment
      if (uri.path.isNotEmpty) {
        final pathSegments = uri.path.split('/').where((s) => s.isNotEmpty).toList();
        if (pathSegments.isNotEmpty) {
          final firstSegment = pathSegments.first;
          return '${NamingUtils.toPascalCase(firstSegment)}Server';
        }
      }
    } catch (e) {
      // If URL parsing fails, fall through to next step
    }

    return null;
  }

  String? _deriveFromContext() {
    // Find the server list and get the index
    final serverListDocNode = trueParent<ServerListDocNode>('servers');
    if (serverListDocNode == null) return null;

    // Get the index of this server in the list
    final servers = serverListDocNode.toList();
    int? index;
    for (int i = 0; i < servers.length; i++) {
      if (servers[i] == this) {
        index = i;
        break;
      }
    }
    if (index == null) return null;

    // Determine the owner context
    String? ownerName;

    // Check if it's from OpenAPI root
    final openApiDoc = serverListDocNode.trueParent<OpenApiDocumentDocNode>('servers');
    if (openApiDoc != null) {
      ownerName = openApiDoc.$name;
    } else {
      // Check if it's from a PathItem
      final pathItem = serverListDocNode.trueParent<PathItemDocNode>('servers');
      if (pathItem != null) {
        // Get path from PathItem
        final path = _getPathFromPathItem(pathItem);
        if (path != null) {
          ownerName = NamingUtils.toPascalCase(Uri.decodeComponent(path));
        } else {
          ownerName = 'PathItem';
        }
      } else {
        // Check if it's from an Operation
        final operation = serverListDocNode.trueParent<OperationDocNode>('servers');
        if (operation != null) {
          ownerName = operation.$name;
        }
      }
    }

    if (ownerName == null) return null;

    // Format: <OwnerName>Server<Index+1>
    return '${ownerName}Server${index + 1}';
  }

  String? _getPathFromPathItem(PathItemDocNode pathItemNode) {
    // Get the path from the edge connecting PathItem to PathsMap
    for (final edge in pathItemNode.$from.where((e) => e.from is PathsMapDocNode)) {
      return edge.via; // The map key is the path
    }
    return null;
  }

  String _generateHashFallback() {
    // Create a deterministic hash from the identity
    // Include document URI, jsonPointer, and optionally the resolved URL
    String identity = '${$id!.document}|${$id!.jsonPointer}';

    // Include URL if available
    if (url.isNotEmpty) {
      identity += '|$url';
    }

    final codeUnits = identity.codeUnits;
    final hash = codeUnits.fold<int>(0, (prev, code) => (prev * 31 + code) & 0xFFFFFFFF);
    final shortHash = hash.toRadixString(16).padLeft(8, '0').substring(0, 6);
    return 'Server_$shortHash';
  }
}

class ServerListDocNode extends ListDocNode<ServerDocNode> {
  ServerListDocNode(super.json);
}
