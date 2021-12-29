import 'package:flutter/material.dart';

class BuildExp extends StatefulWidget {
  BuildExp({Key? key}) : super(key: key);

  @override
  _BuildExpState createState() => _BuildExpState();
}

class _BuildExpState extends State<BuildExp> {
  var sinif = 5;
  var baslik = "Öğrenciler";
  var ogrenciler = ["Ali", "Ayşe", "Can"];

  @override
  Widget build(BuildContext context) {
    /*
    ogrenciler.add('ekle'); // Bu tarz eklemeler build içinde kesinlikle yapılmamalı.
    */
    return Scaffold(
        appBar: AppBar(
          title: Text("Merhaba"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$sinif. Sinif',
                textScaleFactor: 2,
              ),
              Text(
                '$baslik',
                textScaleFactor: 1.5,
              ),
              for (final o in ogrenciler) Text(o),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      ogrenciler.add('yeni');
                    });
                  },
                  child: Text('Ekle')),
            ],
          ),
        ));
  }
}
