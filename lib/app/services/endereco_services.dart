import 'package:cuidapet/app/repository/enderecos_repository.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:cuidapet/app/models/endereco_model.dart';
import 'package:cuidapet/app/shared/components/loader.dart';

class EnderecoService {
  final EnderecoRepository _repository;

  EnderecoService(this._repository);

  Future<bool> existeEnderecoCadastrado() async {
    return (await _repository.buscarEnderecos()).isNotEmpty;
  }

  Future<List<Prediction>> buscarEnderecoGooglePlaces(String endereco) async {
    return await _repository.buscarEnderecoGooglePlaces(endereco);
  }

  Future<void> salvarEndereco(EnderecoModel endereco) async {
    await _repository.salvarEndereco(endereco);
  }

  Future<List<EnderecoModel>> buscarEnderecosCadastrados() async {
    return _repository.buscarEnderecos();
  }

  Future<PlacesDetailsResponse> recuperarDetahesEnderecoGooglePlaces(
      String placeId) async {
    return _repository.recuperarDetahesEnderecoGooglePlaces(placeId);
  }
}
