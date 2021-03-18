import 'package:cuidapet/app/models/endereco_model.dart';
import 'package:cuidapet/app/models/fornecedor_busca_model.dart';
import 'package:cuidapet/app/repository/fornecedor_repository.dart';

class FornecedorService {
  final FornecedorRepository _repository;
  FornecedorService(
    this._repository,
  );

  Future<List<FornecedorBuscaModel>> buscarFornecedoresProximos(
      EnderecoModel model) {
    return _repository.buscarFornecedoresProximos(
        model.latitude, model.longitude);
  }
}
