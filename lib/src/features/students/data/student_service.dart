import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/features/students/domain/student.dart';
import 'package:logger/logger.dart';

class StudentService extends Notifier<List<Student>> {
  final _dio = Dio(BaseOptions(baseUrl: 'http://localhost:3000'));
  final logger = Logger();

  Future<List<Student>> fetchStudents() async {
    try {
      final res = await _dio.get('/student');
      return (res.data as List).map((data) => Student.fromJson(data)).toList();
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  Future<Student> addStudent(Student student) async {
    try {
      final res = await _dio.post(
        '/student',
        data: student.toJson(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      return Student.fromJson(res.data);
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  Future<void> delStudent(String id) async {
    await _dio.delete('/student/$id');
  }

  Future<void> patchStudent(Student student) async {
    try {
      await _dio.patch(
        '/student/${student.id}',
        data: student.toJson(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  Future<Student?> findStudentById(String? id) async {
    if (id == null || id.isEmpty) {
      return null;
    }

    try {
      final res = await _dio.get('/student/$id');
      return Student.fromJson(res.data);
    } catch (e) {
      logger.e(e.toString());
      return null;
    }
  }

  Future<Student?> findStudentByName(String firstName, String lastName) async {
    try {
      final response = await _dio.get(
        '/student/search',
        queryParameters: {'firstName': firstName, 'lastName': lastName},
      );
      if (response.data == null) return null;
      return Student.fromJson(response.data);
    } catch (e) {
      logger.e(e.toString());
      return null;
    }
  }

  @override
  List<Student> build() {
    return [];
  }
}

final studentService =
    NotifierProvider.autoDispose<StudentService, List<Student>>(() {
      return StudentService();
    });

