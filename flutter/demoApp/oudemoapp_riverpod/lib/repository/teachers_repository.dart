import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oudemoapp_riverpod/services/data_service.dart';

import '../model/teacher.dart';

class TeachersRepository extends ChangeNotifier {
  final List teachers = [
    Teacher("Nikola", "Tesla", 27, "Man"),
    Teacher("Jhoon", "Wick", 34, "Man"),
    Teacher("Ketty", "Born", 32, "Woman"),
  ];
  final DataService dataService;
  TeachersRepository(this.dataService);
  Future<void> download() async {
    Teacher teacher = await  dataService.teacherDownload();

    teachers.add(teacher);
    notifyListeners(); //Page reflesh
  }
}

final teachersProvider = ChangeNotifierProvider(
    (ref) => TeachersRepository(ref.watch(dataServiceProvider)));
