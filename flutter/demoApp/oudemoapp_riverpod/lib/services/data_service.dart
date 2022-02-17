import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  }

  Future<void> teacherAdd(Teacher teacher) async {
    await FirebaseFirestore.instance
        .collection('teachers')
        .add(teacher.toMap());
  }

  Future<List<Teacher>> allTeacherGet() async {
    final querrySnapshot =
        await FirebaseFirestore.instance.collection('teachers').get();
    return querrySnapshot.docs
        .map((e) => Teacher.fromMap(e.data()))
        .toList(); //Öğretmen listesini elde ettik.

    // final response =
    //     await http.get(Uri.parse('$baseUrl/ogretmen')); //36 erkek - 39 Kadin

    // if (response.statusCode == 200) {
    //   final l = jsonDecode(response.body);
    //   return l.map<Teacher>((e) => Teacher.fromMap(e)).toList();
    // } else {
    //   throw Exception(
    //       "Veriler indirilemedi hata kod u: ${response.statusCode}");
    // }
  }
}

final dataServiceProvider = Provider((ref) => DataService());
