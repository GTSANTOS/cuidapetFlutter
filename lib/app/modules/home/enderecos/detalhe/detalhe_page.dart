import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:cuidapet/app/models/endereco_model.dart';
import 'package:cuidapet/app/shared/theme_utils.dart';

import 'detalhe_controller.dart';

class DetalhePage extends StatefulWidget {
  final EnderecoModel enderecoModel;

  const DetalhePage({
    Key key,
    @required this.enderecoModel,
  }) : super(key: key);

  @override
  _DetalhePageState createState() => _DetalhePageState(this.enderecoModel);
}

class _DetalhePageState extends ModularState<DetalhePage, DetalheController> {
  final EnderecoModel model;
  Completer<GoogleMapController> _controller = Completer();

  var appBar = AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
  );

  _DetalhePageState(this.model);

  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: Container(
        width: ScreenUtil().screenWidthPx,
        height: _recuperarTamanhoTela(),
        padding: EdgeInsets.all(10),
        child: Column(children: [
          Text('Confirme seu endereço',
              style: ThemeUtils.theme.textTheme.headline5.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: 20),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(model.latitude, model.longitude),
                zoom: 16,
              ),
              markers: {
                Marker(
                    markerId: MarkerId('End'),
                    position: LatLng(model.latitude, model.longitude),
                    infoWindow: InfoWindow(title: model.endereco))
              },
              myLocationButtonEnabled: false,
            ),
          ),
          TextFormField(
            initialValue: model.endereco,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Endereço',
              suffixIcon: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => Modular.to.pop(model),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: controller.complementoTextController,
            decoration: InputDecoration(labelText: 'Complemento'),
          ),
          SizedBox(height: 20),
          Container(
            width: ScreenUtil().screenWidthPx * .9,
            height: 50,
            child: RaisedButton(
              onPressed: () => controller.salvarEndereco(model),
              child: Text(
                'Salvar',
                style: TextStyle(fontSize: 20),
              ),
              color: ThemeUtils.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
          )
        ]),
      ),
    );
  }

  _recuperarTamanhoTela() {
    var bottomBar = 0.0;

    if (Platform.isIOS) {
      bottomBar = ScreenUtil().bottomBarHeight;
    }
    return ScreenUtil().screenHeightPx -
        (ScreenUtil().statusBarHeight +
            appBar.preferredSize.height +
            bottomBar);
  }
}
