part of 'document.dart';

typedef JsonConstructor<T> = T Function(Map<String, dynamic>);

JsonConstructor<T> _jsonConstructor<T>() {
  var fun;
  if (T == Schema) {
    fun = Schema.fromJson;
  }
  if (T == Response) {
    fun = Response.fromJson;
  }
  if (T == Parameter) {
    fun = Parameter.fromJson;
  }
  if (T == RequestBody) {
    fun = RequestBody.fromJson;
  }
  if (T == Example) {
    fun = Example.fromJson;
  }
  if (T == Header) {
    fun = Header.fromJson;
  }
  if (T == Link) {
    fun = Link.fromJson;
  }
  if (T == SecurityRequirement) {
    fun = SecurityRequirement.fromJson;
  }
  if (T == Callback) {
    fun = Callback.fromJson;
  }
  if (T == PathItem) {
    fun = PathItem.fromJson;
  }
  return fun as JsonConstructor<T>;
}