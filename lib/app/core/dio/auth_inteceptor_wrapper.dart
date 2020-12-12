import 'package:dio/dio.dart';

class AuthInterceptorWrapper extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {}

  @override
  Future onResponse(Response response) async {}

  @override
  Future onError(DioError err) async {}
}
