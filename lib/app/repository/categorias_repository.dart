import 'package:cuidapet/app/core/dio/custom_dio.dart';
import 'package:cuidapet/app/models/categoria_model.dart';

class CategoriaRepository {
  Future<List<CategoriaModel>> buscarCategorias() {
    return CustomDio.authInstance.get('/categorias').then((value) => value.data
        .map<CategoriaModel>((c) => CategoriaModel.fromJson(c))
        .toList());
  }
}
