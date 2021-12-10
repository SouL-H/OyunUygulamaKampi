void main() {
  final student1 = Student(15, "Mehmet", "Ak", 15);
  final student2 = Student(16, "Ahmet", "Kaya", 17);
  student1.mailActive = true;
  print(student1);
  print(student2);
  print(student1.nameAndAge);
  student1.FullName = "Ali Ak";
  print(student1.FullName);
}

class Student {
  int No;
  String Name;
  String surName;
  int Age;
  bool mailActive;

  //Bu şekilde ilk değer olarak maili false olarak vermiş oluyoruz.
  Student(this.No, this.Name, this.surName, this.Age) : mailActive = false;
  //Direk class'in print ile yazilmasi için toString override edilmeli.
  @override
  String toString() {
    return '$No - $Name - $Age- $mailActive';
  }

  String get nameAndAge => '$Name - $Age';

  String get FullName => '$Name $surName';
  set FullName(String val) {
    int space = val.indexOf(' ');
    Name = val.substring(0, space);
    surName = val.substring(space + 1);
  }
}
