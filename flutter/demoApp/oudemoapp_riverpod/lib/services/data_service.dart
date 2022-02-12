import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oudemoapp_riverpod/model/teacher.dart';

class DataService {
  Teacher teacherDownload() {
    const j = """{
      "name": "NewName",
      "surname": "NewSurname",
      "age": 34,
      "gender": "Man"
    }""";

    final m = jsonDecode(j);
    var teacher = Teacher.fromMap(m);
    return teacher;
  }
}

final dataServiceProvider = Provider((ref) => DataService());
