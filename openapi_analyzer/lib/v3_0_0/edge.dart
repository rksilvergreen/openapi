import 'node.dart';
import 'package:collection/collection.dart';

enum EdgeFormType { inline, referenced }

class Edge {
  final Node from;
  final Node to;
  final String via;
  final EdgeForm form;

  Edge(this.from, this.to, this.via, this.form);
}

extension EdgeIterableExtension on Iterable<Edge> {
  T? to<T extends Node>(String via) => firstWhereOrNull((edge) => (edge.to is T) && (edge.via == via))!.to as T;

  T? from<T extends Node>(String via) => firstWhereOrNull((edge) => (edge.from is T) && (edge.via == via))!.from as T;
}

class EdgeForm {
  EdgeFormType type;
  
}