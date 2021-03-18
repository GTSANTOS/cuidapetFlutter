import 'package:cuidapet/app/modules/estabelecimento/estabelecimento_module.dart';
import 'package:cuidapet/app/repository/enderecos_repository.dart';
import 'package:cuidapet/app/repository/fornecedor_repository.dart';
import 'package:cuidapet/app/repository/usuario_repository.dart';
import 'package:cuidapet/app/services/endereco_services.dart';
import 'package:cuidapet/app/services/fornecedor_service.dart';
import 'package:cuidapet/app/services/usuario_services.dart';
import 'package:cuidapet/app/shared/auth_store.dart';

import 'app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:cuidapet/app/app_widget.dart';
import 'package:cuidapet/app/modules/home/home_module.dart';

import 'core/database/connection_adm.dart';
import 'modules/login/login_module.dart';
import 'modules/main_page/main_page.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ConnectionADM(), lazy: false),
        Bind((i) => AppController()),
        Bind((i) => UsuarioRepository()),
        Bind((i) => UsuarioService(i.get())),
        Bind((i) => EnderecoRepository()),
        Bind((i) => EnderecoService(i.get())),
        Bind((i) => FornecedorRepository()),
        Bind((i) => FornecedorService(i.get())),
        Bind((i) => AuthStore()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (context, args) => MainPage()),
        ModularRouter('/home', module: HomeModule()),
        ModularRouter('/login', module: LoginModule()),
        ModularRouter('/estabelecimento', module: EstabelecimentoModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
