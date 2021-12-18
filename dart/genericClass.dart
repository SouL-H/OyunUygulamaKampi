void main() {
  MyClass<int> m = MyClass<int>(4);
  print(m.val);

  final x = MyClassV2("hello");
  x.sayPrint();
}

class MyClass<T> {
  T val;
  MyClass(this.val);
}

class MyClassV2<T extends String> {
  T val;
  MyClassV2(this.val);

  void sayPrint() {
    print(val);
  }
}
