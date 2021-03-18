import 'package:cuidapet/app/models/categoria_model.dart';
import 'package:cuidapet/app/models/fornecedor_busca_model.dart';
import 'package:cuidapet/app/modules/home/components/home_appbar.dart';
import 'package:cuidapet/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  var appBar;
  final categoriaIcons = {
    'P': Icons.pets,
    'V': Icons.local_hospital,
    'C': Icons.store_mall_directory
  };
  final _estabelecimentoPageController = PageController(initialPage: 0);

  _HomePageState() {
    appBar = HomeAppBar(controller);
  }

  @override
  void initState() {
    super.initState();
    controller.initPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      backgroundColor: Colors.grey[100],
      appBar: appBar,
      body: RefreshIndicator(
        onRefresh: () => controller.buscarEstabelecimentos(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            width: ScreenUtil().screenWidth,
            height: ScreenUtil().screenHeight -
                (appBar.preferredSize.height + ScreenUtil().statusBarHeight),
            child: Column(
              children: <Widget>[
                _buildEndereco(),
                _buildCategorias(),
                Expanded(child: _buildEstabelecimentos())
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEndereco() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text('Estabeleciemntos próximos de '),
          Observer(builder: (_) {
            return Text(
              controller.enderecoSelecionado?.endereco ?? '',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            );
          })
        ],
      ),
    );
  }

  Widget _buildCategorias() {
    return Observer(builder: (_) {
      return FutureBuilder<List<CategoriaModel>>(
        future: controller.categoriaFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();
              break;
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(child: Text('Erro ao buscar Catergorias'));
              }
              if (snapshot.hasData) {
                var data = snapshot.data;
                return Container(
                  height: 130,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var cat = data[index];
                        return InkWell(
                          onTap: () => controller.filtrarPorCategoria(cat.id),
                          child: Container(
                            margin: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Observer(builder: (_) {
                                  return CircleAvatar(
                                    backgroundColor:
                                        controller.categoriaSelecionada ==
                                                cat.id
                                            ? ThemeUtils.primaryColor
                                            : ThemeUtils.primaryColorLight,
                                    child: Icon(
                                      categoriaIcons[cat.tipo],
                                      size: 30,
                                      color: Colors.black,
                                    ),
                                    radius: 30,
                                  );
                                }),
                                SizedBox(height: 10),
                                Text(cat.nome),
                              ],
                            ),
                          ),
                        );
                      }),
                );
              } else {
                return Container();
              }
              break;
            default:
              return Container();
          }
        },
      );
    });
  }

  Widget _buildEstabelecimentos() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Observer(builder: (_) {
            return Row(
              children: [
                Text('Estabeleciemntos'),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      _estabelecimentoPageController.previousPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.ease);
                    },
                    child: Icon(
                      Icons.view_headline,
                      color: controller.paginaSelecionada == 0
                          ? Colors.black
                          : Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      _estabelecimentoPageController.nextPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.ease);
                    },
                    child: Icon(
                      Icons.view_comfy,
                      color: controller.paginaSelecionada == 1
                          ? Colors.black
                          : Colors.grey,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
        Expanded(
          child: PageView(
            onPageChanged: (pagina) =>
                controller.alterarPaginaSelecionada(pagina),
            physics: NeverScrollableScrollPhysics(),
            controller: _estabelecimentoPageController,
            children: [
              _buildEstabelecimentosLista(),
              _buildEstabelecimentosGrid(),
            ],
          ),
        )
      ],
    );
  }

  _buildEstabelecimentosLista() {
    return Observer(builder: (_) {
      return FutureBuilder<List<FornecedorBuscaModel>>(
        future: controller.estabelecimentosFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();
              break;
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(child: Text('Erro ao buscar estabelecimentos'));
              }
              if (snapshot.hasData) {
                var fornecs = snapshot.data;
                return ListView.separated(
                  itemCount: fornecs.length,
                  separatorBuilder: (_, index) => Divider(
                    color: Colors.transparent,
                  ),
                  itemBuilder: (context, index) {
                    var fornec = fornecs[index];
                    return InkWell(
                      onTap: () =>
                          Modular.to.pushNamed('/estabelecimento/${fornec.id}'),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 30),
                              width: ScreenUtil().screenWidth,
                              height: 80,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 50),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(fornec.nome),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 16,
                                              color: Colors.grey[500],
                                            ),
                                            Text(
                                                '${fornec.distancia.toStringAsFixed(2)} km de distância')
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: CircleAvatar(
                                      backgroundColor: ThemeUtils.primaryColor,
                                      maxRadius: 15,
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.transparent, width: 1),
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey[100], width: 5),
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(100),
                                  image: DecorationImage(
                                    image: NetworkImage(fornec.logo),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Container();
              }
              break;
            default:
              return Container();
          }
        },
      );
    });
  }

  _buildEstabelecimentosGrid() {
    return Observer(builder: (_) {
      return FutureBuilder<List<FornecedorBuscaModel>>(
        future: controller.estabelecimentosFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();
              break;
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(child: Text('Erro ao buscar estabelecimentos'));
              }
              if (snapshot.hasData) {
                var fornecs = snapshot.data;
                return GridView.builder(
                  itemCount: fornecs.length,
                  itemBuilder: (context, index) {
                    var fornec = fornecs[index];
                    return InkWell(
                      onTap: () =>
                          Modular.to.pushNamed('/estabelecimento/${fornec.id}'),
                      child: Stack(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            margin:
                                EdgeInsets.only(top: 40, left: 10, right: 10),
                            elevation: 5,
                            child: Container(
                              width: double.infinity,
                              height: 120,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 40.0, bottom: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      fornec.nome,
                                      style:
                                          ThemeUtils.theme.textTheme.subtitle2,
                                    ),
                                    Text(
                                        '${fornec.distancia.toStringAsFixed(2)} km de distância'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            right: 0,
                            child: Center(
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey[200],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 4,
                            right: 0,
                            child: Center(
                              child: CircleAvatar(
                                radius: 35,
                                backgroundImage: NetworkImage(fornec.logo),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                  ),
                );
              } else {
                return Container();
              }
              break;
            default:
              return Container();
          }
        },
      );
    });
  }
}
