
abstract class Referencable {
  ReferencableId get $id;
}

class ReferencableId {
  final String document;
  final String relativePath;
  final String absolutePath;

  const ReferencableId(this.document, this.relativePath, this.absolutePath);
}

Map<String, Referencable> referenceGraph = {};
