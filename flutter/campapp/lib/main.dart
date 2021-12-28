import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //Hotreload'da bu nesneler sıfırdan yaratılıyor fakat state'de bu değişkenler tutulabiliyor.
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu), //Menü ızgarası ekleme sol tarafa
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              print("Remove");
            },
            icon: Icon(Icons.remove),
          ),
          IconButton(
            onPressed: () {
              print("Setting");
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Texting("Şu anki değer $_counter"),
            Sayac(
              "Dişari değer : $_counter",
              ilkDeger: 3,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, //Aktif başlangıç indexi.
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'One',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_alarm),
            label: 'Two',
          ),
        ],
      ),
    );
  }
}

class Texting extends StatelessWidget {
  final String text;
  const Texting(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}

class Sayac extends StatefulWidget {
  final String sayac;
  final int ilkDeger;
  const Sayac(this.sayac, {Key? key, required this.ilkDeger}) : super(key: key);

  @override
  _SayacState createState() => _SayacState();
}

class _SayacState extends State<Sayac> {
  int sayi = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sayi = widget.ilkDeger; //Üstten erişim sağlandı.
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          sayi++;
        });
      },
      child: Text('${widget.sayac}, içerideki: $sayi'),
    );
  }
  //Text(widget.sayac);//Kendi statesindeki değere widget ile ulaşabiliriz.
}
