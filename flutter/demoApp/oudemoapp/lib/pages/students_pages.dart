import 'package:flutter/material.dart';
import 'package:oudemoapp/repository/students_repository.dart';

class StudentsPage extends StatefulWidget {
  final StudentsRepository studentsRepository;
  StudentsPage(this.studentsRepository, {Key? key}) : super(key: key);

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  @override
  Widget build(BuildContext context) {
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
                  child: Text('${widget.studentsRepository.students.length} Students'),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: widget.studentsRepository.students.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) => StudentLine(
                    widget.studentsRepository.students[index],
                    widget.studentsRepository),
              ),
            )
          ],
        ));
  }
}

class StudentLine extends StatefulWidget {
  final Student student;
  final StudentsRepository studentsRepository;
  const StudentLine(
    this.student,
    this.studentsRepository, {
    Key? key,
  }) : super(key: key);

  @override
  State<StudentLine> createState() => _StudentLineState();
}

class _StudentLineState extends State<StudentLine> {
  @override
  Widget build(BuildContext context) {
    bool didLike = widget.studentsRepository.didLike(widget.student);
    return ListTile(
      title: Text(widget.student.name + ' ' + widget.student.surname),
      leading: IntrinsicWidth(
          child: Center(
              child: Text(widget.student.gender == "Man" ? '👨' : '👩'))),
      trailing: IconButton(
          onPressed: () {
            setState(() {
              widget.studentsRepository.love(widget.student,!didLike);
            });
          },
          icon: Icon(didLike ? Icons.favorite : Icons.favorite_border)),
    );
  }
}
