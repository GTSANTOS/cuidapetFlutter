import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:cuidapet/app/services/endereco_services.dart';
import 'package:cuidapet/app/models/endereco_model.dart';
import 'package:cuidapet/app/shared/components/loader.dart';
import 'package:get/get.dart';

part 'detalhe_controller.g.dart';

@Injectable()
class DetalheController = _DetalheControllerBase with _$DetalheController;

abstract class _DetalheControllerBase with Store {
  final EnderecoService _service;
  TextEditingController complementoTextController = TextEditingController();

  _DetalheControllerBase(this._service);

  Future<void> salvarEndereco(EnderecoModel model) async {
    try {
      Loader.show();
      model.complemento = complementoTextController.text;
      await _service.salvarEndereco(model);
      Loader.hide();
      Modular.to.pop();
    } catch (e) {
      Loader.hide();
      Get.snackbar('Erro', 'Erro ao salvar endereço');
    }
  }
}
