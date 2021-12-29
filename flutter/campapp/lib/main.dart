import 'package:campapp/buildTest.dart';
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
      //home: const MyHomePage(title: 'Flutter Demo Home Page'), Eski ekran.
      home: BuildExp(),
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
  int aktifButton = 0;
  String istenenYazi = '';
  bool checkEt = false;

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
            //Veriyi kendisi tutuyor. Stateyi bizim yönetmemiz gerekmiyor.
            Writing(istenenYazi: istenenYazi),
            //Stateyi biz tutarız.
            Checkbox(
                value: checkEt,
                onChanged: (value) {
                  print(value);
                  setState(() {
                    if (value != null) checkEt = value;
                  });
                }),
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
            ElevatedButton(
                onPressed: aktifButton == 0
                    ? () {
                        print('0');
                        setState(() {
                          aktifButton = (aktifButton + 1) % 2;
                          istenenYazi = 'sifir';
                        });
                      }
                    : null,
                child: Text('0')),
            ElevatedButton(
                onPressed: aktifButton == 1
                    ? () {
                        print('1');
                        setState(() {
                          aktifButton = (aktifButton + 1) % 2;
                          istenenYazi = 'bir';
                        });
                      }
                    : null,
                child: Text('1')),
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

class Writing extends StatefulWidget {
  final String istenenYazi;
  const Writing({
    Key? key,
    required this.istenenYazi,
  }) : super(key: key);

  @override
  State<Writing> createState() => _WritingState();
}

class _WritingState extends State<Writing> {
  late TextEditingController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
    controller.addListener(() {
      print('yeni değer: ${controller.text}');
    });
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  //Hot reloadlarda stabil kalmasını sağladık.
  @override
  void didUpdateWidget(covariant Writing oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget.istenenYazi != widget.istenenYazi) {
      controller.text = widget.istenenYazi;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (value) {
        print(value);
      },
      decoration: InputDecoration(
          suffixIcon: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          controller.text = '';
        },
      )),
    );
  }
}
