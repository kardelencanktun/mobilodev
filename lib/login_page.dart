import 'package:flutter/material.dart';

import 'giris_stateful.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("Şifreleme Uygulaması Giriş"),
          backgroundColor: Colors.blue,
        ),
        body: Giris());
  }
}
