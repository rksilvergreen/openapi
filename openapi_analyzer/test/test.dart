import 'dart:collection';

void main() {
  dynamic x = X();
  x.toJson();
}

class X {
  void toJson() {
    print('toJson');
  }
}
