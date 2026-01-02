import 'dart:convert';
import 'package:openapi_analyzer/v3_0_0/document/document.dart';

void main() {
  final document = Document(
    id: '1',
    tree: Tree(
      root: OpenApiDocument(
        openapi: '3.0.0',
        info: Info(title: 'Test', version: '1.0.0'),
        paths: {
          '/test': Ref.value(
            PathItem(
              get_: Operation(
                responses: {
                  '200': Ref.value(Response(description: 'Success')),
                },
              ),
            ),
          ),
        },
      ),
    ),
  );
  const encoder = JsonEncoder.withIndent('  ');
  print(encoder.convert((document.tree?.root as OpenApiDocumentNode).toJson()));
}
