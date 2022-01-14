import 'package:flutter/material.dart';

class BuildExp extends StatefulWidget {
  BuildExp({Key? key}) : super(key: key);

  @override
  _BuildExpState createState() => _BuildExpState();
}

class _BuildExpState extends State<BuildExp> {
  var sinif = 5;
  var baslik = "Test";
  var ogrenciler = [" Ali", "Ayşe", "Can"];
  void yeniOgrenciEkle(String yeniOgrenci) {
    setState(() {
      ogrenciler = [...ogrenciler, yeniOgrenci];
    });
  }

  @override
  Widget build(BuildContext context) {
    /*
    ogrenciler.add('ekle'); // Bu tarz eklemeler build içinde kesinlikle yapılmamalı.
    */
    return Scaffold(
      appBar: AppBar(
        title: Text("Merhaba"),
      ),
      body: SinifBilgisi(
          sinif: sinif,
          baslik: baslik,
          ogrenciler: ogrenciler,
          yeniOgrenciEkle: yeniOgrenciEkle,
          child: const Sinif()),
    );
  }
}

class SinifBilgisi extends InheritedWidget {
  const SinifBilgisi({
    Key? key,
    required this.child,
    required this.sinif,
    required this.baslik,
    required this.ogrenciler,
    required this.yeniOgrenciEkle,
  }) : super(key: key, child: child);

  final Widget child;
  final String baslik;
  final int sinif;
  final List<String> ogrenciler;
  final void Function(String yeniOgrenci) yeniOgrenciEkle;
//
  static SinifBilgisi? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SinifBilgisi>();
  }

  @override
  bool updateShouldNotify(SinifBilgisi oldWidget) {
    return sinif != oldWidget ||
        baslik != oldWidget ||
        ogrenciler != oldWidget.ogrenciler ||
        yeniOgrenciEkle != oldWidget.yeniOgrenciEkle;
  }
}

class Sinif extends StatelessWidget {
  const Sinif({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sinifBilgisi = SinifBilgisi.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly, //Kapsadığı alan içinde boşluk bırkır. fakat main axis size kullandığımız için aligment gerekmiyor şuan
        crossAxisAlignment:
            CrossAxisAlignment.center, //Kapsadığı alanı büyüdür.
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisSize: MainAxisSize.min, //Tüm boşlukları siler bu rowun.
            children: [
              Icon(Icons.star),
              Text(
                '${sinifBilgisi?.sinif}. Test',
                textScaleFactor: 2,
              ),
              Icon(Icons.star),
            ],
          ),
          Text(
            '${sinifBilgisi?.baslik}',
            textScaleFactor: 1.5,
          ),
          OgrenciListesi(),
          OgrenciEkleme(),
        ],
      ),
    );
  }
}

class OgrenciListesi extends StatelessWidget {
  const OgrenciListesi({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sinifBilgisi = SinifBilgisi.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final o in sinifBilgisi!.ogrenciler) Text(o),
      ],
    );
  }
}

class OgrenciEkleme extends StatefulWidget {
  const OgrenciEkleme({Key? key}) : super(key: key);

  @override
  State<OgrenciEkleme> createState() => _OgrenciEklemeState();
}

class _OgrenciEklemeState extends State<OgrenciEkleme> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sinifBilgisi = SinifBilgisi.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: controller,
          onChanged: (value) {
            setState(() {});
          },
        ),
        ElevatedButton(
            onPressed: controller.text.isEmpty
                ? null
                : () {
                    final yeniOgrenci = controller.text;
                    sinifBilgisi?.yeniOgrenciEkle(yeniOgrenci);
                    controller.text = '';
                    // setState(() {
                    //   ogrenciler.add('yeni');
                    // });
                  },
            child: Text('Ekle')),
      ],
    );
  }
}
