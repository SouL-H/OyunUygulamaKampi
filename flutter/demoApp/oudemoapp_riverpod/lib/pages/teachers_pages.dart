import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oudemoapp_riverpod/repository/teachers_repository.dart';

import '../model/teacher.dart';

class TeachersPage extends ConsumerWidget {
  const TeachersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teachersRepository = ref.watch(teachersProvider);
    return Scaffold(
        appBar: AppBar(title: const Text("Öğretmenler")),
        body: Column(
          children: [
            PhysicalModel(
              color: Colors.white,
              elevation: 10,
              child: Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 32.0),
                      child: Text(
                          '${teachersRepository.teachers.length} Teachers'),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: const Icon(Icons.download),
                        onPressed: () {
                          ref.read(teachersProvider).download();
                        },
                      ))
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: teachersRepository.teachers.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) =>
                    TeacherLine(teachersRepository.teachers[index]),
              ),
            ),
          ],
        ));
  }
}

class TeacherLine extends StatelessWidget {
  final Teacher teacher;
  const TeacherLine(
    this.teacher, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(teacher.name + ' ' + teacher.surname),
      leading: IntrinsicWidth(
          child: Center(child: Text(teacher.gender == "Man" ? '👨' : '👩'))),
    );
  }
}
