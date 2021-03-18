import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'estabelecimento_controller.dart';

class EstabelecimentoPage extends StatefulWidget {
  final int estabelecimentoId;
  const EstabelecimentoPage({Key key, @required this.estabelecimentoId})
      : super(key: key);

  @override
  _EstabelecimentoPageState createState() => _EstabelecimentoPageState();
}

class _EstabelecimentoPageState
    extends ModularState<EstabelecimentoPage, EstabelecimentoController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estabelecimento ${widget.estabelecimentoId}'),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
