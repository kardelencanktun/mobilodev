import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Hakkımızda"),
      ),
      body: Center(
        child: Text(
            "Bu uygulama Dr. Öğretim Üyesi Ahmet Cevahir ÇINAR tarafından yürütülen 3301456 kodlu MOBİL PROGRAMLAMA dersi kapsamında 173301011 numaralı Kardelen CAN tarafından 30 Nisan 2021 günü yapılmıştır."),
      ),
    );
  }
}
