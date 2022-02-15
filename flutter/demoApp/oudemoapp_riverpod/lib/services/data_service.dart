import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oudemoapp_riverpod/model/teacher.dart';
import 'package:http/http.dart' as http;

class DataService {
  final String baseUrl = 'https://615d80a012571a0017207680.mockapi.io';
  Future<Teacher> teacherDownload() async {
    final response =
        await http.get(Uri.parse('$baseUrl/ogretmen/43')); //36 erkek - 39 Kadin

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

  Future<void> teacherAdd(Teacher teacher) async {
    final response = await http.post(
      Uri.parse('$baseUrl/ogretmen'),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8',
      },
      body: jsonEncode(teacher.toMap()),
    );
    if (response.statusCode == 201) {
      return;
    } else {
      throw Exception('Teacher not creted error: ${response.statusCode}');
    }
  }

  Future<List<Teacher>> allTeacherGet() async {
    final response =
        await http.get(Uri.parse('$baseUrl/ogretmen')); //36 erkek - 39 Kadin

    if (response.statusCode == 200) {
      final l = jsonDecode(response.body);
      return l.map<Teacher>((e) => Teacher.fromMap(e)).toList();
    } else {
      throw Exception(
          "Veriler indirilemedi hata kod u: ${response.statusCode}");
    }
  }
}

final dataServiceProvider = Provider((ref) => DataService());
