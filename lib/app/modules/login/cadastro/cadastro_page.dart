import 'dart:io';

import 'package:cuidapet/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'cadastro_controller.dart';

class CadastroPage extends StatefulWidget {
  final String title;
  const CadastroPage({Key key, this.title = "Cadastro"}) : super(key: key);

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState
    extends ModularState<CadastroPage, CadastroController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Cadastrar Usuário')),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: ThemeUtils.primaryColor,
      body: SingleChildScrollView(
        child: Container(
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenHeight,
          child: Stack(
            children: <Widget>[
              Container(
                width: ScreenUtil().screenWidth,
                height: ScreenUtil().screenHeight < 700
                    ? 800
                    : ScreenUtil().screenHeight * .95,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                            'lib/assets/images/login_background.png'))),
              ),
              Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Image.asset(
                        'lib/assets/images/logo.png',
                        width: ScreenUtil().setWidth(400),
                        fit: BoxFit.fill,
                      ),
                      _buildForm(),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            TextFormField(
              controller: controller.loginController,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Login Obrigatório';
                } else if (!value.contains('@')) {
                  return 'Email inválido';
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: 'Login',
                  labelStyle: TextStyle(fontSize: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    gapPadding: 0,
                  )),
            ),
            SizedBox(height: 20),
            Observer(builder: (_) {
              return TextFormField(
                obscureText: controller.esconderSenha,
                controller: controller.senhaController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Senha Obrigatória';
                  } else if (value.length < 6) {
                    return 'Senha deve ter mais de 6 caracteres';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: 'Senha',
                    labelStyle: TextStyle(fontSize: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      gapPadding: 0,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.lock),
                      onPressed: () => controller.mostrarSenha(),
                    )),
              );
            }),
            SizedBox(height: 20),
            Observer(builder: (_) {
              return TextFormField(
                obscureText: controller.esconderConfirmaSenha,
                controller: controller.confirmaSenhaController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Confirma Senha Obrigatória';
                  } else if (value.length < 6) {
                    return 'Confirma Senha deve ter mais de 6 caracteres';
                  } else if (value != controller.senhaController.text) {
                    return 'Senha e confirma senha diferentes!';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: 'Confirmar Senha',
                    labelStyle: TextStyle(fontSize: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      gapPadding: 0,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.lock),
                      onPressed: () => controller.mostrarConfirmaSenha(),
                    )),
              );
            }),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              height: 60,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () => controller.cadastrarUsuario(),
                color: ThemeUtils.primaryColor,
                child: Text(
                  'Cadastrar',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
