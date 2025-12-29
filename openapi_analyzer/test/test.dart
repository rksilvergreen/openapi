import 'dart:collection';

void main() {
  
}

class Person {
  final String name;
  final int age;
  Person({required this.name, required this.age});
}

extension ABC on Person {
  void set name(String value) {
    name = value;
  }
}