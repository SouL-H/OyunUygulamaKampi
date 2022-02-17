import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oudemoapp_riverpod/model/teacher.dart';
import 'package:oudemoapp_riverpod/services/data_service.dart';

class TeacherForm extends ConsumerStatefulWidget {
  const TeacherForm({Key? key}) : super(key: key);

  @override
  _TeacherFormState createState() => _TeacherFormState();
}

class _TeacherFormState extends ConsumerState<TeacherForm>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController =
      AnimationController(vsync: this);
  final Map<String, dynamic> entery = {};
  final _formKey = GlobalKey<FormState>();
  final aligmentTween = Tween<AlignmentGeometry>(
      begin: Alignment.centerLeft, end: Alignment.centerRight);

  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("New Teacher")),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ScaleTransition(
                      scale: animationController,
                      child: const Icon(Icons.person, size: 50)),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Name'),
                    ),
                    validator: (value) {
                      if (value?.isNotEmpty != true) {
                        return 'Name empty';
                      }
                    },
                    onSaved: (newValue) {
                      entery['ad'] = newValue;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text("Surname"),
                    ),
                    validator: (value) {
                      if (value?.isNotEmpty != true) {
                        return 'Surname emtpy';
                      }
                    },
                    onSaved: (newValue) {
                      entery['soyad'] = newValue;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text("Age"),
                    ),
                    validator: (value) {
                      if (value == null || value.isNotEmpty != true) {
                        return 'Age emtpy';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Only number';
                      }
                    },
                    keyboardType: TextInputType.number,
                    onSaved: (newValue) {
                      entery['yas'] = int.parse(newValue!);
                    },
                    onChanged: (value) {
                      final v = double.parse(value);
                      animationController.animateTo(v / 100,
                          duration: const Duration(seconds: 1));
                    },
                  ),
                  DropdownButtonFormField(
                    items: const [
                      DropdownMenuItem(child: Text('Man'), value: 'Erkek'),
                      DropdownMenuItem(child: Text('Woman'), value: 'Kadın'),
                    ],
                    onChanged: (value) {
                      setState(() {
                        entery['cinsiyet'] = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Gender emtpy';
                      }
                    },
                  ),
                  isSaving
                      ? const Center(child: const CircularProgressIndicator())
                      : AlignTransition(
                          alignment: aligmentTween.animate(animationController),
                          child: ElevatedButton(
                              onPressed: () async {
                                final formState = _formKey.currentState;
                                if (formState == null) return;
                                if (formState.validate() == true) {
                                  formState.save();
                                  print(entery);
                                }

                                _saved();
                              },
                              child: const Text('Saved')),
                        )
                ],
              )),
        )));
  }

  //TODO sunucu tarafında da problem olduğunda 503 gibi sürekli tekrarlıyor, bu problem çözülecek.
  Future<void> _saved() async {
    bool finish = false;
    int count = 3;
    while (!finish) {
      try {
        setState(() {
          isSaving = true;
        });
        await _certainSaved();
        finish = true;
        Navigator.of(context).pop(true);
      } catch (e) {
        final snackBar = ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
        await snackBar.closed;
        setState(() {
          isSaving = false;
          count -= 1;
        });
        if (count <= 0) {
          break;
        }
      } finally {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  Future<void> _certainSaved() async {
    await ref.read(dataServiceProvider).teacherAdd(Teacher.fromMap(entery));
  }
}
