import 'package:flutter/material.dart';

class BuildExp extends StatefulWidget {
  BuildExp({Key? key}) : super(key: key);

  @override
  _BuildExpState createState() => _BuildExpState();
}

class _BuildExpState extends State<BuildExp> {
  var sinif = 5;
  var baslik = "Test";
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
                    '$sinif. Test',
                    textScaleFactor: 2,
                  ),
                  Icon(Icons.star),
                ],
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
