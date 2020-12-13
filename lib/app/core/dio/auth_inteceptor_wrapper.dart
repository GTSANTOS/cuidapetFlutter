import 'package:dio/dio.dart';
import 'package:cuidapet/app/repository/shared_prefs_respository.dart';

class AuthInterceptorWrapper extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    final prefs = await SharedPrefsRepository.instance;
    options.headers['Authorization'] = prefs.accessToken;
  }

  @override
  Future onResponse(Response response) async {}

  @override
  Future onError(DioError err) async {}
}
