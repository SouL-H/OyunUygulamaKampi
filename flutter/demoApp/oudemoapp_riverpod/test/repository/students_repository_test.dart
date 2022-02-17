import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:oudemoapp_riverpod/model/student.dart';
import 'package:oudemoapp_riverpod/repository/students_repository.dart';

void main() {
  test('DidLike ?', () {
    final studentsRepository = StudentsRepository();
    final newStudent = Student('testName', 'testSurname', 21, "Woman");
    studentsRepository.didLike(newStudent);
    expect(studentsRepository.didLike(newStudent), false); //counter.value diğerine eşit olmasını bekliyor.
    studentsRepository.love(newStudent,true);
    expect(studentsRepository.didLike(newStudent), true);
    studentsRepository.love(newStudent,false);
    expect(studentsRepository.didLike(newStudent), false);
  });
}
