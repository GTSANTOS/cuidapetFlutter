import 'package:flutter/material.dart';

class MainPagePage extends StatelessWidget {
  MainPagePage() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teste2'),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
