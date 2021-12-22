void main() {
  final List<int> l = [1, 2, 3];
  final Set<int> s = {1, 2, 3};
  final Map<int, int> m = {1: 10, 2: 20, 3: 30};

  //!Uygun oldukça seti mapin içine ya da tam tersi açabiliriz.
  print([1, 23, ...l, 56, 75]);
  print({2, 5, 7, ...s, 62, 25});
  //son eklenen baslın çıkar.
  print({1: 25, 2: 35, 3: 365, ...m});

  //if and for

  print([
    1,
    2,
    3,
    if (1 == 1) 66,
    if (1 != 1) 33,
    7,
    12,
    //Basit for kullanabiliriz parantezsiz.
    for (int i = 15; i < 23; ++i) i,
  ]);

  //Set
  print({1, 2, if (1 == 1) 3, if (1 != 1) 22, 34, 34, 72});
  //Map
  print({1: 2, 3: 4, if (1 == 1) 6: 66, if (1 != 1) 7: 77, 7: 7});
  //Hepsinden ortaya karışık
  print([
    1,
    23,
    45,
    44,
    if (1 == 1) ...[77, 76, 75],
    if (1 == 2) 88,
    for (int i = 0; i < 5; ++i) i,
  ]);
  //List birleştirme bu şekilde de yapılabilir.
  print([1, 2, 3] + [3, 4, 5]);
}
