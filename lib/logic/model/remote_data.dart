import 'package:dio/dio.dart';
import 'package:suitmedia_quest/logic/model/user.dart';

class RemoteData {
  final dio = Dio(BaseOptions(baseUrl: 'https://reqres.in/api/'));

  Future<DataUser> getDataUser() async {
    try {
      final response = await dio.get('/users');
      return DataUser.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }
}