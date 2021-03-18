import 'package:cuidapet/app/models/categoria_model.dart';
import 'package:cuidapet/app/repository/categorias_repository.dart';

class CategoriaService {
  final CategoriaRepository _repository;
  CategoriaService(
    this._repository,
  );

  Future<List<CategoriaModel>> buscarCategorias() {
    return _repository.buscarCategorias();
  }
}
