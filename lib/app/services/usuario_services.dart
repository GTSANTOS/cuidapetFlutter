import 'dart:html';

import 'package:cuidapet/app/repository/usuario_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class UsuarioService {
  final UsuarioRepository _repository;

  UsuarioService(this._repository);

  void login(String email,
      {String password, bool facebookLogin = false, String avatar = ''}) async {
    try {
      final accessTokenModel = await _repository.login(email,
          password: password, facebookLogin: facebookLogin, avatar: avatar);

      if (!facebookLogin) {
        var resultado = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
      }
    } on PlatformException catch (e) {
      print('Erro ao fazer login no firebase $e');
      rethrow;
    } catch (e) {
      print('Erro ao fazer login $e');
      rethrow;
    }
  }
}
