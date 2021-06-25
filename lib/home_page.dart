import 'package:flutter/material.dart';

import './about_page.dart';
import './decrypting_page.dart';
import './encrypting_page.dart';
import './history_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Şifreleme Uygulaması"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 15),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AboutPage()));
                  },
                  child: Text(
                    "Hakkımızda",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EncryptingPage()));
                  },
                  child: Text(
                    "Şifreleme",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DecryptingPage()));
                  },
                  child: Text(
                    "Şifre Çözme",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HistoryPage()));
                  },
                  child: Text(
                    "Geçmiş İşlemler",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
