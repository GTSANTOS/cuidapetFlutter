import 'package:cuidapet/app/core/exceptions/cuidapet_exceptions.dart';
import 'package:cuidapet/app/services/usuario_services.dart';
import 'package:cuidapet/app/shared/components/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'login_controller.g.dart';

@Injectable()
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final UsuarioService _service;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  @observable
  bool obscureText = true;

  _LoginControllerBase(this._service);

  @action
  void mostrarSenhaUsuario() {
    obscureText = !obscureText;
  }

  @action
  Future<void> login() async {
    if (formKey.currentState.validate()) {
      try {
        Loader.show();
        await _service.login(false,
            email: loginController.text, password: senhaController.text);
        Loader.hide();
        Modular.to.pushReplacementNamed('/');
      } on AcessoNegadoException catch (e) {
        Loader.hide();
        Get.snackbar('Erro', e.message);
      } catch (e) {
        Loader.hide();
        Get.snackbar('Erro', 'Erro ao realizar login');
      }
    }
  }

  Future<void> facebookLogin() async {
    try {
      Loader.show();
      await _service.login(true);
      Loader.hide();
      Modular.to.pushReplacementNamed('/');
    } on AcessoNegadoException catch (e) {
      Loader.hide();
      Get.snackbar('Erro', e.message);
    } catch (e) {
      Loader.hide();
      Get.snackbar('Erro', 'Erro ao realizar login');
    }
  }
}
