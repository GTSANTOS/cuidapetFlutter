import 'dart:io';

import 'package:cuidapet/app/core/dio/custom_dio.dart';
import 'package:cuidapet/app/models/access_token_model.dart';
import 'package:cuidapet/app/models/confirm_login_model.dart';
import 'package:cuidapet/app/repository/shared_prefs_respository.dart';

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

  Future<ConfirmLoginModel> confirmLogin() async {
    final prefs = await SharedPrefsRepository.instance;
    final deviceId = prefs.deviceId;
    return CustomDio.instance.patch('/login/confirmar', data: {
      'ios_token': Platform.isIOS ? deviceId : null,
      'android_token': Platform.isAndroid ? deviceId : null
    }).then((value) => ConfirmLoginModel.fromJson(value.data));
  }
}
