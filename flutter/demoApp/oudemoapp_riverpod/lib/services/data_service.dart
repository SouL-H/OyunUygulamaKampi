import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oudemoapp_riverpod/model/teacher.dart';
import 'package:http/http.dart' as http;

class DataService {
  final String baseUrl = 'https://615d80a012571a0017207680.mockapi.io';
  Future<Teacher> teacherDownload() async {
    final response = await http.get(Uri.parse('$baseUrl/ogretmen/x'));

    if (response.statusCode == 200) {
      return Teacher.fromMap(jsonDecode(response.body));
    } else {
      throw Exception("Veriler indirilemedi hata kodu: ${response.statusCode}");
    }
    // const j = """{
    //   "name": "NewName",
    //   "surname": "NewSurname",
    //   "age": 34,
    //   "gender": "Man"
    // }""";

    // final m = jsonDecode(j);
    // var teacher = Teacher.fromMap(m);
    // return teacher;
  }
}

final dataServiceProvider = Provider((ref) => DataService());
