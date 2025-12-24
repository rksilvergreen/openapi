import 'dart:collection';

abstract class OpenApiObject {}

abstract class ListObject<T extends OpenApiObject> with ListMixin<T> {}
