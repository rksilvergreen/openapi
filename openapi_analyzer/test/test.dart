import 'dart:collection';

abstract class MapNode<MAP> 
    implements MapBase<String, MAP> {
  MapNode(Map<String, dynamic> json, String document, String jsonPointer);

  late final Map<String, MAP> childNodes;
  late final Map<String, dynamic>? extensions;

  // MapBase implementation
  @override
  Iterable<String> get keys => childNodes.keys;

  @override
  MAP? operator [](Object? key) {
    if (key is! String) return null;
    return childNodes[key];
  }

  @override
  void operator []=(String key, MAP value) {
    childNodes[key] = value;
  }

  @override
  int get length => childNodes.length;

  @override
  bool get isEmpty => childNodes.isEmpty;

  @override
  bool get isNotEmpty => childNodes.isNotEmpty;

  @override
  Iterable<MapEntry<String, MAP>> get entries => childNodes.entries;

  @override
  Iterable<MAP> get values => childNodes.values;

  @override
  bool containsKey(Object? key) => childNodes.containsKey(key);

  @override
  void forEach(void Function(String key, MAP value) action) {
    childNodes.forEach(action);
  }

  @override
  MAP? remove(Object? key) => childNodes.remove(key);

  @override
  void clear() {
    childNodes.clear();
  }

  // Additional Map methods
  @override
  bool containsValue(Object? value) => childNodes.containsValue(value);

  @override
  void addAll(Map<String, MAP> other) {
    childNodes.addAll(other);
  }

  @override
  void addEntries(Iterable<MapEntry<String, MAP>> entries) {
    childNodes.addEntries(entries);
  }

  @override
  Map<RK, RV> cast<RK, RV>() => childNodes.cast<RK, RV>();

  @override
  MAP putIfAbsent(String key, MAP Function() ifAbsent) {
    return childNodes.putIfAbsent(key, ifAbsent);
  }

  @override
  MAP update(String key, MAP Function(MAP) update, {MAP Function()? ifAbsent}) {
    return childNodes.update(key, update, ifAbsent: ifAbsent);
  }

  @override
  void updateAll(MAP Function(String key, MAP value) update) {
    childNodes.updateAll(update);
  }

  @override
  void removeWhere(bool Function(String key, MAP value) test) {
    childNodes.removeWhere(test);
  }

  @override
  Map<K2, V2> map<K2, V2>(MapEntry<K2, V2> Function(String key, MAP value) convert) {
    return childNodes.map(convert);
  }
}

abstract class Table {
  Map<String, dynamic> get json;
  String get document;
  String get jsonPointer;
}

class TableNode implements Table {
  final Map<String, dynamic> json;
  final String document;
  final String jsonPointer;
  TableNode(this.json, this.document, this.jsonPointer);
}

abstract class TablesMap implements MapBase<String, Table> {
  Map<String, dynamic>? get extensions;
}

class TablesMapNode extends MapNode<Table> implements TablesMap {
  TablesMapNode(super.json, super.document, super.jsonPointer) {
    childNodes = {
      'table1': TableNode({}, '1', 'jsonPointer'),
      'table2': TableNode({}, '2', 'jsonPointer'),
    };
  }
}

void main() {
  TablesMap tablesMap = TablesMapNode({}, 'document', 'jsonPointer');
  var table1 = tablesMap['table1']!;
  var table2 = tablesMap['table2']!;
  print(table1.document);
  print(table2.document);
}