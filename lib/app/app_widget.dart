import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

import 'core/theme_cuidapet.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: Get.addKey(Modular.navigatorKey),
      title: 'Flutter Slidy',
      debugShowCheckedModeBanner: false,
      theme: ThemeCuidapet.theme(),
      initialRoute: '/',
      onGenerateRoute: Modular.generateRoute,
      navigatorObservers: [GetObserver()],
    );
  }
}
