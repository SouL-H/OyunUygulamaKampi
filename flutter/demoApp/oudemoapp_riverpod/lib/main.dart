import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
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
            UserHeader(userInfo: userInfo),
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

class UserHeader extends StatefulWidget {
  GoogleSignInAccount? userInfo;
  UserHeader({Key? key, this.userInfo}) : super(key: key);

  @override
  State<UserHeader> createState() => _UserHeaderState();
}

class _UserHeaderState extends State<UserHeader> {
  Future<Uint8List?>? _picFuture;
  @override
  void initState() {
    _picFuture = _picDownload();
    super.initState();
  }

  Future<Uint8List?> _picDownload() async {
    final uid = widget.userInfo!.id;
    final docSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final userRecMap = docSnapshot.data();
    if (userRecMap == null) return null;
    if (userRecMap.containsKey('picref')) {
      Uint8List? uint8list =
          await FirebaseStorage.instance.ref(userRecMap['picref']).getData();
      return uint8list;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, //Sola yaslama.
        children: [
          const SizedBox(
            height: 10,
          ),
          InkWell(
              //Butona çevirdik.
              onTap: () async {
                XFile? xFile =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                if (xFile == null) return;
                final imagePath = xFile.path;
                final piccRef = FirebaseStorage.instance
                    .ref('picture')
                    .child('${widget.userInfo!.id.toString()}.jpg');
                await piccRef.putFile(File(imagePath));
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.userInfo!.id)
                    .update({'picref': piccRef.fullPath});

                setState(() {});
                _picFuture = _picDownload();
              },
              child: FutureBuilder<Uint8List?>(
                  future: _picFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      final picInMemory = snapshot.data!;
                      return MovingAvatar(picInMemory: picInMemory);
                    }
                    return const CircleAvatar(child: Text("0"));
                  }))
        ],
      ),
    );
  }
}

class MovingAvatar extends StatefulWidget {
  const MovingAvatar({
    Key? key,
    required this.picInMemory,
  }) : super(key: key);

  final Uint8List picInMemory;

  @override
  State<MovingAvatar> createState() => _MovingAvatarState();
}

class _MovingAvatarState extends State<MovingAvatar>
    with SingleTickerProviderStateMixin<MovingAvatar> {
  late Ticker _ticker;
  double yataydaKonum = 0.0;
  @override
  void initState() {
    _ticker = createTicker((Duration elapsed) {
      final aci = pi *
          elapsed.inMicroseconds /
          const Duration(seconds: 1).inMicroseconds;
      setState(() {
        yataydaKonum = sin(aci) * 30 + 30;
      });
    });
    _ticker.start();
    super.initState();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: yataydaKonum),
      child: CircleAvatar(
        backgroundImage: MemoryImage(widget.picInMemory),
      ),
    );
  }
}
