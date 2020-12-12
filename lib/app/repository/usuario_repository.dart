import 'package:cuidapet/app/core/dio/custom_dio.dart';
import 'package:cuidapet/app/models/access_token_model.dart';

class UsuarioRepository {
  Future<AccessTokenModel> login(String email,
      {String password, bool facebookLogin = false, String avatar = ''}) async {
    return CustomDio.instance.post('/login', data: {
      'email': email,
      'senha': password,
      'facebookLogin': facebookLogin,
      'avatar': avatar
    }).then((value) => AccessTokenModel.fromJson(value.data));
  }
}
