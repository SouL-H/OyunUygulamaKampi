import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  InputPage({Key? key}) : super(key: key);

  @override
  State<InputPage> createState() => _InputPageState();
}

enum Cinsiyet { kadin, erkek, diger, bos }
const okullar = ['İlkokul', "Lise", "Üniversite", "YüksekLisans", "Doktora"];
final formKey = GlobalKey<FormState>();

class _InputPageState extends State<InputPage> {
  TextEditingController yorumController = TextEditingController();
  bool? dogruMu = false; //Checkbox için veriyi bizim tutmamız gerekiyor.
  Cinsiyet? cinsiyet = Cinsiyet.bos;
  String? okul;
  double boy = 100;
  @override
  void dispose() {
    yorumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Input Page")),
        body: Form(
          key: formKey,
          child: Column(
            children: [
              Checkbox(
                  value: dogruMu,
                  onChanged: (value) {
                    setState(() {
                      dogruMu = value;
                    });
                  }),
              Text(dogruMu == true ? "Evet" : "Hayir"),
              Radio<Cinsiyet>(
                  value: Cinsiyet.kadin,
                  groupValue: cinsiyet,
                  onChanged: (value) {
                    setState(() {
                      cinsiyet = value;
                    });
                  }),
              Radio<Cinsiyet>(
                  value: Cinsiyet.erkek,
                  groupValue: cinsiyet,
                  onChanged: (value) {
                    setState(() {
                      cinsiyet = value;
                    });
                  }),
              Text(cinsiyet.toString()),
              DropdownButton<String>(
                  value: okul,
                  items: okullar
                      .map(
                        (e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      okul = value;
                    });
                  }),
              Slider(
                min: 30,
                max: 300,
                value: boy,
                onChanged: (double value) {
                  setState(() {
                    boy = value;
                  });
                },
              ),
              Text("Boy= ${boy.toStringAsFixed(2)}"),
              TextFormField(
                  controller: yorumController,
                  onSaved: (newValue) {
                    print("Yorum kayddeidliyor. $newValue");
                  },
                  validator: (value) {
                    //Hata varsa string döner yoksa null döner.
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'Bos birakilmaz';
                      } else {
                        return null;
                      }
                    } else {
                      return 'Null olamaz';
                    }
                  },
                  onChanged: (value) {
                    setState(() {});
                  }),
              Text(
                yorumController.text,
                overflow: TextOverflow.ellipsis,
              ),
              ElevatedButton(
                  onPressed: () {
                    final uygunMu = formKey.currentState
                        ?.validate(); //içerik uygunsa true false dönüyor.
                    if (uygunMu == true) {
                      formKey.currentState?.save();
                      print('sunucuya gönderiliyor.');
                    }
                  },
                  child: Text("Gönder"))
            ],
          ),
        ));
  }
}
