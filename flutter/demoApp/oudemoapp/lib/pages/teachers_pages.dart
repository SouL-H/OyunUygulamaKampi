import 'package:flutter/material.dart';
import 'package:oudemoapp/repository/teachers_repository.dart';

class TeachersPage extends StatefulWidget {
  final TeachersRepository teachersRepository;
  TeachersPage(this.teachersRepository, {Key? key}) : super(key: key);

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
            PhysicalModel(
              color: Colors.white,
              elevation: 10,
              child: Center(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                  child: Text(
                      '${widget.teachersRepository.teachers.length} Teachers'),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: widget.teachersRepository.teachers.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) => TeacherLine(
                    widget.teachersRepository.teachers[index],
                    widget.teachersRepository),
              ),
            ),
          ],
        ));
  }
}

class TeacherLine extends StatefulWidget {
  final Teacher teacher;
  final TeachersRepository teachersRepository;
  const TeacherLine(
    this.teacher,
    this.teachersRepository, {
    Key? key,
  }) : super(key: key);

  @override
  State<TeacherLine> createState() => _TeacherLineState();
}

class _TeacherLineState extends State<TeacherLine> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.teacher.name + ' ' + widget.teacher.surname),
      leading: IntrinsicWidth(
          child: Center(
              child: Text(widget.teacher.gender == "Man" ? '👨' : '👩'))),
    );
  }
}
