import 'package:flutter/material.dart';
import 'package:sifreleme_uygulama/register_page.dart';

import './login_page.dart';
import './variables.dart' as v;

void main() {
  runApp(SifrelemeApp());
}

class SifrelemeApp extends StatelessWidget {
  bool checkuser() {
    return v.registered;
  }

  @override
  Widget build(BuildContext context) {
    if (checkuser()) {
      return MaterialApp(
        home: LoginPage(),
      );
    } else {
      return MaterialApp(
        home: RegisterPage(),
      );
    }
  }
}
