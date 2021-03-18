import 'package:cuidapet/app/models/categoria_model.dart';
import 'package:cuidapet/app/models/fornecedor_busca_model.dart';
import 'package:cuidapet/app/services/fornecedor_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:cuidapet/app/models/endereco_model.dart';
import 'package:cuidapet/app/repository/shared_prefs_respository.dart';
import 'package:cuidapet/app/services/categoria_service.dart';
import 'package:cuidapet/app/services/endereco_services.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final EnderecoService _enderecoService;
  final CategoriaService _categoriaService;
  final FornecedorService _fornecedorService;
  final TextEditingController filtroNomeController = TextEditingController();

  @observable
  EnderecoModel enderecoSelecionado;

  @observable
  ObservableFuture<List<CategoriaModel>> categoriaFuture;

  @observable
  ObservableFuture<List<FornecedorBuscaModel>> estabelecimentosFuture;

  List<FornecedorBuscaModel> estabelecimentosOriginais;

  @observable
  int paginaSelecionada = 0;

  @observable
  int categoriaSelecionada;

  _HomeControllerBase(
      this._enderecoService, this._categoriaService, this._fornecedorService);

  @action
  void alterarPaginaSelecionada(int pagina) => paginaSelecionada = pagina;

  @action
  Future<void> initPage() async {
    await temEnderecoCadastrado();
    await recuperarEnderecoSelecionado();
    buscarCategorias();
    await buscarEstabelecimentos();
  }

  @action
  Future<void> recuperarEnderecoSelecionado() async {
    var prefs = await SharedPrefsRepository.instance;
    enderecoSelecionado = await prefs.enderecoSelecionado;
  }

  @action
  Future<void> temEnderecoCadastrado() async {
    var temEndereco = await _enderecoService.existeEnderecoCadastrado();
    if (!temEndereco) {
      await Modular.link.pushNamed('/enderecos');
    }
  }

  @action
  void buscarCategorias() {
    categoriaFuture = ObservableFuture(_categoriaService.buscarCategorias());
  }

  @action
  Future<void> buscarEstabelecimentos() async {
    categoriaSelecionada = null;
    filtroNomeController.text = '';
    if (enderecoSelecionado != null) {
      estabelecimentosFuture = ObservableFuture(
          _fornecedorService.buscarFornecedoresProximos(enderecoSelecionado));
    }
    estabelecimentosOriginais = await estabelecimentosFuture;
  }

  @action
  void filtrarPorCategoria(int id) {
    if (categoriaSelecionada == id) {
      categoriaSelecionada = null;
    } else {
      categoriaSelecionada = id;
    }
    _filtrarEstabelecimentos();
  }

  @action
  void filtrarEstabelecimentoPorNome() {
    _filtrarEstabelecimentos();
  }

  @action
  void _filtrarEstabelecimentos() {
    var fornecedores = estabelecimentosOriginais;
    if (categoriaSelecionada != null) {
      fornecedores = fornecedores
          .where((e) => e.categoria.id == categoriaSelecionada)
          .toList();
    }
    if (filtroNomeController.text.isNotEmpty) {
      fornecedores = fornecedores
          .where((e) => e.nome
              .toLowerCase()
              .contains(filtroNomeController.text.toLowerCase()))
          .toList();
    }
    estabelecimentosFuture = ObservableFuture(Future.value(fornecedores));
  }
}
