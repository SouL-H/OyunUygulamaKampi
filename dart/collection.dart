void main() {
  /*final l = [1, 2, 3];
  final s = {1, 2, 3};
  final a = {1: 10, 2: 20, 3: 30};*/

  final List<int> l = [1, 2, 3];
  final Set<int> s = {1, 2, 3};
  //Map interable değil.
  final Map<int, int> a = {1: 10, 2: 20, 3: 30};

//List interablenin özelleşmiş hali.
// Interable sayesinde for in döngüsü yapılması sağlanıyor aslında.

  final Iterable<int> li = l;
  final Iterable<int> si = s;

  //Mapi interable şekline bu şekilde dönüştürülebildi.
  final Iterable<MapEntry<int, int>> nei = a.entries;
  final Iterable<int> mki = a.keys;
  final Iterable<int> mvi = a.values;

  for (final e in l) {
    print(e);
  }
  print(li.first);
  print(li.last);
  //var mı
  print(li.contains(4));

  li.forEach((element) {
    print(element);
  });
  //Liste çevirdik.
  List<int> list = si.toList();  

}
