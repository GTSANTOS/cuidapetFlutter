// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $HomeController = BindInject(
  (i) => HomeController(
      i<EnderecoService>(), i<CategoriaService>(), i<FornecedorService>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$enderecoSelecionadoAtom =
      Atom(name: '_HomeControllerBase.enderecoSelecionado');

  @override
  EnderecoModel get enderecoSelecionado {
    _$enderecoSelecionadoAtom.reportRead();
    return super.enderecoSelecionado;
  }

  @override
  set enderecoSelecionado(EnderecoModel value) {
    _$enderecoSelecionadoAtom.reportWrite(value, super.enderecoSelecionado, () {
      super.enderecoSelecionado = value;
    });
  }

  final _$categoriaFutureAtom =
      Atom(name: '_HomeControllerBase.categoriaFuture');

  @override
  ObservableFuture<List<CategoriaModel>> get categoriaFuture {
    _$categoriaFutureAtom.reportRead();
    return super.categoriaFuture;
  }

  @override
  set categoriaFuture(ObservableFuture<List<CategoriaModel>> value) {
    _$categoriaFutureAtom.reportWrite(value, super.categoriaFuture, () {
      super.categoriaFuture = value;
    });
  }

  final _$estabelecimentosFutureAtom =
      Atom(name: '_HomeControllerBase.estabelecimentosFuture');

  @override
  ObservableFuture<List<FornecedorBuscaModel>> get estabelecimentosFuture {
    _$estabelecimentosFutureAtom.reportRead();
    return super.estabelecimentosFuture;
  }

  @override
  set estabelecimentosFuture(
      ObservableFuture<List<FornecedorBuscaModel>> value) {
    _$estabelecimentosFutureAtom
        .reportWrite(value, super.estabelecimentosFuture, () {
      super.estabelecimentosFuture = value;
    });
  }

  final _$paginaSelecionadaAtom =
      Atom(name: '_HomeControllerBase.paginaSelecionada');

  @override
  int get paginaSelecionada {
    _$paginaSelecionadaAtom.reportRead();
    return super.paginaSelecionada;
  }

  @override
  set paginaSelecionada(int value) {
    _$paginaSelecionadaAtom.reportWrite(value, super.paginaSelecionada, () {
      super.paginaSelecionada = value;
    });
  }

  final _$categoriaSelecionadaAtom =
      Atom(name: '_HomeControllerBase.categoriaSelecionada');

  @override
  int get categoriaSelecionada {
    _$categoriaSelecionadaAtom.reportRead();
    return super.categoriaSelecionada;
  }

  @override
  set categoriaSelecionada(int value) {
    _$categoriaSelecionadaAtom.reportWrite(value, super.categoriaSelecionada,
        () {
      super.categoriaSelecionada = value;
    });
  }

  final _$initPageAsyncAction = AsyncAction('_HomeControllerBase.initPage');

  @override
  Future<void> initPage() {
    return _$initPageAsyncAction.run(() => super.initPage());
  }

  final _$recuperarEnderecoSelecionadoAsyncAction =
      AsyncAction('_HomeControllerBase.recuperarEnderecoSelecionado');

  @override
  Future<void> recuperarEnderecoSelecionado() {
    return _$recuperarEnderecoSelecionadoAsyncAction
        .run(() => super.recuperarEnderecoSelecionado());
  }

  final _$temEnderecoCadastradoAsyncAction =
      AsyncAction('_HomeControllerBase.temEnderecoCadastrado');

  @override
  Future<void> temEnderecoCadastrado() {
    return _$temEnderecoCadastradoAsyncAction
        .run(() => super.temEnderecoCadastrado());
  }

  final _$buscarEstabelecimentosAsyncAction =
      AsyncAction('_HomeControllerBase.buscarEstabelecimentos');

  @override
  Future<void> buscarEstabelecimentos() {
    return _$buscarEstabelecimentosAsyncAction
        .run(() => super.buscarEstabelecimentos());
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  void alterarPaginaSelecionada(int pagina) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.alterarPaginaSelecionada');
    try {
      return super.alterarPaginaSelecionada(pagina);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void buscarCategorias() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.buscarCategorias');
    try {
      return super.buscarCategorias();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filtrarPorCategoria(int id) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.filtrarPorCategoria');
    try {
      return super.filtrarPorCategoria(id);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filtrarEstabelecimentoPorNome() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.filtrarEstabelecimentoPorNome');
    try {
      return super.filtrarEstabelecimentoPorNome();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _filtrarEstabelecimentos() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase._filtrarEstabelecimentos');
    try {
      return super._filtrarEstabelecimentos();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
enderecoSelecionado: ${enderecoSelecionado},
categoriaFuture: ${categoriaFuture},
estabelecimentosFuture: ${estabelecimentosFuture},
paginaSelecionada: ${paginaSelecionada},
categoriaSelecionada: ${categoriaSelecionada}
    ''';
  }
}
