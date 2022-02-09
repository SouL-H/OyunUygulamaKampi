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
        body: Column(
          children: [
            const PhysicalModel(
              color: Colors.white,
              elevation: 10,
              child: Center(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                  child: Text('10 öğrenci'),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: 25,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) => ListTile(
                  title: const Text("Ali"),
                  leading: const Text("👨"),// 👩
                  trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border)),
                ),
              ),
            )
          ],
        ));
  }
}
