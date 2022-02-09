import 'package:flutter/material.dart';
import 'package:oudemoapp/pages/messages_page.dart';
import 'package:oudemoapp/pages/students_pages.dart';
import 'package:oudemoapp/pages/teachers_pages.dart';

void main() {
  runApp(StudentApp());
}

class StudentApp extends StatelessWidget {
  const StudentApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DemoApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: messagesPage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}
