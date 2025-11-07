import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_casiers/src/features/lockers/domain/locker.dart';
import 'package:logger/logger.dart';

class LockerService extends Notifier<List<Locker>> {
  final _dio = Dio(BaseOptions(baseUrl: 'http://localhost:3000'));
  final logger = Logger();

  Future<List<Locker>> fetchLockers() async {
    try {
      final res = await _dio.get('/locker');
      final datas = (res.data as List)
          .map((data) => Locker.fromJson(data))
          .toList();
      return datas;
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  Future<Locker> addLocker(Locker locker) async {
    try {
      final response = await _dio.post(
        '/locker',
        data: locker.toJson(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      return Locker.fromJson(response.data);
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  Future<void> delLocker(String id) async {
    await _dio.delete('/locker/$id');
  }

  Future<void> patchLocker(Locker locker) async {
    try {
      await _dio.patch(
        '/locker/${locker.id}',
        data: locker.toJson(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
    } catch (e) {
      logger.e(e.toString());
      return;
    }
  }

  Future<Locker> findLockerById(String id) async {
    try {
      final response = await _dio.get('/locker/$id');
      return Locker.fromJson(response.data);
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  @override
  List<Locker> build() {
    return [];
  }
}

final lockerService = NotifierProvider.autoDispose<LockerService, List<Locker>>(
  () {
    return LockerService();
  },
);
