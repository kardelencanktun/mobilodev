import 'package:flutter/material.dart';

import 'encrypting_stateful.dart';

class EncryptingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Şifreleme"),
      ),
      body: Crypt(),
    );
  }
}
