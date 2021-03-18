import 'package:cuidapet/app/core/exceptions/cuidapet_exceptions.dart';
import 'package:cuidapet/app/services/usuario_services.dart';
import 'package:cuidapet/app/shared/components/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'cadastro_controller.g.dart';

@Injectable()
class CadastroController = _CadastroControllerBase with _$CadastroController;

abstract class _CadastroControllerBase with Store {
  final UsuarioService _service;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmaSenhaController = TextEditingController();

  @observable
  bool esconderSenha = true;

  @observable
  bool esconderConfirmaSenha = true;

  _CadastroControllerBase(this._service);

  @action
  void mostrarSenha() {
    esconderSenha = !esconderSenha;
  }

  @action
  void mostrarConfirmaSenha() {
    esconderConfirmaSenha = !esconderConfirmaSenha;
  }

  @action
  Future<void> cadastrarUsuario() async {
    if (formKey.currentState.validate()) {
      try {
        Loader.show();
        await _service.cadastrarUsuario(
            loginController.text, senhaController.text);
        Loader.hide();
        Modular.to.pop();
      } on AcessoNegadoException catch (e) {
        Loader.hide();
        Get.snackbar('Erro', e.message);
      } catch (e) {
        Loader.hide();
        Get.snackbar('Erro', 'Erro ao realizar cadastro');
      }
    }
  }
}
