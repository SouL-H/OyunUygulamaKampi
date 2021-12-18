void main() {
  final student1 = StudentV("Ahmet", 21);
  final student2 = StudentV.newVersion("murat");
  final student3 = StudentV.cc();

  student1.info();
  student2.info();
  // 
  student3.info();
}

//Bu şekilde const parametre oluşturmuş olduk.
//  Const olmazsa bu şekilde kullanım sağlanmazdı.
const exp = StudentV("Deneme", 20);

class StudentV {
  final String name;
  final int age;
  const StudentV(this.name, int y) : age = y;
  //Name contructor
  const StudentV.newVersion(String name) : this(name, 10);
  void info() {
    print("Student info: Name: $name Age: $age");
  }

  //Exp nesnesini dönderir. Nesneyi kendisi yaratmıyor bizim oluşturup vermemiz gerekiyor.
  // Kullanırken aynı contructor gibi kullanırız.
  factory StudentV.cc() {
    return exp;
  }
}
