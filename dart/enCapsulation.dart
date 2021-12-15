import 'example.dart';

void main() {
  Example exp1 = Example("Ahmet", 18, "test1", "a");
  Example exp2 = Example("Murat", 27, "test2", "n");
  Example exp3 = Example("Ömer", 28, "test3", "n");

  exp1.StudentInfo();
  exp2.StudentInfo();
  ////enCapsulation Example
  exp1.ageUp();
  exp1.ageUp();
  exp1.StudentInfo();

  exp1.benchmate = exp2;
  exp2.benchmate = exp1;
  exp1.StudentInfo();
  exp2.StudentInfo();
  exp3.StudentInfo();
}
