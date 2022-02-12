import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oudemoapp_riverpod/repository/messages_repository.dart';

import '../model/message.dart';

class MessagesPage extends ConsumerStatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  _messagesPageState createState() => _messagesPageState();
}

class _messagesPageState extends ConsumerState<MessagesPage> {
  @override
  void initState() {
    //Bu değişiklik rebuild yapıyor her kullanan widgeti ana sayfada kullanıldığı için bozuluyor.
    //ref.read(newMessageCountProvider.notifier).reset();
    //Bu yüzden alttaki çözümü uyguluyoruz. Birazcık sonra yap anlamına gelir.
    Future.delayed(Duration.zero).then((value) =>ref.read(newMessageCountProvider.notifier).reset());
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final messagesRepository = ref.watch(messagesProvider);
    return Scaffold(
        appBar: AppBar(title: const Text("Mesajlar")),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: messagesRepository.messages.length,
                  reverse: true, //son kısmından başlıyor.
                  itemBuilder: ((context, index) {
                    return showMessage(messagesRepository.messages[
                        messagesRepository.messages.length - index - 1]);
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
                             const BorderRadius.all(Radius.circular(15.0))),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
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
        alignment: message.sender == "Lory"
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.orange.shade200,
              border: Border.all(color: Colors.grey, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(message.text),
            ),
          ),
        ));
  }
}
