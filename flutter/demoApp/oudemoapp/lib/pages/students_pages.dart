import 'package:flutter/material.dart';

class StudentsPage extends StatefulWidget {
  StudentsPage({Key? key}) : super(key: key);

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Öğrenciler")),
      body: Column(children: [
        Padding(padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 32.0),
        Container(
          const Text("")
        ),
      ],)
    );
  }
}