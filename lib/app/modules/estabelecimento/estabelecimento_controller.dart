import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'estabelecimento_controller.g.dart';

@Injectable()
class EstabelecimentoController = _EstabelecimentoControllerBase
    with _$EstabelecimentoController;

abstract class _EstabelecimentoControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
