import 'dart:math';

import 'package:flutter/material.dart';
import 'package:oudemoapp/repository/messages_repository.dart';

class MessagesPage extends StatefulWidget {
  final MessagesRepository messagesRepository;
  MessagesPage(this.messagesRepository, {Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _messagesPageState();
}

class _messagesPageState extends State<MessagesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Mesajlar")),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(

                  itemCount: widget.messagesRepository.messages.length,
                  reverse: true, //son kısmından başlıyor.
                  itemBuilder: ((context, index) {

                    return showMessage(
                        widget.messagesRepository.messages[widget.messagesRepository.messages.length-index-1]);
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

class showMessage extends StatelessWidget {
  final Message message;
  const showMessage(
    this.message, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: message.sender=="Lory" ? Alignment.centerRight : Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.orange.shade200,
              border: Border.all(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(message.text),
            ),
          ),
        ));
  }
}
