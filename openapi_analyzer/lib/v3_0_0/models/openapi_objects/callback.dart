import '../openapi_graph.dart';
import '../../validation/validation_utils.dart';
import '../referencable.dart';
import 'paths_map.dart';
import '../node_creation_helpers.dart';
import '../../naming/naming_utils.dart';
import 'callbacks_map.dart';
import 'components.dart';
import 'operation.dart';
import 'path_item.dart';

abstract class Callback {
  PathsMap get expressions;
  Map<String, dynamic>? get extensions;
  String get $name;
}

class CallbackNode extends Node with InternalNode, Referencable implements Callback {
  CallbackNode(super.json, super.document, super.jsonPointer);

  late final PathsMapNode expressions;
  late final Map<String, dynamic>? extensions;

  @override
  void validateStructure() {
    final jsonPointer = $id.jsonPointer;
    _validateExpressions(jsonPointer);
  }

  void _validateExpressions(String jsonPointer) {
    for (final key in json.keys) {
      final keyStr = key.toString();
      ValidationUtils.requireMap(json[key], ValidationUtils.buildPointer([jsonPointer, keyStr]));
    }
  }

  @override
  void createChildNodes() {
    createNode<PathsMapNode>(jsonKey: 'expressions', required: true);
  }

  @override
  void createContent() {
    expressions = $to.to<PathsMapNode>('expressions')!;
    extensions = extractExtensions(json);
  }

  @override
  String get $name {
    // Check if we already computed a name for this callback
    final cached = OpenApiGraph.i.nameRegistry.getCachedCallbackName($id.absolutePointer);
    if (cached != null) return cached;

    // Compute the base name using the naming algorithm
    String baseName = _computeBaseName();

    // Sanitize and register the name (handles collisions)
    final sanitized = NamingUtils.toValidDartIdentifier(baseName);
    return OpenApiGraph.i.nameRegistry.registerCallbackName($id.absolutePointer, sanitized);
  }

  String _computeBaseName() {
    // Step 1: Use the callback map key (check first for inline callbacks)
    final keyBased = _deriveFromCallbackKey();
    if (keyBased != null) return keyBased;

    // Step 2: If it's a component, use the component key
    final componentBased = _deriveFromComponent();
    if (componentBased != null) return componentBased;

    // Step 3: Hash-based fallback
    return _generateHashFallback();
  }

  String? _deriveFromCallbackKey() {
    // Get the callback key from the CallbacksMapNode edge
    // Path: callback ← callbacksMap ← operation
    final edge = trueParentEdge<CallbacksMapNode>();
    if (edge != null) {
      final callbacksMapNode = edge.from as CallbacksMapNode;
      // Only use this if it's NOT a component (components are handled in Step 2)
      if (callbacksMapNode.trueParentEdge<ComponentsNode>('callbacks') == null) {
        final callbackKey = edge.via; // The map key (e.g., "onData", "myEvent")
        return '${NamingUtils.toPascalCase(callbackKey)}Callback';
      }
    }
    return null;
  }

  String? _deriveFromComponent() {
    // Check if this is a component callback
    // Path: callback ← callbacksMap ← components
    final edge = trueParentEdge<CallbacksMapNode>();
    if (edge != null) {
      final callbacksMapNode = edge.from as CallbacksMapNode;
      // Check if parent is components
      if (callbacksMapNode.trueParentEdge<ComponentsNode>('callbacks') != null) {
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
    final edge = trueParentEdge<CallbacksMapNode>();
    if (edge != null) {
      final callbacksMapNode = edge.from as CallbacksMapNode;

      // Check if it's a component callback
      if (callbacksMapNode.trueParentEdge<ComponentsNode>('callbacks') != null) {
        final componentKey = edge.via;
        identity = '${$id.document}#/components/callbacks/$componentKey';
      } else {
        // It's inline - use document URI, path, method, "callbacks", callbackKey
        final callbackKey = edge.via;

        // Get the operation
        final operation = callbacksMapNode.trueParent<OperationNode>('callbacks');
        if (operation != null) {
          // Get path and method from the operation
          final pathAndMethod = _getPathAndMethodFromOperation(operation);
          if (pathAndMethod != null) {
            identity = '${$id.document}|${pathAndMethod['path']}|${pathAndMethod['method']}|callbacks|$callbackKey';
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
    return 'Callback_$shortHash';
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
