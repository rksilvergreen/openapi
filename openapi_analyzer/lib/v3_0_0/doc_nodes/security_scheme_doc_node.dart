import '../openapi_graph.dart';
import '../validation/validation_utils.dart';
import '../referencable.dart';
import '../doc_node.dart';
import '../edge.dart';
import 'enums_doc_node.dart';
import 'oauth_flows_doc_node.dart';
import '../naming/naming_utils.dart';
import 'components_doc_node.dart';
import '../map_doc_node.dart';

class SecuritySchemeDocNode extends DocNode with DocInternalNode, Referencable {
  SecuritySchemeDocNode(super.json);

  late final SecuritySchemeType type;
  late final String? description;
  late final String? name;
  late final SecuritySchemeIn? in_;
  late final String? scheme;
  late final String? bearerFormat;
  late final OAuthFlowsDocNode? flows;
  late final String? openIdConnectUrl;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id!.jsonPointer;

    _validateType(jsonPointer);
    _validateTypeSpecificFields(jsonPointer);
    _validateDescription(jsonPointer);
    _validateNoUnknownFields(jsonPointer);
  }

  void _validateType(String jsonPointer) {
    final type = ValidationUtils.requireField(json, 'type', jsonPointer);
    ValidationUtils.requireString(type, ValidationUtils.buildPointer([jsonPointer, 'type']));
    ValidationUtils.validateEnum(type as String, [
      'apiKey',
      'http',
      'oauth2',
      'openIdConnect',
    ], ValidationUtils.buildPointer([jsonPointer, 'type']));
  }

  void _validateTypeSpecificFields(String jsonPointer) {
    final type = json['type'] as String;
    if (type == 'apiKey') {
      _validateApiKeyFields(jsonPointer);
    } else if (type == 'http') {
      _validateHttpFields(jsonPointer);
    } else if (type == 'oauth2') {
      _validateOAuth2Fields(jsonPointer);
    } else if (type == 'openIdConnect') {
      _validateOpenIdConnectFields(jsonPointer);
    }
  }

  void _validateApiKeyFields(String jsonPointer) {
    ValidationUtils.requireField(json, 'name', jsonPointer);
    ValidationUtils.requireString(json['name'], ValidationUtils.buildPointer([jsonPointer, 'name']));

    final inValue = ValidationUtils.requireField(json, 'in', jsonPointer);
    ValidationUtils.requireString(inValue, ValidationUtils.buildPointer([jsonPointer, 'in']));
    ValidationUtils.validateEnum(inValue as String, [
      'query',
      'header',
      'cookie',
    ], ValidationUtils.buildPointer([jsonPointer, 'in']));
  }

  void _validateHttpFields(String jsonPointer) {
    ValidationUtils.requireField(json, 'scheme', jsonPointer);
    ValidationUtils.requireString(json['scheme'], ValidationUtils.buildPointer([jsonPointer, 'scheme']));
  }

  void _validateOAuth2Fields(String jsonPointer) {
    ValidationUtils.requireField(json, 'flows', jsonPointer);
    ValidationUtils.requireMap(json['flows'], ValidationUtils.buildPointer([jsonPointer, 'flows']));
  }

  void _validateOpenIdConnectFields(String jsonPointer) {
    ValidationUtils.requireField(json, 'openIdConnectUrl', jsonPointer);
    ValidationUtils.requireString(
      json['openIdConnectUrl'],
      ValidationUtils.buildPointer([jsonPointer, 'openIdConnectUrl']),
    );
  }

  void _validateDescription(String jsonPointer) {
    if (json.containsKey('description')) {
      ValidationUtils.requireString(json['description'], ValidationUtils.buildPointer([jsonPointer, 'description']));
    }
  }

  void _validateNoUnknownFields(String jsonPointer) {
    ValidationUtils.validateNoUnknownFields(
      json,
      {'type', 'description', 'name', 'in', 'scheme', 'bearerFormat', 'flows', 'openIdConnectUrl'},
      jsonPointer,
      'Security Scheme Object',
    );
  }

  @override
  void createChildNodes() {
    createNode<OAuthFlowsDocNode>(jsonKey: 'flows');
  }

  @override
  void createContent() {
    type = SecuritySchemeType.values.firstWhere((e) => e.value == json['type']);
    description = json['description'];
    name = json['name'];
    in_ = json['in'] != null ? SecuritySchemeIn.values.firstWhere((e) => e.value == json['in']) : null;
    scheme = json['scheme'];
    bearerFormat = json['bearerFormat'];
    flows = $to.to<OAuthFlowsDocNode>('flows');
    openIdConnectUrl = json['openIdConnectUrl'];
    extensions = extractExtensions(json);
  }

  @override
  String get $name {
    // Check if we already computed a name for this security scheme
    final cached = OpenApiGraph.i.nameRegistry.getCachedSecuritySchemeName($id!.absolutePointer);
    if (cached != null) return cached;

    // Compute the base name using the naming algorithm
    String baseName = _computeBaseName();

    // Sanitize and register the name (handles collisions)
    final sanitized = NamingUtils.toValidDartIdentifier(baseName);
    return OpenApiGraph.i.nameRegistry.registerSecuritySchemeName($id!.absolutePointer, sanitized);
  }

  String _computeBaseName() {
    // Step 1: Use the component key
    final componentBased = _deriveFromComponent();
    if (componentBased != null) return componentBased;

    // Step 2: Derive from scheme properties
    final propertiesBased = _deriveFromProperties();
    if (propertiesBased != null) return propertiesBased;

    // Step 3: Hash-based fallback
    return _generateHashFallback();
  }

  String? _deriveFromComponent() {
    // Check if this is a component security scheme
    // Path: securityScheme ← securitySchemesMap ← components
    final edge = trueParentEdge<SecuritySchemesMapDocNode>();
    if (edge != null) {
      final securitySchemesMapDocNode = edge.from as SecuritySchemesMapDocNode;
      // Check if parent is components
      if (securitySchemesMapDocNode.trueParentEdge<ComponentsDocNode>('securitySchemes') != null) {
        final componentKey = edge.via; // The map key
        return NamingUtils.toPascalCase(componentKey);
      }
    }
    return null;
  }

  String? _deriveFromProperties() {
    // Build name based on type and available properties
    final parts = <String>[];

    switch (type) {
      case SecuritySchemeType.http:
        // For http: include scheme (e.g. bearer, basic)
        if (scheme != null && scheme!.isNotEmpty) {
          parts.add(NamingUtils.toPascalCase(scheme!));
        }
        parts.add('Http');
        break;

      case SecuritySchemeType.apiKey:
        // For apiKey: include in (header/query/cookie) + name if present
        if (in_ != null) {
          parts.add(NamingUtils.toPascalCase(in_!.value));
        }
        if (name != null && name!.isNotEmpty) {
          parts.add(NamingUtils.toPascalCase(name!));
        }
        parts.add('ApiKey');
        break;

      case SecuritySchemeType.oauth2:
        // For oauth2: include a flow name if available
        final flowName = _getOAuthFlowName();
        if (flowName != null) {
          parts.add(NamingUtils.toPascalCase(flowName));
        }
        parts.add('OAuth2');
        break;

      case SecuritySchemeType.openIdConnect:
        // For openIdConnect: include a short token from the URL host/path if desired
        if (openIdConnectUrl != null && openIdConnectUrl!.isNotEmpty) {
          final urlToken = _extractUrlToken(openIdConnectUrl!);
          if (urlToken != null && urlToken.isNotEmpty) {
            parts.add(NamingUtils.toPascalCase(urlToken));
          }
        }
        parts.add('OpenIdConnect');
        break;
    }

    if (parts.isEmpty) {
      return null;
    }

    return '${parts.join()}SecurityScheme';
  }

  String? _getOAuthFlowName() {
    // Check which OAuth flow is present
    if (flows == null) return null;

    if (flows!.implicit != null) return 'implicit';
    if (flows!.password != null) return 'password';
    if (flows!.clientCredentials != null) return 'clientCredentials';
    if (flows!.authorizationCode != null) return 'authorizationCode';

    return null;
  }

  String? _extractUrlToken(String url) {
    // Extract a short token from the URL host/path
    try {
      final uri = Uri.parse(url);
      // Use host if available, otherwise use path segments
      if (uri.host.isNotEmpty) {
        // Take first part of host (e.g., "auth.example.com" -> "auth")
        final hostParts = uri.host.split('.');
        if (hostParts.isNotEmpty) {
          return hostParts.first;
        }
      }
      // Fallback to last path segment
      if (uri.pathSegments.isNotEmpty) {
        return uri.pathSegments.last;
      }
    } catch (e) {
      // If parsing fails, return null
    }
    return null;
  }

  String _generateHashFallback() {
    // Create a deterministic hash from the identity
    String identity;

    // Check if it's a component
    final edge = trueParentEdge<SecuritySchemesMapDocNode>();
    if (edge != null) {
      final securitySchemesMapDocNode = edge.from as SecuritySchemesMapDocNode;

      // Check if it's a component security scheme
      if (securitySchemesMapDocNode.trueParentEdge<ComponentsDocNode>('securitySchemes') != null) {
        final componentKey = edge.via;
        identity = '${$id!.document}#/components/securitySchemes/$componentKey';
      } else {
        // It's inline - use document URI and jsonPointer path
        identity = $id!.absolutePointer;
      }
    } else {
      identity = $id!.absolutePointer;
    }

    final codeUnits = identity.codeUnits;
    final hash = codeUnits.fold<int>(0, (prev, code) => (prev * 31 + code) & 0xFFFFFFFF);
    final shortHash = hash.toRadixString(16).padLeft(8, '0').substring(0, 6);
    return 'SecurityScheme_$shortHash';
  }
}

class SecuritySchemesMapDocNode extends MapDocNode<SecuritySchemeDocNode> {
  SecuritySchemesMapDocNode(super.json);
}
