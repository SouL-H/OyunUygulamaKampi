void main() {
  final student1 = ExampClass("Ahmet", 21);
  student1.age = 25;
  print("Güncel yasi: " + (student1.infoAge).toString());


  //Mini examp
  final examp = MyClass();
  //atanan örnek
  examp.a = 5;
  //Geri dönen değer.
  print(examp.a);
}

class ExampClass {
  final String name;
  int _age;
  ExampClass(this.name, this._age);
  //Getter
  int get infoAge => _age;

  set age(int v) {
    print("$_age olan yaş, $v ile değiştirildi");
    _age = v;
  }
}

class MyClass {
  late int _a;
  int get a => _a;
  set a(int v) => _a = v;
}
