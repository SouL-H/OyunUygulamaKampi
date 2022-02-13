class Teacher {
  String name;
  String surname;
  int age;
  String gender;

  Teacher(this.name, this.surname, this.age, this.gender);

  Teacher.fromMap(Map<String, dynamic> m)
      : this(
          //m['name'],m['surname'],m['age'],m['gender'], http verilerine geçtik. Api türkçe yazılmış.
          m['ad'], m['soyad'], m['yas'], m['cinsiyet'],
        );

  Map toMap() {
    return {'ad': name, 'soyad': surname, 'yas': age, 'cinsiyet': gender};
  }
}
