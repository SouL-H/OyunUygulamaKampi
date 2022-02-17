import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oudemoapp_riverpod/repository/teachers_repository.dart';
import 'package:oudemoapp_riverpod/teacher/teacher_form.dart';

import '../model/teacher.dart';

class TeachersPage extends ConsumerWidget {
  const TeachersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teachersRepository = ref.watch(teachersProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Teachers")),
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
                    child: Hero(
                        tag: 'Teachers',
                        child: Material(
                            //Eklenmediğinde kırmızıya sebep olabiliyormuş.
                            child: Container(
                                padding: const EdgeInsets.all(8.0),
                                color: Colors.grey.shade200,
                                child: Text(
                                    '${teachersRepository.teachers.length} teachers')))),
                  ),
                ),
                const Align(
                    alignment: Alignment.centerRight,
                    child: TeacherDowlandButton())
              ],
            ),
          ),
          Expanded(
              child: RefreshIndicator(
            onRefresh: () async {
              ref.refresh(teachersListProvider);
            },
            child: ref.watch(teachersListProvider).when(
                  data: (data) => ListView.separated(
                    itemCount: data.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) => TeacherLine(data[index]),
                  ),
                  error: (stackTrace, previous) {
                    //previous eski halini gösterme.
                    return const SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Text("Error"));
                  },
                  loading: () {
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final created = await Navigator.of(context)
              .push<bool>(MaterialPageRoute(builder: (context) {
            return const TeacherForm();
          }));
          if (created == true) {
            ref.refresh(teachersListProvider);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
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
