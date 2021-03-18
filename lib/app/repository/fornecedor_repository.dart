import 'package:cuidapet/app/core/dio/custom_dio.dart';
import 'package:cuidapet/app/models/fornecedor_busca_model.dart';

class FornecedorRepository {
  Future<List<FornecedorBuscaModel>> buscarFornecedoresProximos(
      double lat, double lng) async {
    return CustomDio.authInstance.get('/fornecedores', queryParameters: {
      'lat': lat,
      'long': lng
    }).then((value) => value.data
        .map<FornecedorBuscaModel>((c) => FornecedorBuscaModel.fromJson(c))
        .toList());
  }
}
