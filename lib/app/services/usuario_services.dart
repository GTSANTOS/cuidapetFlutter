import 'package:cuidapet/app/core/exceptions/cuidapet_exceptions.dart';
import 'package:cuidapet/app/repository/facebook_repository.dart';
import 'package:cuidapet/app/repository/security_storage_repository.dart';
import 'package:cuidapet/app/repository/usuario_repository.dart';
import 'package:cuidapet/app/repository/shared_prefs_respository.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cuidapet/app/models/access_token_model.dart';

class UsuarioService {
  final UsuarioRepository _repository;

  UsuarioService(this._repository);

  Future<void> login(bool facebookLogin,
      {String email, String password}) async {
    try {
      final prefs = await SharedPrefsRepository.instance;
      final fireAuth = FirebaseAuth.instance;
      AccessTokenModel accessTokenModel;

      if (!facebookLogin) {
        accessTokenModel = await _repository.login(email,
            password: password, facebookLogin: facebookLogin, avatar: '');
        await fireAuth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        var facebookModel = await FacebookRepository().login();
        if (facebookModel != null) {
          accessTokenModel = await _repository.login(facebookModel.email,
              password: password,
              facebookLogin: facebookLogin,
              avatar: facebookModel.picture);
          final facebookCredencial = FacebookAuthProvider.getCredential(
              accessToken: facebookModel.token);
          await fireAuth.signInWithCredential(facebookCredencial);
        } else {
          throw AcessoNegadoException('Acesso Negado');
        }
      }

      prefs.registerAccessToken(accessTokenModel.accessToken);
      final confirmModel = await _repository.confirmLogin();
      prefs.registerAccessToken(confirmModel.accessToken);
      SecurityStorageRepository()
          .registerRefreshToken(confirmModel.refreshToken);
    } on PlatformException catch (e) {
      print('Erro ao fazer login no firebase $e');
      rethrow;
    } on DioError catch (e) {
      if (e.response.statusCode == 403) {
        throw AcessoNegadoException(e.response.data['message'], exception: e);
      }
      print('DioError $e');
      rethrow;
    } catch (e) {
      print('Erro ao fazer login $e');
      rethrow;
    }
  }
}
