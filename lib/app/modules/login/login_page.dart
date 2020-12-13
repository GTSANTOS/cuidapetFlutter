import 'dart:io';

import 'package:cuidapet/app/core/dio/custom_dio.dart';
import 'package:cuidapet/app/shared/components/facebook_button.dart';
import 'package:cuidapet/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'login_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeUtils.primaryColor,
      body: Container(
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
                margin: EdgeInsets.only(
                    top: Platform.isIOS
                        ? ScreenUtil().statusBarHeight + 30
                        : ScreenUtil().statusBarHeight),
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
                obscureText: controller.obscureText,
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
                        onPressed: () => controller.mostrarSenhaUsuario())),
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
                onPressed: () => controller.login(),
                color: ThemeUtils.primaryColor,
                child: Text(
                  'Entrar',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: ThemeUtils.primaryColor,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'ou',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: ThemeUtils.primaryColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: ThemeUtils.primaryColor,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
            ),
            FacebookButton(
              onTap: () {
                controller.facebookLogin();
              },
            ),
            FlatButton(
              onPressed: () {},
              child: Text('Cadastra-se'),
            )
          ],
        ),
      ),
    );
  }
}
