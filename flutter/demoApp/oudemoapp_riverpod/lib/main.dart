import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oudemoapp_riverpod/login_service/google_sign_in.dart';
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
      title: 'Student Apps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplahScreen(),
    );
  }
}

class SplahScreen extends StatefulWidget {
  SplahScreen({Key? key}) : super(key: key);

  @override
  State<SplahScreen> createState() => _SplahScreenState();
}

class _SplahScreenState extends State<SplahScreen> {
  bool isFirebaseInitialized = false;
  @override
  void initState() {
    initializeFirebase();
    super.initState();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    setState(() {
      isFirebaseInitialized = true;
    });
    //_goToHomePage();
  }

  void _goToHomePage(GoogleSignInAccount? b) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => HomePage(userInfo: b),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: isFirebaseInitialized
              ? ElevatedButton(
                  //TODO Catch error
                  onPressed: () async {
                    final b = await signInWithGoogle();
                    String uid = b!.id;
                    FirebaseFirestore.instance.collection('users').doc(uid).set(
                      {
                        'isLogin': true,
                        'lastLogin':
                            FieldValue.serverTimestamp(), //Server o anki saati.
                      },
                      SetOptions(merge: true),
                    );
                    if (b != null) _goToHomePage(b);
                    print("Boş");
                  },
                  child: const Text("Google Sign In"))
              : const CircularProgressIndicator()),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({Key? key, required this.userInfo}) : super(key: key);
  final GoogleSignInAccount? userInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentsRepository = ref.watch(studentsProvider);
    final teachersRepository = ref.watch(teachersProvider);
    return Scaffold(
      appBar: AppBar(title: Text(userInfo!.displayName.toString())),
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
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: CircleAvatar(
                  child: ClipOval(
                child: Image.network(
                  userInfo!.photoUrl.toString(),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              )),
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
            ListTile(
              title: const Text('SignOut'),
              onTap: () {
                signOut();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return SplahScreen();
                  },
                ));
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
