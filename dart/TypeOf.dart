typedef ExampleFunc = String Function({required String str1, String str2});

void main() {
  String str1 = "hello";
  String str2 = "by by";

  //Opsiyonel 1
  var f = print("Opsiyonel 1: " + testFunc(str1: str1, str2: str2));

  f;
  //Opsiyonel 2
  String Function({required String str1, String str2}) c = testFunc;
  String example = c(str1: str1, str2: str2);
  print("Opsiyonel 2: " + example);

  //Opsiyonel 3 using typeOf
  ExampleFunc expV2 = testFunc;
  print("Opsiyonel 3: " + expV2(str1: str1));

  //Opsiyonel 4 using => example
  String funcV2 = testFuncV2(str1: "İlk cümle", str2: "İkinci cümle");
  print("Opsiyonel 4: " + funcV2);
}

String testFunc({required String str1, String str2 = ""}) {
  return str1 + " " + "add new line==>> " + str2;
}

String testFuncV2({required String str1, String str2 = ""}) =>
    str1 + " " + "add new line==>> " + str2;
