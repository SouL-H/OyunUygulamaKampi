import 'package:flutter/material.dart';

class TeachersPage extends StatefulWidget {
  TeachersPage({Key? key}) : super(key: key);

  @override
  State<TeachersPage> createState() => _TeachersPageState();
}

class _TeachersPageState extends State<TeachersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Öğretmenler")),
        body: Column(
          children: [
            const PhysicalModel(
              color: Colors.white,
              elevation: 10,
              child: Center(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                  child: Text('10 Öğretmen'),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: 25,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) => ListTile(
                  title: const Text("Ayşe Hoca"),
                  leading: const Text("👩"), // 👨
                ),
              ),
            )
          ],
        ));
  }
}
