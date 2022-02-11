import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeachersRepository extends ChangeNotifier {
  final List teachers = [
    Teacher("Nikola", "Tesla", 27, "Man"),
    Teacher("Jhoon", "Wick", 34, "Man"),
    Teacher("Ketty", "Born", 32, "Woman"),
  ];
}

final teachersProvider = ChangeNotifierProvider((ref) => TeachersRepository());

class Teacher {
  String name;
  String surname;
  int age;
  String gender;

  Teacher(this.name, this.surname, this.age, this.gender);
}
