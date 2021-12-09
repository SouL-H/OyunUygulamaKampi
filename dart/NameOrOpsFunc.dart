void main() {
  print("Main baslangiç");
  var ilk = "Baslangic yazisi";
  var son = "Bitis yazisi";

  String birlestir = ilk + son;
  print(birlestir);
  print(StrComb(ilk, son));
  print(StrCombV2(ilk));
  //StrComb(son: son); Hatalı kullanım ilk parametresi zorunlu değer girilmeli.
  print(StrCombV3(ilk: ilk, son: son));
}

String StrComb(String ilk, String son) {
  return ilk + " " + son;
}

//Opsiyonel Parametre, boş bırakıldığında yerine geçecek değer verilmesi lazım.

String StrCombV2(String ilk, [String son = ""]) {
  return ilk + " " + son;
}

//İsimli parametreler, bu şekilde opsiyonelde oldu tek birini de kullanabiliriz.
//Mesela bir parametre zorunlu verilmesi gerekiyorsa required eklenmesi lazım.
//Diğeri yine keyfi opsiyonel parametredeki gibi boş geldiğinde değer girilmeli.
String StrCombV3({required String ilk, String son = ""}) {
  return ilk + " " + son;
}
