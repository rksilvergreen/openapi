import '../openapi_graph.dart';
import '../validation/validation_utils.dart';
import '../doc_node.dart';
import '../edge.dart';
import 'external_documentation.dart';
import 'request_body.dart';
import 'security_requirement.dart';
import 'server.dart';
import 'response.dart';
import 'callback.dart';
import 'parameter.dart';
import '../naming/naming_utils.dart';
import 'path_item.dart';

class OperationDocNode extends DocNode with DocInternalNode {
  OperationDocNode(super.json, super.document, super.jsonPointer);

  late final List<String>? tags;
  late final String? summary;
  late final String? description;
  late final String? operationId;
  late final ExternalDocumentationDocNode? externalDocs;
  late final ParametersListDocNode? parameters;
  late final RequestBodyDocNode? requestBody;
  late final ResponsesMapDocNode responses;
  late final CallbacksMapDocNode? callbacks;
  late final SecurityRequirementsListDocNode security;
  late final ServerListDocNode servers;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;

    _validateResponses(jsonPointer);
    _validateTags(jsonPointer);
    _validateSummary(jsonPointer);
    _validateDescription(jsonPointer);
    _validateExternalDocs(jsonPointer);
    _validateOperationId(jsonPointer);
    _validateParameters(jsonPointer);
    _validateRequestBody(jsonPointer);
    _validateCallbacks(jsonPointer);
    _validateDeprecated(jsonPointer);
    _validateSecurity(jsonPointer);
    _validateServers(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
  }

  void _validateResponses(String jsonPointer) {
    final responses = ValidationUtils.requireField(json, 'responses', jsonPointer);
    ValidationUtils.requireMap(responses, ValidationUtils.buildPointer([jsonPointer, 'responses']));
  }

  void _validateTags(String jsonPointer) {
    if (json.containsKey('tags')) {
      final tags = ValidationUtils.requireList(json['tags'], ValidationUtils.buildPointer([jsonPointer, 'tags']));
      for (var i = 0; i < tags.length; i++) {
        ValidationUtils.requireString(tags[i], ValidationUtils.buildPointer([jsonPointer, 'tags', '[$i]']));
      }
    }
  }

  void _validateSummary(String jsonPointer) {
    if (json.containsKey('summary')) {
      ValidationUtils.requireString(json['summary'], ValidationUtils.buildPointer([jsonPointer, 'summary']));
    }
  }

  void _validateDescription(String jsonPointer) {
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPointer([jsonPointer, 'description']));
    }
  }

  void _validateExternalDocs(String jsonPointer) {
    if (json.containsKey('externalDocs')) {
      ValidationUtils.requireMap(json['externalDocs'], ValidationUtils.buildPointer([jsonPointer, 'externalDocs']));
    }
  }

  void _validateOperationId(String jsonPointer) {
    if (json.containsKey('operationId')) {
      ValidationUtils.requireString(json['operationId'], ValidationUtils.buildPointer([jsonPointer, 'operationId']));
      // Note: uniqueness validation across all operations will be done in semantic validation
    }
  }

  void _validateParameters(String jsonPointer) {
    if (json.containsKey('parameters')) {
      ValidationUtils.requireList(json['parameters'], ValidationUtils.buildPointer([jsonPointer, 'parameters']));
    }
  }

  void _validateRequestBody(String jsonPointer) {
    if (json.containsKey('requestBody')) {
      ValidationUtils.requireMap(json['requestBody'], ValidationUtils.buildPointer([jsonPointer, 'requestBody']));
    }
  }

  void _validateCallbacks(String jsonPointer) {
    if (json.containsKey('callbacks')) {
      ValidationUtils.requireMap(json['callbacks'], ValidationUtils.buildPointer([jsonPointer, 'callbacks']));
    }
  }

  void _validateDeprecated(String jsonPointer) {
    if (json.containsKey('deprecated')) {
      ValidationUtils.requireBool(json['deprecated'], ValidationUtils.buildPointer([jsonPointer, 'deprecated']));
    }
  }

  void _validateSecurity(String jsonPointer) {
    if (json.containsKey('security')) {
      ValidationUtils.requireList(json['security'], ValidationUtils.buildPointer([jsonPointer, 'security']));
    }
  }

  void _validateServers(String jsonPointer) {
    if (json.containsKey('servers')) {
      ValidationUtils.requireList(json['servers'], ValidationUtils.buildPointer([jsonPointer, 'servers']));
    }
  }

  void _validateNoUnknownFields(String jsonPointer) {
    ValidationUtils.validateNoUnknownFields(
      json,
      {
        'tags',
        'summary',
        'description',
        'externalDocs',
        'operationId',
        'parameters',
        'requestBody',
        'responses',
        'callbacks',
        'deprecated',
        'security',
        'servers',
      },
      jsonPointer,
      'Operation Object',
    );
  }

  @override
  void createChildNodes() {
    createNode<ExternalDocumentationDocNode>(jsonKey: 'externalDocs');
    createNode<ParametersListDocNode>(jsonKey: 'parameters');
    createNode<RequestBodyDocNode>(jsonKey: 'requestBody');
    createNode<ResponsesMapDocNode>(jsonKey: 'responses', required: true);
    createNode<CallbacksMapDocNode>(jsonKey: 'callbacks');
    createNode<SecurityRequirementDocNode>(jsonKey: 'security');
    createNode<ServerDocNode>(jsonKey: 'servers');
  }

  @override
  void createContent() {
    tags = json['tags'] != null ? List<String>.from(json['tags']) : null;
    summary = json['summary'];
    description = json['description'];
    operationId = json['operationId'];
    externalDocs = $to.to<ExternalDocumentationDocNode>('externalDocs');
    parameters = $to.to<ParametersListDocNode>('parameters');
    requestBody = $to.to<RequestBodyDocNode>('requestBody');
    responses = $to.to<ResponsesMapDocNode>('responses')!;
    callbacks = $to.to<CallbacksMapDocNode>('callbacks');
    security = $to.to<SecurityRequirementsListDocNode>('security')!;
    servers = $to.to<ServerListDocNode>('servers')!;
    extensions = extractExtensions(json);
  }

  @override
  String get $name {
    // Check if we already computed a name for this operation
    final cached = OpenApiGraph.i.nameRegistry.getCachedOperationName($id.absolutePointer);
    if (cached != null) return cached;

    // Compute the base name using the naming algorithm
    String baseName = _computeBaseName();

    // Sanitize and register the name (handles collisions)
    final sanitized = NamingUtils.toValidDartIdentifier(baseName);
    return OpenApiGraph.i.nameRegistry.registerOperationName($id.absolutePointer, sanitized);
  }

  String _computeBaseName() {
    // Step 1: Derive from operationId if present
    final operationIdName = _deriveFromOperationId();
    if (operationIdName != null) return operationIdName;

    // Step 2: Derive from HTTP method + path template
    final pathAndMethodName = _deriveFromPathAndMethod();
    if (pathAndMethodName != null) return pathAndMethodName;

    // Step 3: Hash-based fallback
    return _generateHashFallback();
  }

  String? _deriveFromOperationId() {
    if (operationId != null && operationId!.isNotEmpty) {
      final sanitized = NamingUtils.toValidDartIdentifier(operationId!);
      if (sanitized.isNotEmpty && sanitized != 'unnamed') {
        return NamingUtils.toPascalCase(operationId!);
      }
    }
    return null;
  }

  String? _deriveFromPathAndMethod() {
    // Operation is connected to PathItem
    for (final edge in $from.where((e) => e.from is PathItemDocNode)) {
      final pathItemNode = edge.from as PathItemDocNode;
      final method = edge.via; // get_, post, put, etc.

      // Get the path from the PathsMap
      for (final pathEdge in pathItemNode.$from.where((e) => e.from is PathsMapDocNode)) {
        final path = pathEdge.via; // The map key is the path
        // Clean up method name (remove trailing underscore from get_)
        final cleanMethod = method.endsWith('_') ? method.substring(0, method.length - 1) : method;
        return NamingUtils.operationNameFromPath(path, cleanMethod);
      }
    }
    return null;
  }

  String _generateHashFallback() {
    // Create a deterministic hash from the absolute pointer
    final codeUnits = $id.absolutePointer.codeUnits;
    final hash = codeUnits.fold<int>(0, (prev, code) => (prev * 31 + code) & 0xFFFFFFFF);
    final shortHash = hash.toRadixString(16).padLeft(8, '0').substring(0, 6);

    // Include method if we can find it
    for (final edge in $from.where((e) => e.from is PathItemDocNode)) {
      final method = edge.via; // get_, post, put, etc.
      // Clean up method name (remove trailing underscore from get_)
      final cleanMethod = method.endsWith('_') ? method.substring(0, method.length - 1) : method;
      return 'op_${cleanMethod}_$shortHash';
    }

    return 'op_$shortHash';
  }
}
