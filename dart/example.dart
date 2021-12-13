class Example {
  String name;
  //private
  int _age;
  String? school;

  //Late ile değer atayacağımıza söz vermiş oluyoruz. 
  //Hata yazmaz fakat değer atamadan çalıştırdığımızda uygulama problem oluşturur.
  late String adress;

  Example(this.name, this._age, this.school,this.adress);

  void StudentInfo() {
    print("Student name: $name and age: $_age school: $school adress: $adress");
  }

  void ageUp() {
    ++_age;
  }
}
