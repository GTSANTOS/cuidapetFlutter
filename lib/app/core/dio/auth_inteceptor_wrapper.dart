import 'package:cuidapet/app/core/dio/custom_dio.dart';
import 'package:cuidapet/app/repository/security_storage_repository.dart';
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
  Future onError(DioError err) async {
    if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
      await _refreshToken();
      print('Token Atualizado');
      final req = err.request;
      return CustomDio.authInstance.request(req.path, options: req);
    }
    return err;
  }

  Future<void> _refreshToken() async {
    final prefs = await SharedPrefsRepository.instance;
    final security = SecurityStorageRepository();

    try {
      final refreshToken = await security.refreshToken;
      final accessToken = prefs.accessToken;
      var refreshResult = await CustomDio.instance.put(
        '/login/refresh',
        data: {'token': accessToken, 'refresh_Token': refreshToken},
      );
      await prefs.registerAccessToken(refreshResult.data['accessToken']);
      await security.registerRefreshToken(refreshResult.data['refresh_Token']);
    } catch (e) {
      await prefs.logout();
    }
  }
}
