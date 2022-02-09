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
        body: ListView.builder(itemBuilder: ((context, index) {
          bool benMiyim = true;
          return Align(alignment: Alignment.centerRight,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color:Colors.black, width: 2), 
            ),
            child: Text("Mesaj"),
          )
          );
        })));
  }
}
