void main() {
  final mapExample = {'key1': 5, 'key2': 7, 'key3': 12};
  
  //Map üzerinde döngü

  for(final entry in mapExample.entries){
    print('${entry.key}:${entry.value}');
  }

}
