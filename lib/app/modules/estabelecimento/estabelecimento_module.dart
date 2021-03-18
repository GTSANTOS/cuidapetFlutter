import 'estabelecimento_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'estabelecimento_page.dart';

class EstabelecimentoModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $EstabelecimentoController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/:id',
            child: (_, args) => EstabelecimentoPage(
                estabelecimentoId: int.parse(args.params['id']))),
      ];

  static Inject get to => Inject<EstabelecimentoModule>.of();
}
