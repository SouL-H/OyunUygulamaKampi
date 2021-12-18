void main() {
  List<Teacher> teachers = [
    Teacher("John"),
    EngTeacher("Porsesive Abj", "Beddy"),
  ];

  for (final say in teachers) say.sayHello();
}

class Teacher {
  String name;
  Teacher(this.name);
  void sayHello() {
    print("Hello student, My name is $name");
  }
}

class EngTeacher extends Teacher {
  String chapher;

  EngTeacher(this.chapher, String name) : super(name);

  @override
  void sayHello() {
    print("Extends class");
    //up class func get
    super.sayHello();
    print("Now Subject : $chapher");
  }
}
