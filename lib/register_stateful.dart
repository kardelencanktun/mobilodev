import 'package:flutter/material.dart';
import 'login_page.dart';
import './variables.dart' as v;

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var kadi = TextEditingController();
  var parola = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: kadi,
            decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Kullanıcı Adı Giriniz...'),
            onChanged: (text) {},
          ),
          TextFormField(
            obscureText: true,
            controller: parola,
            decoration: InputDecoration(
                border: UnderlineInputBorder(), labelText: 'Parola Giriniz...'),
            onChanged: (text) {},
          ),
          SizedBox(
            height: 30,
          ),
          TextButton(
            onPressed: () {
              if (kadi.text != "" && parola.text != "") {
                v.unamedb = kadi.text;
                v.passdb = parola.text;
                v.registered = true;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              }
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue)),
            child: Text(
              "Kayıt Ol",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
