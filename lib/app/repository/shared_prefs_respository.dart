import 'dart:convert';

import 'package:cuidapet/app/models/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cuidapet/app/models/endereco_model.dart';

class SharedPrefsRepository {
  static const _ACCESS_TOKEN = '/_ACCESS_TOKEN';
  static const _DEVICE_ID = '/_DEVICE_ID';
  static const _DADOS_USUARIO = '/_DADOS_USUARIO';
  static const _ENDERECO_SELECIONADO = '/_ENDERECO_SELECIONADO';

  static SharedPreferences prefs;
  static SharedPrefsRepository _instanceRespository;

  SharedPrefsRepository._();

  static Future<SharedPrefsRepository> get instance async {
    prefs ??= await SharedPreferences.getInstance();
    _instanceRespository ??= SharedPrefsRepository._();
    return _instanceRespository;
  }

  Future<void> registerAccessToken(String token) async {
    await prefs.setString(_ACCESS_TOKEN, token);
  }

  String get accessToken => prefs.get(_ACCESS_TOKEN);

  Future<void> registerDeviceId(String deviceId) async {
    await prefs.setString(_DEVICE_ID, deviceId);
  }

  String get deviceId => prefs.get(_DEVICE_ID);

  Future<void> registerDadosUsuario(UsuarioModel usuario) async {
    await prefs.setString(_DADOS_USUARIO, jsonEncode(usuario));
  }

  UsuarioModel get dadosUsuario {
    if (prefs.containsKey(_DADOS_USUARIO)) {
      return UsuarioModel.fromJson(jsonDecode(prefs.getString(_DADOS_USUARIO)));
    }
    return null;
  }

  Future<void> logout() async {
    await prefs.clear();
    await Modular.to.pushNamedAndRemoveUntil('/', ModalRoute.withName('/'));
  }

  Future<void> registrarEnderecoSelecionado(EnderecoModel model) async {
    await prefs.setString(_ENDERECO_SELECIONADO, model.toJson());
  }

  Future<EnderecoModel> get enderecoSelecionado async {
    var resultado = await prefs.getString(_ENDERECO_SELECIONADO);
    if (resultado != null) {
      return EnderecoModel.fromJson(resultado);
    }
    return null;
  }
}
