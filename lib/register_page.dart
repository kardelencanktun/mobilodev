import 'package:flutter/material.dart';

import './register_stateful.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Kullanıcı Kayıt Ekranı"),
          backgroundColor: Colors.blue,
        ),
        body: Register());
  }
}
