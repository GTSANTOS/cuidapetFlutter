import 'package:cuidapet/app/models/endereco_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:mobx/mobx.dart';
import 'package:cuidapet/app/shared/components/loader.dart';
import 'package:get/get.dart';
import 'package:cuidapet/app/repository/shared_prefs_respository.dart';

import 'package:cuidapet/app/services/endereco_services.dart';

part 'enderecos_controller.g.dart';

@Injectable()
class EnderecosController = _EnderecosControllerBase with _$EnderecosController;

abstract class _EnderecosControllerBase with Store {
  final EnderecoService _enderecoService;
  TextEditingController enderecoTextController = TextEditingController();
  FocusNode enderecoFocusNode = FocusNode();

  @observable
  ObservableFuture<List<EnderecoModel>> enderecosFuture;

  _EnderecosControllerBase(
    this._enderecoService,
  );

  Future<List<Prediction>> buscarEnderecos(String endereco) {
    return _enderecoService.buscarEnderecoGooglePlaces(endereco);
  }

  @action
  Future<void> enviarDetalhe(Prediction pred) async {
    Loader.show();
    var resultado = await _enderecoService
        .recuperarDetahesEnderecoGooglePlaces(pred.placeId);
    var detalhe = resultado.result;
    var enderecoModel = EnderecoModel(
        id: null,
        endereco: detalhe.formattedAddress,
        latitude: detalhe.geometry.location.lat,
        longitude: detalhe.geometry.location.lng,
        complemento: null);
    Loader.hide();
    var enderecoEdicao = await Modular.link
        .pushNamed('/detalhe', arguments: enderecoModel) as EnderecoModel;
    verificaEdicaoEndereco(enderecoEdicao);
  }

  @action
  Future<void> minhaLocalizacao() async {
    Loader.show();
    var pos = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var placemark = await Geolocator().placemarkFromPosition(pos);
    var place = placemark[0];
    var endereco = '${place.thoroughfare} ${place.subThoroughfare}';
    var enderecoModel = EnderecoModel(
        id: null,
        endereco: endereco,
        latitude: pos.latitude,
        longitude: pos.longitude,
        complemento: null);
    Loader.hide();
    var enderecoEdicao = await Modular.link
        .pushNamed('/detalhe', arguments: enderecoModel) as EnderecoModel;
    verificaEdicaoEndereco(enderecoEdicao);
  }

  @action
  void verificaEdicaoEndereco(EnderecoModel enderecoEdicao) {
    if (enderecoEdicao == null) {
      buscarEnderecosCadastrados();
      enderecoTextController.text = '';
    } else {
      enderecoTextController.text = enderecoEdicao.endereco;
      enderecoFocusNode.requestFocus();
    }
  }

  @action
  void buscarEnderecosCadastrados() {
    enderecosFuture =
        ObservableFuture(_enderecoService.buscarEnderecosCadastrados());
  }

  @action
  Future<void> selecionarEndereco(EnderecoModel model) async {
    var prefs = await SharedPrefsRepository.instance;
    await prefs.registrarEnderecoSelecionado(model);
    Modular.to.pop();
  }

  Future<bool> enderecoFoiSelecionado() async {
    var prefs = await SharedPrefsRepository.instance;
    return await prefs.enderecoSelecionado != null;
  }
}
