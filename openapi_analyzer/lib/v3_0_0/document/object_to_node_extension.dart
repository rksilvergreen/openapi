part of 'document.dart';

extension ObjectToNode on Tree {
  (TreeNode, List<(Edge, Object)>)? _objectToNode(Object object) {
    // Base classes
    if (object is Callback) {
      return (
        CallbackNode(extensions: object.extensions),
        [(const Edge(PathsMapNode, 'expressions'), object.expressions)],
      );
    }
    if (object is Components) {
      final edges = <(Edge, Object)>[];
      if (object.schemas != null) {
        edges.add((const Edge(SchemasMapNode, 'schemas'), object.schemas!));
      }
      if (object.responses != null) {
        edges.add((const Edge(ResponsesMapNode, 'responses'), object.responses!));
      }
      if (object.parameters != null) {
        edges.add((const Edge(ParametersMapNode, 'parameters'), object.parameters!));
      }
      if (object.examples != null) {
        edges.add((const Edge(ExamplesMapNode, 'examples'), object.examples!));
      }
      if (object.requestBodies != null) {
        edges.add((const Edge(RequestBodiesMapNode, 'requestBodies'), object.requestBodies!));
      }
      if (object.headers != null) {
        edges.add((const Edge(HeadersMapNode, 'headers'), object.headers!));
      }
      if (object.securitySchemes != null) {
        edges.add((const Edge(SecuritySchemesMapNode, 'securitySchemes'), object.securitySchemes!));
      }
      if (object.links != null) {
        edges.add((const Edge(LinksMapNode, 'links'), object.links!));
      }
      if (object.callbacks != null) {
        edges.add((const Edge(CallbacksMapNode, 'callbacks'), object.callbacks!));
      }
      return (
        ComponentsNode(extensions: object.extensions),
        edges,
      );
    }
    if (object is Contact) {
      return (
        ContactNode(
          name: object.name,
          url: object.url,
          email: object.email,
          extensions: object.extensions,
        ),
        [],
      );
    }
    if (object is Discriminator) {
      return (
        DiscriminatorNode(
          propertyName: object.propertyName,
          mapping: object.mapping,
          extensions: object.extensions,
        ),
        [],
      );
    }
    if (object is Encoding) {
      final edges = <(Edge, Object)>[];
      if (object.headers != null) {
        edges.add((const Edge(HeadersMapNode, 'headers'), object.headers!));
      }
      return (
        EncodingNode(
          contentType: object.contentType,
          style: object.style,
          explode: object.explode,
          allowReserved: object.allowReserved,
          extensions: object.extensions,
        ),
        edges,
      );
    }
    if (object is Example) {
      return (
        ExampleNode(
          summary: object.summary,
          description: object.description,
          value: object.value,
          externalValue: object.externalValue,
          extensions: object.extensions,
        ),
        [],
      );
    }
    if (object is ExternalDocumentation) {
      return (
        ExternalDocumentationNode(
          description: object.description,
          url: object.url,
          extensions: object.extensions,
        ),
        [],
      );
    }
    if (object is Header) {
      final edges = <(Edge, Object)>[];
      if (object.schema != null) {
        edges.add((const Edge(SchemasMapNode, 'schema'), object.schema!));
      }
      if (object.examples != null) {
        edges.add((const Edge(ExamplesMapNode, 'examples'), object.examples!));
      }
      if (object.content != null) {
        edges.add((const Edge(MediaTypesMapNode, 'content'), object.content!));
      }
      return (
        HeaderNode(
          description: object.description,
          required_: object.required_,
          deprecated: object.deprecated,
          allowEmptyValue: object.allowEmptyValue,
          style: object.style,
          explode: object.explode,
          allowReserved: object.allowReserved,
          extensions: object.extensions,
        ),
        edges,
      );
    }
    if (object is Info) {
      final edges = <(Edge, Object)>[];
      if (object.contact != null) {
        edges.add((const Edge(ContactNode, 'contact'), object.contact!));
      }
      if (object.license != null) {
        edges.add((const Edge(LicenseNode, 'license'), object.license!));
      }
      return (
        InfoNode(
          title: object.title,
          description: object.description,
          termsOfService: object.termsOfService,
          version: object.version,
          extensions: object.extensions,
        ),
        edges,
      );
    }
    if (object is License) {
      return (
        LicenseNode(
          name: object.name,
          url: object.url,
          extensions: object.extensions,
        ),
        [],
      );
    }
    if (object is Link) {
      final edges = <(Edge, Object)>[];
      if (object.server != null) {
        edges.add((const Edge(ServerNode, 'server'), object.server!));
      }
      return (
        LinkNode(
          operationRef: object.operationRef,
          operationId: object.operationId,
          parameters: object.parameters,
          requestBody: object.requestBody,
          description: object.description,
          extensions: object.extensions,
        ),
        edges,
      );
    }
    if (object is MediaType) {
      final edges = <(Edge, Object)>[];
      if (object.schema != null) {
        edges.add((const Edge(SchemasMapNode, 'schema'), object.schema!));
      }
      if (object.examples != null) {
        edges.add((const Edge(ExamplesMapNode, 'examples'), object.examples!));
      }
      if (object.encoding != null) {
        edges.add((const Edge(EncodingsMapNode, 'encoding'), object.encoding!));
      }
      return (
        MediaTypeNode(
          example: object.example,
          extensions: object.extensions,
        ),
        edges,
      );
    }
    if (object is OAuthFlow) {
      return (
        OAuthFlowNode(
          authorizationUrl: object.authorizationUrl,
          tokenUrl: object.tokenUrl,
          refreshUrl: object.refreshUrl,
          scopes: object.scopes,
          extensions: object.extensions,
        ),
        [],
      );
    }
    if (object is OAuthFlows) {
      final edges = <(Edge, Object)>[];
      if (object.implicit != null) {
        edges.add((const Edge(OAuthFlowNode, 'implicit'), object.implicit!));
      }
      if (object.password != null) {
        edges.add((const Edge(OAuthFlowNode, 'password'), object.password!));
      }
      if (object.clientCredentials != null) {
        edges.add((const Edge(OAuthFlowNode, 'clientCredentials'), object.clientCredentials!));
      }
      if (object.authorizationCode != null) {
        edges.add((const Edge(OAuthFlowNode, 'authorizationCode'), object.authorizationCode!));
      }
      return (
        OAuthFlowsNode(extensions: object.extensions),
        edges,
      );
    }
    if (object is OpenApiDocument) {
      final edges = <(Edge, Object)>[];
      edges.add((const Edge(InfoNode, 'info'), object.info));
      if (object.servers != null) {
        edges.add((const Edge(ServerList, 'servers'), object.servers!));
      }
      edges.add((const Edge(PathsMapNode, 'paths'), object.paths));
      if (object.components != null) {
        edges.add((const Edge(ComponentsNode, 'components'), object.components!));
      }
      if (object.security != null) {
        edges.add((const Edge(SecurityRequirementsList, 'security'), object.security!));
      }
      if (object.tags != null) {
        edges.add((const Edge(TagsList, 'tags'), object.tags!));
      }
      if (object.externalDocs != null) {
        edges.add((const Edge(ExternalDocumentationNode, 'externalDocs'), object.externalDocs!));
      }
      return (
        OpenApiDocumentNode(
          openapi: object.openapi,
          extensions: object.extensions,
        ),
        edges,
      );
    }
    if (object is Operation) {
      final edges = <(Edge, Object)>[];
      if (object.externalDocs != null) {
        edges.add((const Edge(ExternalDocumentationNode, 'externalDocs'), object.externalDocs!));
      }
      if (object.parameters != null) {
        edges.add((const Edge(ParametersListNode, 'parameters'), object.parameters!));
      }
      if (object.requestBody != null) {
        edges.add((const Edge(RequestBodyNode, 'requestBody'), object.requestBody!));
      }
      edges.add((const Edge(ResponsesMapNode, 'responses'), object.responses));
      if (object.callbacks != null) {
        edges.add((const Edge(CallbacksMapNode, 'callbacks'), object.callbacks!));
      }
      if (object.security != null) {
        edges.add((const Edge(SecurityRequirementsList, 'security'), object.security!));
      }
      if (object.servers != null) {
        edges.add((const Edge(ServerList, 'servers'), object.servers!));
      }
      return (
        OperationNode(extensions: object.extensions),
        edges,
      );
    }
    if (object is Ref<Parameter>) {
      if (object.isReference()) {
        return (
          RefNode<ParameterNode>.reference(object.asReference()!),
          [],
        );
      }
      final parameter = object.asValue()!;
      final edges = <(Edge, Object)>[];
      if (parameter.schema != null) {
        edges.add((const Edge(RefNode<SchemaNode>, 'schema'), parameter.schema!));
      }
      if (parameter.examples != null) {
        edges.add((const Edge(ExamplesMapNode, 'examples'), parameter.examples!));
      }
      if (parameter.content != null) {
        edges.add((const Edge(MediaTypesMapNode, 'content'), parameter.content!));
      }
      final paramNode = ParameterNode(
        name: parameter.name,
        in_: parameter.in_,
        description: parameter.description,
        required_: parameter.required_,
        deprecated: parameter.deprecated,
        allowEmptyValue: parameter.allowEmptyValue,
        style: parameter.style,
        explode: parameter.explode,
        allowReserved: parameter.allowReserved,
        extensions: parameter.extensions,
      );
      paramNode.example = parameter.example;
      return (paramNode, edges);
    }
    if (object is PathItem) {
      final edges = <(Edge, Object)>[];
      if (object.get_ != null) {
        edges.add((const Edge(OperationNode, 'get'), object.get_!));
      }
      if (object.put != null) {
        edges.add((const Edge(OperationNode, 'put'), object.put!));
      }
      if (object.post != null) {
        edges.add((const Edge(OperationNode, 'post'), object.post!));
      }
      if (object.delete != null) {
        edges.add((const Edge(OperationNode, 'delete'), object.delete!));
      }
      if (object.options != null) {
        edges.add((const Edge(OperationNode, 'options'), object.options!));
      }
      if (object.head != null) {
        edges.add((const Edge(OperationNode, 'head'), object.head!));
      }
      if (object.patch != null) {
        edges.add((const Edge(OperationNode, 'patch'), object.patch!));
      }
      if (object.trace != null) {
        edges.add((const Edge(OperationNode, 'trace'), object.trace!));
      }
      if (object.servers != null) {
        edges.add((const Edge(ServerList, 'servers'), object.servers!));
      }
      if (object.parameters != null) {
        edges.add((const Edge(ParametersListNode, 'parameters'), object.parameters!));
      }
      return (
        PathItemNode(extensions: object.extensions),
        edges,
      );
    }
    if (object is RequestBody) {
      return (
        RequestBodyNode(
          description: object.description,
          required: object.required,
          extensions: object.extensions,
        ),
        [(const Edge(MediaTypesMapNode, 'content'), object.content)],
      );
    }
    if (object is Response) {
      final edges = <(Edge, Object)>[];
      if (object.headers != null) {
        edges.add((const Edge(HeadersMapNode, 'headers'), object.headers!));
      }
      if (object.content != null) {
        edges.add((const Edge(MediaTypesMapNode, 'content'), object.content!));
      }
      if (object.links != null) {
        edges.add((const Edge(LinksMapNode, 'links'), object.links!));
      }
      return (
        ResponseNode(
          description: object.description,
          extensions: object.extensions,
        ),
        edges,
      );
    }
    if (object is Schema) {
      final edges = <(Edge, Object)>[];
      if (object.items != null) {
        edges.add((const Edge(SchemaNode, 'items'), object.items!));
      }
      if (object.properties != null) {
        edges.add((const Edge(SchemasMapNode, 'properties'), object.properties!));
      }
      if (object.additionalProperties != null) {
        edges.add((const Edge(SchemaNode, 'additionalProperties'), object.additionalProperties!));
      }
      if (object.allOf != null) {
        edges.add((const Edge(SchemasListNode, 'allOf'), object.allOf!));
      }
      if (object.oneOf != null) {
        edges.add((const Edge(SchemasListNode, 'oneOf'), object.oneOf!));
      }
      if (object.anyOf != null) {
        edges.add((const Edge(SchemasListNode, 'anyOf'), object.anyOf!));
      }
      if (object.discriminator != null) {
        edges.add((const Edge(DiscriminatorNode, 'discriminator'), object.discriminator!));
      }
      if (object.xml != null) {
        edges.add((const Edge(XMLNode, 'xml'), object.xml!));
      }
      if (object.externalDocs != null) {
        edges.add((const Edge(ExternalDocumentationNode, 'externalDocs'), object.externalDocs!));
      }
      final schemaNode = SchemaNode(
        title: object.title,
        description: object.description,
        default_: object.default_,
        type: object.type,
        format: object.format,
        multipleOf: object.multipleOf,
        maximum: object.maximum,
        exclusiveMaximum: object.exclusiveMaximum,
        minimum: object.minimum,
        exclusiveMinimum: object.exclusiveMinimum,
        maxLength: object.maxLength,
        minLength: object.minLength,
        pattern: object.pattern,
        maxItems: object.maxItems,
        minItems: object.minItems,
        uniqueItems: object.uniqueItems,
        maxProperties: object.maxProperties,
        minProperties: object.minProperties,
        required_: object.required_,
        additionalPropertiesAllowed: object.additionalPropertiesAllowed,
        nullable: object.nullable,
        readOnly: object.readOnly,
        writeOnly: object.writeOnly,
        example: object.example,
        deprecated: object.deprecated,
        extensions: object.extensions,
      );
      schemaNode.enum_ = object.enum_;
      return (schemaNode, edges);
    }
    if (object is SecurityRequirement) {
      return (
        SecurityRequirementNode(requirements: object.requirements),
        [],
      );
    }
    if (object is SecurityScheme) {
      final edges = <(Edge, Object)>[];
      if (object.flows != null) {
        edges.add((const Edge(OAuthFlowsNode, 'flows'), object.flows!));
      }
      return (
        SecuritySchemeNode(
          type: object.type,
          description: object.description,
          name: object.name,
          in_: object.in_,
          scheme: object.scheme,
          bearerFormat: object.bearerFormat,
          openIdConnectUrl: object.openIdConnectUrl,
          extensions: object.extensions,
        ),
        edges,
      );
    }
    if (object is Server) {
      final edges = <(Edge, Object)>[];
      if (object.variables != null) {
        edges.add((const Edge(ServerVariablesMapNode, 'variables'), object.variables!));
      }
      return (
        ServerNode(
          url: object.url,
          description: object.description,
          extensions: object.extensions,
        ),
        edges,
      );
    }
    if (object is ServerVariable) {
      return (
        ServerVariableNode(
          enum_: object.enum_,
          default_: object.default_,
          description: object.description,
          extensions: object.extensions,
        ),
        [],
      );
    }
    if (object is Tag) {
      final edges = <(Edge, Object)>[];
      if (object.externalDocs != null) {
        edges.add((const Edge(ExternalDocumentationNode, 'externalDocs'), object.externalDocs!));
      }
      return (
        TagNode(
          name: object.name,
          description: object.description,
          extensions: object.extensions,
        ),
        edges,
      );
    }
    if (object is XML) {
      return (
        XMLNode(
          name: object.name,
          namespace: object.namespace,
          prefix: object.prefix,
          attribute: object.attribute,
          wrapped: object.wrapped,
          extensions: object.extensions,
        ),
        [],
      );
    }

    // Map types
    if (object is Map<String, Callback>) {
      return (
        CallbacksMapNode(extensions: _extractExtensions(object)),
        object.entries.map((entry) => (Edge(CallbackNode, entry.key), entry.value)).toList(),
      );
    }
    if (object is Map<String, Encoding>) {
      return (
        EncodingsMapNode(),
        object.entries.map((entry) => (Edge(EncodingNode, entry.key), entry.value)).toList(),
      );
    }
    if (object is Map<String, Example>) {
      return (
        ExamplesMapNode(),
        object.entries.map((entry) => (Edge(ExampleNode, entry.key), entry.value)).toList(),
      );
    }
    if (object is Map<String, Header>) {
      return (
        HeadersMapNode(),
        object.entries.map((entry) => (Edge(HeaderNode, entry.key), entry.value)).toList(),
      );
    }
    if (object is Map<String, Link>) {
      return (
        LinksMapNode(),
        object.entries.map((entry) => (Edge(LinkNode, entry.key), entry.value)).toList(),
      );
    }
    if (object is Map<String, MediaType>) {
      return (
        MediaTypesMapNode(),
        object.entries.map((entry) => (Edge(MediaTypeNode, entry.key), entry.value)).toList(),
      );
    }
    if (object is Map<String, Ref<Parameter>>) {
      return (
        ParametersMapNode(),
        object.entries.map((entry) => (Edge(RefNode<ParameterNode>, entry.key), entry.value)).toList(),
      );
    }
    if (object is Map<String, PathItem>) {
      return (
        PathsMapNode(extensions: _extractExtensions(object)),
        object.entries.map((entry) => (Edge(PathItemNode, entry.key), entry.value)).toList(),
      );
    }
    if (object is Map<String, RequestBody>) {
      return (
        RequestBodiesMapNode(),
        object.entries.map((entry) => (Edge(RequestBodyNode, entry.key), entry.value)).toList(),
      );
    }
    if (object is Map<String, Response>) {
      return (
        ResponsesMapNode(extensions: _extractExtensions(object)),
        object.entries.map((entry) => (Edge(ResponseNode, entry.key), entry.value)).toList(),
      );
    }
    if (object is Map<String, Schema>) {
      return (
        SchemasMapNode(),
        object.entries.map((entry) => (Edge(SchemaNode, entry.key), entry.value)).toList(),
      );
    }
    if (object is Map<String, SecurityScheme>) {
      return (
        SecuritySchemesMapNode(),
        object.entries.map((entry) => (Edge(SecuritySchemeNode, entry.key), entry.value)).toList(),
      );
    }
    if (object is Map<String, ServerVariable>) {
      return (
        ServerVariablesMapNode(),
        object.entries.map((entry) => (Edge(ServerVariableNode, entry.key), entry.value)).toList(),
      );
    }

    // List types
    if (object is List<Parameter>) {
      return (
        ParametersListNode(),
        object.mapIndexed((index, entry) => (Edge(ParameterNode, '$index'), entry)).toList(),
      );
    }
    if (object is List<Schema>) {
      return (
        SchemasListNode(),
        object.mapIndexed((index, entry) => (Edge(SchemaNode, '$index'), entry)).toList(),
      );
    }
    if (object is List<SecurityRequirement>) {
      return (
        SecurityRequirementsList(),
        object.mapIndexed((index, entry) => (Edge(SecurityRequirementNode, '$index'), entry)).toList(),
      );
    }
    if (object is List<Server>) {
      return (
        ServerList(),
        object.mapIndexed((index, entry) => (Edge(ServerNode, '$index'), entry)).toList(),
      );
    }
    if (object is List<Tag>) {
      return (
        TagsList(),
        object.mapIndexed((index, entry) => (Edge(TagNode, '$index'), entry)).toList(),
      );
    }

    return null;
  }
}
