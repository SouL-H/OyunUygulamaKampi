class TeachersRepository {
  final List teachers = [
    Teacher("Nikola", "Tesla", 27, "Man"),
    Teacher("Jhoon", "Wick", 34, "Man"),
    Teacher("Ketty", "Born", 32, "Woman"),
  ];
}

class Teacher {
  String name;
  String surname;
  int age;
  String gender;

  Teacher(this.name, this.surname, this.age, this.gender);
}
