void main() {
  final iterable = [2, 8, 4, 6, 7, 0];
  final doubleNumber = [2, 4, 6];

  print(iterable.first);
  print(iterable.last);
  //ilk tanıma uyanı bulup geri döner
  print(iterable.firstWhere((e) => e % 4 == 0));

  print(iterable.any((element) => element % 2 == 0));
  print(iterable.every((element) => element % 2 == 0));
  print(doubleNumber.every((element) => element % 2 == 0));
  //sonucu int olduğunu söylemek için <int> ekledik. Listenin toplamını verir.
  print(doubleNumber.fold<int>(
      0, (previousValue, element) => previousValue + element));

  //Dörde bölünenler filtrelenip yeni bir iterable olarak döndü.
  print(iterable.where((element) => element % 4 == 0));

  print(doubleNumber.map((e) => '$e sayisi'));
}
