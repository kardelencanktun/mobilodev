import 'package:flutter/material.dart';

import './home_page.dart';
import 'variables.dart' as v;

class Giris extends StatefulWidget {
  @override
  _GirisState createState() => _GirisState();
}

class _GirisState extends State<Giris> {
  final String _username = v.unamedb;
  final String _password = v.passdb;
  bool _usernameDogru = false;
  bool _passwordDogru = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Kullanıcı Adı Giriniz...'),
            onChanged: (text) {
              text == _username
                  ? _usernameDogru = true
                  : _usernameDogru = false;
            },
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
                border: UnderlineInputBorder(), labelText: 'Parola Giriniz...'),
            onChanged: (text) {
              text == _password
                  ? _passwordDogru = true
                  : _passwordDogru = false;
            },
          ),
          SizedBox(
            height: 30,
          ),
          TextButton(
            onPressed: () {
              if (_usernameDogru && _passwordDogru) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                      title: Center(child: Text("Hatalı Parola")),
                      actions: <Widget>[
                        // usually buttons at the bottom of the dialog
                        TextButton(
                          child: Text("Tamam"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue)),
            child: Text(
              "Giriş Yap",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
