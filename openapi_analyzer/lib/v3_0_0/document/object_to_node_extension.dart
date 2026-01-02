part of 'document.dart';

extension ObjectToNode on Tree {
  (TreeNode, List<(Edge, Object)>)? _objectToNode(Object object) {
    // Base classes
    if (object is Ref<Callback>) {
      if (object.isReference()) {
        return (
          RefNode<CallbackNode>.reference(object.asReference()!),
          [],
        );
      }
      final callback = object.asValue()!;
      return (
        RefNode<CallbackNode>.value(CallbackNode(extensions: callback.extensions)),
        [(const Edge(PathsMapNode, 'expressions'), callback.expressions)],
      );
    }
    if (object is Components) {
      final components = object;
      final edges = <(Edge, Object)>[];
      if (components.schemas != null) {
        edges.add((const Edge(SchemasMapNode, 'schemas'), components.schemas!));
      }
      if (components.responses != null) {
        edges.add((const Edge(ResponsesMapNode, 'responses'), components.responses!));
      }
      if (components.parameters != null) {
        edges.add((const Edge(ParametersMapNode, 'parameters'), components.parameters!));
      }
      if (components.examples != null) {
        edges.add((const Edge(ExamplesMapNode, 'examples'), components.examples!));
      }
      if (components.requestBodies != null) {
        edges.add((const Edge(RequestBodiesMapNode, 'requestBodies'), components.requestBodies!));
      }
      if (components.headers != null) {
        edges.add((const Edge(HeadersMapNode, 'headers'), components.headers!));
      }
      if (components.securitySchemes != null) {
        edges.add((const Edge(SecuritySchemesMapNode, 'securitySchemes'), components.securitySchemes!));
      }
      if (components.links != null) {
        edges.add((const Edge(LinksMapNode, 'links'), components.links!));
      }
      if (components.callbacks != null) {
        edges.add((const Edge(CallbacksMapNode, 'callbacks'), components.callbacks!));
      }
      return (
        ComponentsNode(extensions: components.extensions),
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
        edges.add((const Edge(RefNode<SchemaNode>, 'schema'), object.schema!));
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
        edges.add((const Edge(RefNode<SchemaNode>, 'schema'), object.schema!));
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
        edges.add((const Edge(RefNode<RequestBodyNode>, 'requestBody'), object.requestBody!));
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
      return (RefNode<ParameterNode>.value(paramNode), edges);
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
    if (object is Ref<PathItem>) {
      if (object.isReference()) {
        return (
          RefNode<PathItemNode>.reference(object.asReference()!),
          [],
        );
      }
      final pathItem = object.asValue()!;
      final edges = <(Edge, Object)>[];
      if (pathItem.get_ != null) {
        edges.add((const Edge(OperationNode, 'get'), pathItem.get_!));
      }
      if (pathItem.put != null) {
        edges.add((const Edge(OperationNode, 'put'), pathItem.put!));
      }
      if (pathItem.post != null) {
        edges.add((const Edge(OperationNode, 'post'), pathItem.post!));
      }
      if (pathItem.delete != null) {
        edges.add((const Edge(OperationNode, 'delete'), pathItem.delete!));
      }
      if (pathItem.options != null) {
        edges.add((const Edge(OperationNode, 'options'), pathItem.options!));
      }
      if (pathItem.head != null) {
        edges.add((const Edge(OperationNode, 'head'), pathItem.head!));
      }
      if (pathItem.patch != null) {
        edges.add((const Edge(OperationNode, 'patch'), pathItem.patch!));
      }
      if (pathItem.trace != null) {
        edges.add((const Edge(OperationNode, 'trace'), pathItem.trace!));
      }
      if (pathItem.servers != null) {
        edges.add((const Edge(ServerList, 'servers'), pathItem.servers!));
      }
      if (pathItem.parameters != null) {
        edges.add((const Edge(ParametersListNode, 'parameters'), pathItem.parameters!));
      }
      final pathItemNode = PathItemNode(extensions: pathItem.extensions);
      return (RefNode<PathItemNode>.value(pathItemNode), edges);
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
        edges.add((const Edge(RefNode<SchemaNode>, 'items'), object.items!));
      }
      if (object.properties != null) {
        edges.add((const Edge(SchemasMapNode, 'properties'), object.properties!));
      }
      if (object.additionalProperties != null) {
        edges.add((const Edge(RefNode<SchemaNode>, 'additionalProperties'), object.additionalProperties!));
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

    // Ref types for referenceable classes
    if (object is Ref<Callback>) {
      if (object.isReference()) {
        return (
          RefNode<CallbackNode>.reference(object.asReference()!),
          [],
        );
      }
      final callback = object.asValue()!;
      final callbackNode = CallbackNode(extensions: callback.extensions);
      return (
        RefNode<CallbackNode>.value(callbackNode),
        [(const Edge(PathsMapNode, 'expressions'), callback.expressions)],
      );
    }
    if (object is Ref<Example>) {
      if (object.isReference()) {
        return (
          RefNode<ExampleNode>.reference(object.asReference()!),
          [],
        );
      }
      final example = object.asValue()!;
      final exampleNode = ExampleNode(
        summary: example.summary,
        description: example.description,
        value: example.value,
        externalValue: example.externalValue,
        extensions: example.extensions,
      );
      return (RefNode<ExampleNode>.value(exampleNode), []);
    }
    if (object is Ref<Header>) {
      if (object.isReference()) {
        return (
          RefNode<HeaderNode>.reference(object.asReference()!),
          [],
        );
      }
      final header = object.asValue()!;
      final edges = <(Edge, Object)>[];
      if (header.schema != null) {
        edges.add((const Edge(RefNode<SchemaNode>, 'schema'), header.schema!));
      }
      if (header.examples != null) {
        edges.add((const Edge(ExamplesMapNode, 'examples'), header.examples!));
      }
      if (header.content != null) {
        edges.add((const Edge(MediaTypesMapNode, 'content'), header.content!));
      }
      final headerNode = HeaderNode(
        description: header.description,
        required_: header.required_,
        deprecated: header.deprecated,
        allowEmptyValue: header.allowEmptyValue,
        style: header.style,
        explode: header.explode,
        allowReserved: header.allowReserved,
        extensions: header.extensions,
      );
      return (RefNode<HeaderNode>.value(headerNode), edges);
    }
    if (object is Ref<Link>) {
      if (object.isReference()) {
        return (
          RefNode<LinkNode>.reference(object.asReference()!),
          [],
        );
      }
      final link = object.asValue()!;
      final edges = <(Edge, Object)>[];
      if (link.server != null) {
        edges.add((const Edge(ServerNode, 'server'), link.server!));
      }
      final linkNode = LinkNode(
        operationRef: link.operationRef,
        operationId: link.operationId,
        parameters: link.parameters,
        requestBody: link.requestBody,
        description: link.description,
        extensions: link.extensions,
      );
      return (RefNode<LinkNode>.value(linkNode), edges);
    }
    if (object is Ref<RequestBody>) {
      if (object.isReference()) {
        return (
          RefNode<RequestBodyNode>.reference(object.asReference()!),
          [],
        );
      }
      final requestBody = object.asValue()!;
      final requestBodyNode = RequestBodyNode(
        description: requestBody.description,
        required: requestBody.required,
        extensions: requestBody.extensions,
      );
      return (
        RefNode<RequestBodyNode>.value(requestBodyNode),
        [(const Edge(MediaTypesMapNode, 'content'), requestBody.content)],
      );
    }
    if (object is Ref<Response>) {
      if (object.isReference()) {
        return (
          RefNode<ResponseNode>.reference(object.asReference()!),
          [],
        );
      }
      final response = object.asValue()!;
      final edges = <(Edge, Object)>[];
      if (response.headers != null) {
        edges.add((const Edge(HeadersMapNode, 'headers'), response.headers!));
      }
      if (response.content != null) {
        edges.add((const Edge(MediaTypesMapNode, 'content'), response.content!));
      }
      if (response.links != null) {
        edges.add((const Edge(LinksMapNode, 'links'), response.links!));
      }
      final responseNode = ResponseNode(
        description: response.description,
        extensions: response.extensions,
      );
      return (RefNode<ResponseNode>.value(responseNode), edges);
    }
    if (object is Ref<Schema>) {
      if (object.isReference()) {
        return (
          RefNode<SchemaNode>.reference(object.asReference()!),
          [],
        );
      }
      final schema = object.asValue()!;
      final edges = <(Edge, Object)>[];
      if (schema.items != null) {
        edges.add((const Edge(RefNode<SchemaNode>, 'items'), schema.items!));
      }
      if (schema.properties != null) {
        edges.add((const Edge(SchemasMapNode, 'properties'), schema.properties!));
      }
      if (schema.additionalProperties != null) {
        edges.add((const Edge(RefNode<SchemaNode>, 'additionalProperties'), schema.additionalProperties!));
      }
      if (schema.allOf != null) {
        edges.add((const Edge(SchemasListNode, 'allOf'), schema.allOf!));
      }
      if (schema.oneOf != null) {
        edges.add((const Edge(SchemasListNode, 'oneOf'), schema.oneOf!));
      }
      if (schema.anyOf != null) {
        edges.add((const Edge(SchemasListNode, 'anyOf'), schema.anyOf!));
      }
      if (schema.discriminator != null) {
        edges.add((const Edge(DiscriminatorNode, 'discriminator'), schema.discriminator!));
      }
      if (schema.xml != null) {
        edges.add((const Edge(XMLNode, 'xml'), schema.xml!));
      }
      if (schema.externalDocs != null) {
        edges.add((const Edge(ExternalDocumentationNode, 'externalDocs'), schema.externalDocs!));
      }
      final schemaNode = SchemaNode(
        title: schema.title,
        description: schema.description,
        default_: schema.default_,
        type: schema.type,
        format: schema.format,
        multipleOf: schema.multipleOf,
        maximum: schema.maximum,
        exclusiveMaximum: schema.exclusiveMaximum,
        minimum: schema.minimum,
        exclusiveMinimum: schema.exclusiveMinimum,
        maxLength: schema.maxLength,
        minLength: schema.minLength,
        pattern: schema.pattern,
        maxItems: schema.maxItems,
        minItems: schema.minItems,
        uniqueItems: schema.uniqueItems,
        maxProperties: schema.maxProperties,
        minProperties: schema.minProperties,
        required_: schema.required_,
        additionalPropertiesAllowed: schema.additionalPropertiesAllowed,
        nullable: schema.nullable,
        readOnly: schema.readOnly,
        writeOnly: schema.writeOnly,
        example: schema.example,
        deprecated: schema.deprecated,
        extensions: schema.extensions,
      );
      schemaNode.enum_ = schema.enum_;
      return (RefNode<SchemaNode>.value(schemaNode), edges);
    }
    if (object is Ref<SecurityRequirement>) {
      if (object.isReference()) {
        return (
          RefNode<SecurityRequirementNode>.reference(object.asReference()!),
          [],
        );
      }
      final securityRequirement = object.asValue()!;
      final securityRequirementNode = SecurityRequirementNode(requirements: securityRequirement.requirements);
      return (RefNode<SecurityRequirementNode>.value(securityRequirementNode), []);
    }

    // Map types
    if (object is Map<String, Ref<Callback>>) {
      return (
        CallbacksMapNode(extensions: _extractExtensions(object)),
        object.entries.map((entry) => (Edge(RefNode<CallbackNode>, entry.key), entry.value)).toList(),
      );
    }
    if (object is Map<String, Encoding>) {
      return (
        EncodingsMapNode(),
        object.entries.map((entry) => (Edge(EncodingNode, entry.key), entry.value)).toList(),
      );
    }
    if (object is Map<String, Ref<Example>>) {
      return (
        ExamplesMapNode(),
        object.entries.map((entry) => (Edge(RefNode<ExampleNode>, entry.key), entry.value)).toList(),
      );
    }
    if (object is Map<String, Ref<Header>>) {
      return (
        HeadersMapNode(),
        object.entries.map((entry) => (Edge(RefNode<HeaderNode>, entry.key), entry.value)).toList(),
      );
    }
    if (object is Map<String, Ref<Link>>) {
      return (
        LinksMapNode(),
        object.entries.map((entry) => (Edge(RefNode<LinkNode>, entry.key), entry.value)).toList(),
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
    if (object is Map<String, Ref<PathItem>>) {
      return (
        PathsMapNode(extensions: _extractExtensions(object)),
        object.entries.map((entry) => (Edge(RefNode<PathItemNode>, entry.key), entry.value)).toList(),
      );
    }
    if (object is Map<String, Ref<RequestBody>>) {
      return (
        RequestBodiesMapNode(),
        object.entries.map((entry) => (Edge(RefNode<RequestBodyNode>, entry.key), entry.value)).toList(),
      );
    }
    if (object is Map<String, Ref<Response>>) {
      return (
        ResponsesMapNode(extensions: _extractExtensions(object)),
        object.entries.map((entry) => (Edge(RefNode<ResponseNode>, entry.key), entry.value)).toList(),
      );
    }
    if (object is Map<String, Ref<Schema>>) {
      return (
        SchemasMapNode(),
        object.entries.map((entry) => (Edge(RefNode<SchemaNode>, entry.key), entry.value)).toList(),
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
    if (object is List<Ref<Parameter>>) {
      return (
        ParametersListNode(),
        object.mapIndexed((index, entry) => (Edge(RefNode<ParameterNode>, '$index'), entry)).toList(),
      );
    }
    if (object is List<Ref<Schema>>) {
      return (
        SchemasListNode(),
        object.mapIndexed((index, entry) => (Edge(RefNode<SchemaNode>, '$index'), entry)).toList(),
      );
    }
    if (object is List<Ref<SecurityRequirement>>) {
      return (
        SecurityRequirementsList(),
        object.mapIndexed((index, entry) => (Edge(RefNode<SecurityRequirementNode>, '$index'), entry)).toList(),
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
