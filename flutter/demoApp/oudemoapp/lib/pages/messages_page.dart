import 'dart:math';

import 'package:flutter/material.dart';

class messagesPage extends StatefulWidget {
  messagesPage({Key? key}) : super(key: key);

  @override
  State<messagesPage> createState() => _messagesPageState();
}

class _messagesPageState extends State<messagesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Mesajlar")),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  reverse: true, //son kısmından başlıyor.
                  itemBuilder: ((context, index) {
                    bool benMiyim = Random().nextBool();
                    return Align(
                        alignment: benMiyim
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 16.0),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.orange.shade200,
                              border: Border.all(color: Colors.grey, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(24.0),
                              child: Text("Mesaj"),
                            ),
                          ),
                        ));
                  })),
            ),
            DecoratedBox(
              decoration: BoxDecoration(border: Border.all()),
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder
                                  .none), //Giriş alt çizgi kaldırdık.
                        ),
                      ),
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: ElevatedButton(
                        onPressed: () {
                          print("Helö");
                        },
                        child: const Text("Gönder")),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
