import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oudemoapp_riverpod/services/data_service.dart';

import '../model/teacher.dart';

class TeachersRepository extends ChangeNotifier {
  List<Teacher> teachers = [
    Teacher("Nikola", "Tesla", 27, "Man"),
    Teacher("Jhoon", "Wick", 34, "Man"),
    Teacher("Ketty", "Born", 32, "Woman"),
  ];
  final DataService dataService;
  TeachersRepository(this.dataService);
  Future<void> download() async {
    Teacher teacher = await dataService.teacherDownload();

    teachers.add(teacher);
    notifyListeners(); //Page reflesh
  }

  Future<List<Teacher>> allTeacher() async {
    teachers = await dataService.allTeacherGet();
    return teachers;
  }
}

final teachersProvider = ChangeNotifierProvider(
    (ref) => TeachersRepository(ref.watch(dataServiceProvider)));

final teachersListProvider =
    FutureProvider((ref) => ref.watch(teachersProvider).allTeacher());
