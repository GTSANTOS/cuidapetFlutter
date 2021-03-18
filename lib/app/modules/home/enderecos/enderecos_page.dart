import 'package:cuidapet/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:cuidapet/app/models/endereco_model.dart';
import 'package:google_maps_webservice/places.dart';
import 'enderecos_controller.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';

class EnderecosPage extends StatefulWidget {
  final String title;
  const EnderecosPage({Key key, this.title = "Enderecos"}) : super(key: key);

  @override
  _EnderecosPageState createState() => _EnderecosPageState();
}

class _EnderecosPageState
    extends ModularState<EnderecosPage, EnderecosController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
    controller.buscarEnderecosCadastrados();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var enderecoSelecionado = await controller.enderecoFoiSelecionado();
        if (enderecoSelecionado) {
          return true;
        } else {
          Get.snackbar('Erro', 'por favor selecione um endereço');
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Text('Adicione ou escolha um endereço',
                    style: ThemeUtils.theme.textTheme.headline5.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(20),
                    child: TypeAheadField(
                        textFieldConfiguration: TextFieldConfiguration(
                          focusNode: controller.enderecoFocusNode,
                          controller: controller.enderecoTextController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: Colors.black,
                            ),
                            hintText: 'Insira um endereço',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                              ),
                            ),
                          ),
                        ),
                        onSuggestionSelected: (Prediction suggestion) {
                          controller.enderecoTextController.text =
                              suggestion.description;
                          controller.enviarDetalhe(suggestion);
                        },
                        itemBuilder:
                            (BuildContext context, Prediction itemData) {
                          return ListTile(
                            leading: Icon(Icons.location_on),
                            title: Text(itemData.description),
                          );
                        },
                        suggestionsCallback: (String pattern) async {
                          return await controller.buscarEnderecos(pattern);
                        }),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  onTap: () => controller.minhaLocalizacao(),
                  leading: CircleAvatar(
                    child: Icon(
                      Icons.near_me,
                      color: Colors.white,
                    ),
                    radius: 30,
                    backgroundColor: Colors.red,
                  ),
                  title: Text('Localização Atual'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                SizedBox(
                  height: 10,
                ),
                Observer(builder: (_) {
                  return FutureBuilder<List<EnderecoModel>>(
                      future: controller.enderecosFuture,
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
                            if (snapshot.hasData) {
                              var data = snapshot.data;
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: data.length,
                                itemBuilder: (context, index) =>
                                    _buildItemEndereco(data[index]),
                              );
                            }

                            break;
                          default:
                            return Container();
                        }
                      });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildItemEndereco(EnderecoModel model) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        onTap: () => controller.selecionarEndereco(model),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.location_on,
            color: Colors.black,
          ),
        ),
        title: Text(model.endereco),
        subtitle: Text(model.complemento),
      ),
    );
  }
}
