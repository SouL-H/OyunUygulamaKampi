import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oudemoapp_riverpod/pages/messages_page.dart';
import 'package:oudemoapp_riverpod/pages/students_pages.dart';
import 'package:oudemoapp_riverpod/pages/teachers_pages.dart';
import 'package:oudemoapp_riverpod/repository/messages_repository.dart';
import 'package:oudemoapp_riverpod/repository/students_repository.dart';
import 'package:oudemoapp_riverpod/repository/teachers_repository.dart';

void main() {
  runApp(const ProviderScope(child: StudentApp()));
}

class StudentApp extends StatelessWidget {
  const StudentApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Öğrenci Uygulaması',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Student Main PAge'),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentsRepository = ref.watch(studentsProvider);
    final teachersRepository = ref.watch(teachersProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              child: Text('${ref.watch(newMessageCountProvider)} new message'),
              onPressed: () {
                _goMessages(context);
              },
            ),
            TextButton(
              child: Text('${studentsRepository.students.length} students'),
              onPressed: () {
                _goStudents(context);
              },
            ),
            TextButton(
              child: Text('${teachersRepository.teachers.length} teachers'),
              onPressed: () {
                _goTeachers(context);
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Öğrenci adı'),
            ),
            ListTile(
              title: const Text('Students'),
              onTap: () {
                _goStudents(context);
              },
            ),
            ListTile(
              title: const Text('Teachers'),
              onTap: () {
                _goTeachers(context);
              },
            ),
            ListTile(
              title: const Text('Messages'),
              onTap: () {
                _goMessages(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _goStudents(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const StudentsPage();
      },
    ));
  }

  void _goTeachers(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const TeachersPage();
      },
    ));
  }

  void _goMessages(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const MessagesPage();
      },
    ));
  }
}
