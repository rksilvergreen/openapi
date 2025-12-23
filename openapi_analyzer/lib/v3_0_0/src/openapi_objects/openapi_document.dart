import '../openapi_graph.dart';
import '../validation/validation_utils.dart';
import '../node.dart';
import '../edge.dart';
import 'info.dart';
import 'server.dart';
import 'path_item.dart';
import 'components.dart';
import 'security_requirement.dart';
import 'tag.dart';
import 'external_documentation.dart';
import '../naming/naming_utils.dart';
import 'package:openapi_analyzer/v3_0_0/objects/openapi_document.dart';

class OpenApiDocumentNode extends Node with InternalNode implements OpenApiDocument {
  OpenApiDocumentNode(super.json, super.document, super.jsonPointer);

  late final String openapi;
  late final InfoNode info;
  late final ServerListNode? servers;
  late final PathsMapNode paths;
  late final ComponentsNode? components;
  late final SecurityRequirementsListNode? security;
  late final TagsListNode? tags;
  late final ExternalDocumentationNode? externalDocs;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    _validateOpenapi(jsonPointer);
    _validateInfo(jsonPointer);
    _validatePaths(jsonPointer);
    _validateServers(jsonPointer);
    _validateComponents(jsonPointer);
    _validateSecurity(jsonPointer);
    _validateTags(jsonPointer);
    _validateExternalDocs(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
  }

  void _validateOpenapi(String jsonPointer) {
    final openapi = ValidationUtils.requireField(json, 'openapi', jsonPointer);
    ValidationUtils.requireString(openapi, ValidationUtils.buildPointer([jsonPointer, 'openapi']));
    ValidationUtils.validatePattern(
      openapi as String,
      r'^3\.0\.\d+$',
      ValidationUtils.buildPointer([jsonPointer, 'openapi']),
      description: 'OpenAPI version must match pattern 3.0.x',
    );
  }

  void _validateInfo(String jsonPointer) {
    final info = ValidationUtils.requireField(json, 'info', jsonPointer);
    ValidationUtils.requireMap(info, ValidationUtils.buildPointer([jsonPointer, 'info']));
  }

  void _validatePaths(String jsonPointer) {
    final paths = ValidationUtils.requireField(json, 'paths', jsonPointer);
    ValidationUtils.requireMap(paths, ValidationUtils.buildPointer([jsonPointer, 'paths']));
  }

  void _validateServers(String jsonPointer) {
    if (json.containsKey('servers')) {
      ValidationUtils.requireList(json['servers'], ValidationUtils.buildPointer([jsonPointer, 'servers']));
    }
  }

  void _validateComponents(String jsonPointer) {
    if (json.containsKey('components')) {
      ValidationUtils.requireMap(json['components'], ValidationUtils.buildPointer([jsonPointer, 'components']));
    }
  }

  void _validateSecurity(String jsonPointer) {
    if (json.containsKey('security')) {
      ValidationUtils.requireList(json['security'], ValidationUtils.buildPointer([jsonPointer, 'security']));
    }
  }

  void _validateTags(String jsonPointer) {
    if (json.containsKey('tags')) {
      ValidationUtils.requireList(json['tags'], ValidationUtils.buildPointer([jsonPointer, 'tags']));
    }
  }

  void _validateExternalDocs(String jsonPointer) {
    if (json.containsKey('externalDocs')) {
      ValidationUtils.requireMap(json['externalDocs'], ValidationUtils.buildPointer([jsonPointer, 'externalDocs']));
    }
  }

  void _validateNoUnknownFields(String jsonPointer) {
    ValidationUtils.validateNoUnknownFields(
      json,
      {'openapi', 'info', 'servers', 'paths', 'components', 'security', 'tags', 'externalDocs'},
      jsonPointer,
      'OpenAPI Object',
    );
  }

  @override
  void createChildNodes() {
    createNode<InfoNode>(jsonKey: 'info', required: true);
    createNode<ServerNode>(jsonKey: 'servers');
    createNode<PathsMapNode>(jsonKey: 'paths', required: true);
    createNode<ComponentsNode>(jsonKey: 'components');
    createNode<SecurityRequirementNode>(jsonKey: 'security');
    createNode<TagNode>(jsonKey: 'tags');
    createNode<ExternalDocumentationNode>(jsonKey: 'externalDocs');
  }

  @override
  void createContent() {
    openapi = json['openapi'];
    info = $to.to<InfoNode>('info')!;
    servers = $to.to<ServerListNode>('servers');
    paths = $to.to<PathsMapNode>('paths')!;
    components = $to.to<ComponentsNode>('components');
    security = $to.to<SecurityRequirementsListNode>('security');
    tags = $to.to<TagsListNode>('tags');
    externalDocs = $to.to<ExternalDocumentationNode>('externalDocs');
    extensions = extractExtensions(json);
  }

  @override
  String get $name {
    // Check if we already computed a name for this document
    final cached = OpenApiGraph.i.nameRegistry.getCachedDocumentName($id.absolutePointer);
    if (cached != null) return cached;

    // Compute the base name using the naming algorithm
    String baseName = _computeBaseName();

    // Sanitize and register the name (handles collisions)
    final sanitized = NamingUtils.toValidDartIdentifier(baseName);
    return OpenApiGraph.i.nameRegistry.registerDocumentName($id.absolutePointer, sanitized);
  }

  String _computeBaseName() {
    // Step 1: Use info.title if present
    final titleName = _deriveFromTitle();
    if (titleName != null) return titleName;

    // Step 2: Use document file/URL stem
    final fileStemName = _deriveFromDocumentStem();
    if (fileStemName != null) return fileStemName;

    // Step 3: Hash-based fallback
    return _generateHashFallback();
  }

  String? _deriveFromTitle() {
    if (info.title.isNotEmpty) {
      return NamingUtils.toPascalCase(info.title);
    }
    return null;
  }

  String? _deriveFromDocumentStem() {
    // Get the document URI from $id.document
    final documentUri = $id.document;
    if (documentUri.isEmpty) return null;

    // Try to extract the file name or URL path stem
    try {
      // Handle file:// URIs
      if (documentUri.startsWith('file://')) {
        final path = Uri.parse(documentUri).path;
        final fileName = path.split('/').last;
        final stem = fileName.contains('.') ? fileName.substring(0, fileName.lastIndexOf('.')) : fileName;
        if (stem.isNotEmpty) {
          return NamingUtils.toPascalCase(stem);
        }
      }
      // Handle http/https URIs
      else if (documentUri.startsWith('http://') || documentUri.startsWith('https://')) {
        final uri = Uri.parse(documentUri);
        final pathSegments = uri.pathSegments;
        if (pathSegments.isNotEmpty) {
          final lastSegment = pathSegments.last;
          final stem = lastSegment.contains('.') ? lastSegment.substring(0, lastSegment.lastIndexOf('.')) : lastSegment;
          if (stem.isNotEmpty) {
            return NamingUtils.toPascalCase(stem);
          }
        }
      }
      // Handle plain file paths
      else {
        // Assume it's a file path
        final fileName = documentUri.split(RegExp(r'[/\\]')).last;
        final stem = fileName.contains('.') ? fileName.substring(0, fileName.lastIndexOf('.')) : fileName;
        if (stem.isNotEmpty) {
          return NamingUtils.toPascalCase(stem);
        }
      }
    } catch (e) {
      // If parsing fails, fall through to next step
    }

    return null;
  }

  String _generateHashFallback() {
    // Create a deterministic hash from the document URI
    final identity = $id.document + openapi; // Include version for uniqueness
    final codeUnits = identity.codeUnits;
    final hash = codeUnits.fold<int>(0, (prev, code) => (prev * 31 + code) & 0xFFFFFFFF);
    final shortHash = hash.toRadixString(16).padLeft(8, '0').substring(0, 6);
    return 'OpenApi_$shortHash';
  }
}
