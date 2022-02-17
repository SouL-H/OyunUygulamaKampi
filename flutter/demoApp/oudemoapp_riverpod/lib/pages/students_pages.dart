import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oudemoapp_riverpod/repository/students_repository.dart';

import '../model/student.dart';

class StudentsPage extends ConsumerWidget {
  const StudentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentsRepository = ref.watch(studentsProvider);
    return Scaffold(
        appBar: AppBar(title: const Text("Students")),
        body: Column(
          children: [
            PhysicalModel(
              color: Colors.white,
              elevation: 10,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 32.0),
                  child: Text('${studentsRepository.students.length} Students'),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: studentsRepository.students.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) =>
                    StudentLine(studentsRepository.students[index]),
              ),
            )
          ],
        ));
  }
}

class StudentLine extends ConsumerWidget {
  final Student student;
  const StudentLine(
    this.student, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool didLike = ref.watch(studentsProvider).didLike(student);
    return ListTile(
      title: AnimatedPadding(
          duration: const Duration(milliseconds: 175),
          padding: didLike
              ? const EdgeInsets.only(left: 90)
              : const EdgeInsets.only(left: 0),
          child: Text(student.name + ' ' + student.surname),
          curve: Curves.bounceOut),
      leading: IntrinsicWidth(
          child: Center(child: Text(student.gender == "Man" ? '👨' : '👩'))),
      trailing: IconButton(
        onPressed: () {
          ref.read(studentsProvider).love(student,
              !didLike); //Burası onpress olduğu için read ile okumak gerekiyor.
        },
        icon: AnimatedCrossFade(
          firstChild: const Icon(Icons.favorite),
          secondChild: const Icon(Icons.favorite_border),
          crossFadeState:
              didLike ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: Duration(seconds: 1),
        ),
      ),
    );
  }
}
