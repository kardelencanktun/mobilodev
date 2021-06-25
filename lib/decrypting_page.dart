import 'package:flutter/material.dart';

import 'decrypting_stateful.dart';

class DecryptingPage extends StatelessWidget {
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
