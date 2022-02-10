class StudentsRepository {
  final List students = [
    Student("Lory", "Wab", 19, "Man"),
    Student("Mick", "Lorder", 17, "Man"),
    Student("Enna", "Keynn", 16, "Woman"),
  ];

  final Set<Student> loved = {};
  void love(Student student, bool didLike) {
    if (didLike) {
      loved.add(student);
    }else{
loved.remove(student);
    }
    
  }

  bool didLike(Student student) {
    return loved.contains(student);
  }
}

class Student {
  String name;
  String surname;
  int age;
  String gender;

  Student(this.name, this.surname, this.age, this.gender);
}
