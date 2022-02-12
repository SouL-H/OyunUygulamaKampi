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
                      child: TeacherDowlandButton())
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

class TeacherDowlandButton extends StatefulWidget {
  const TeacherDowlandButton({
    Key? key,
  }) : super(key: key);

  @override
  State<TeacherDowlandButton> createState() => _TeacherDowlandButtonState();
}

class _TeacherDowlandButtonState extends State<TeacherDowlandButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return isLoading
          ? const CircularProgressIndicator()
          : IconButton(
              icon: const Icon(Icons.download),
              onPressed: () async {
                //TODO Loading
                //TODO error
                try {
                  setState(() {
                    isLoading = true;
                  });
                  await ref.read(teachersProvider).download();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString())),
                  ); 
                } finally {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
            );
    });
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
          child: Center(
              child: Text((teacher.gender == "Man" || teacher.gender == "Erkek")
                  ? '👨'
                  : '👩'))),
    );
  }
}
