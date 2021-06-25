import "package:encrypt/encrypt.dart";
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'variables.dart' as v;

class Crypt extends StatefulWidget {
  @override
  _CryptState createState() => _CryptState();
}

class _CryptState extends State<Crypt> {
  String sifreliMetin;
  final encodedString = TextEditingController();
  final privKeyString = TextEditingController();

  void sifreCoz(String metin) async {
    privKeyString.text = """-----BEGIN RSA PRIVATE KEY-----
MIICWwIBAAKBgQCzoN1rGpG4oIam1m2fup1ruY5enRGxF9KJtnhc2XZZoTn2mRz+
oqFJEvgN0DsfNrjpAJRModM9qHFx4u2wEZgSjHvI2IgVp0t5R2Ji/v3bwwcYKy9M
UhL6Qp24EYyi6awh8uK8BovNCM7IzWFOgBxTtOJ8oBUkko01QfIIG+uoAQIDAQAB
An8l48jQzsnuJ+4/QvvctYB/OKTPUFJrCJtgcRzyeOx9+4Q+gA2dqLBcuaOZRlMy
Qli+zWB6yafFWcKUQ0nf2dY5t86wubsSAaHrSMDCASjLIJJeVDEqPe+Gj+w3RAXw
vb8MW4l7I9T3sSRukn0CnIhGU0KT8+znTHQrAvxNFFbZAkEA+yyTC2FSEGrGqKEx
Vao0ZBegnyoWIN26Xyh+i0c1mZKYHNw363NbMIo3VLQRrnQ08OzXNXE4pxKH+ACN
s1wAjwJBALcUYq619D42YmwpSoPLIUWAFHZmbQYQbO+N+wBlopP0nE6CimC5HsTI
uMAqefnAXRIEU9CM5h3u+6zFVCyi9m8CQQD4JXqEtLppw8POl6nw8z3dYUZr2R2R
jN1y48PZgBmhRqYHZT3N3OLLmtG9WkVZsC8ZkzOu9dO9o943EvzrpUpbAkEAliv9
iiusDX/Umb4A5jwvrW+S2U/I6+l7QcBne/riMZS6xddkJFSUvXubt9zfspIshYPR
MEby1ujZve0az4ZYtwJAa00wn3MncsMiYkwmPIqIruAT5AMkTHLGhddaEFmuQ/kP
xrVrCDQlcV53PNeRoldVb2YSXu58gMeI/SOQIgKMzw==
-----END RSA PRIVATE KEY-----""";
    final privateKey = RSAKeyParser().parse(privKeyString.text);

    final encryptedText = sifreliMetin;
    final decrypter = Encrypter(RSA(privateKey: privateKey));

    final decrypted = decrypter.decrypt64(encryptedText);

    var islem = CryptoClass(
      id: 0,
      metin1: encodedString.text,
      key1: privKeyString.text,
      typecrypto: 0,
    );
    // mn();
    getinfo("add", islem);
    getinfo("list", "").then((list) => v.gecmisListesi = list);
    print(v.gecmisListesi);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Center(child: Text("Şifreli Metin")),
          content: Text("$decrypted"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: Text("Tamam"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Kopyala"),
              onPressed: () {
                Clipboard.setData(new ClipboardData(text: decrypted));
              },
            ),
          ],
        );
      },
    );
  }

  getinfo(var func, var data) async {
    // Called in every state () {}
    // Avoid errors caused by flutter upgrade.
    // Importing 'package:flutter/widgets.dart' is required.
    WidgetsFlutterBinding.ensureInitialized();
    // Open the database and store the reference.
    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      path.join(await getDatabasesPath(), v.dbname),
      // When the database is first created, create a table to store cryptos.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE cryptos(id INTEGER PRIMARY KEY, metin1 TEXT, key1 TEXT, typecrypto INTEGER)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );

    // Define a function that inserts cryptos into the database
    Future<void> insertdb(CryptoClass dog) async {
      // Get a reference to the database.
      final db = await database;

      // Insert the Dog into the correct table. You might also specify the
      // `conflictAlgorithm` to use in case the same dog is inserted twice.
      //
      // In this case, replace any previous data.
      await db.insert(
        'cryptos',
        dog.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    // A method that retrieves all the cryptos from the cryptos table.
    Future<List<CryptoClass>> cryptosdb() async {
      // Get a reference to the database.
      final db = await database;

      // Query the table for all The cryptos.
      final List<Map<String, dynamic>> maps = await db.query('cryptos');

      // Convert the List<Map<String, dynamic> into a List<Dog>.
      return List.generate(maps.length, (i) {
        return CryptoClass(
          id: maps[i]['id'],
          metin1: maps[i]['metin1'],
          key1: maps[i]['key1'],
          typecrypto: maps[i]['typecrypto'],
        );
      });
    }

    Future<void> updatedb(CryptoClass crypt) async {
      // Get a reference to the database.
      final db = await database;

      // Update the given Dog.
      await db.update(
        'cryptos',
        crypt.toMap(),
        // Ensure that the Dog has a matching id.
        where: 'id = ?',
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [crypt.id],
      );
    }

    Future<void> deletedb(int id) async {
      // Get a reference to the database.
      final db = await database;

      // Remove the Dog from the database.
      await db.delete(
        'cryptos',
        // Use a `where` clause to delete a specific dog.
        where: 'id = ?',
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [id],
      );
    }

    // Create a Dog and add it to the cryptos table

    /* var fido = CryptoClass(
      id: 0,
      metin1: 'Fido',
      key1: 'asdw',
      typecrypto: 35,
    ); */

    if (func == "add") {
      final db = await database;

      final data2 = await db.rawQuery('SELECT * FROM cryptos');
      int lastId = data2.last['id'] ?? 0;
      print(lastId);
      data = CryptoClass(
        id: lastId + 1,
        metin1: data.metin1,
        key1: data.key1,
        typecrypto: data.typecrypto,
      );
      print('---data2:');
      print('${data2[lastId]}');
      print('------');
      final dat2 = await db.rawQuery('SELECT * FROM cryptos ORDER BY id DESC');
      print(dat2);

      await insertdb(data);

      print("Inserted db");

      // Now, use the method above to retrieve all the cryptos.
      // Prints a list that include Fido.
      //print(await cryptosdb());
    }
    if (func == "update") {
      // Update Fido's typecrypto and save it to the database.
      data = CryptoClass(
        id: data.id,
        metin1: data.metin1,
        key1: data.key1,
        typecrypto: data.typecrypto + 7,
      );
      await updatedb(data);

      // Print the updated results.
      print("Updated db");
      print(await cryptosdb()); // Prints Fido with typecrypto 42.

    }
    if (func == "remove") {
      // Delete Fido from the database.
      await deletedb(data.id);
      // Print the list of cryptos (empty).
      print(await cryptosdb());
    }

    if (func == "list") {
      print("Listed db");

      // Now, use the method above to retrieve all the cryptos.
      // Prints a list that include Fido.
      return (await cryptosdb());
    }
  }

  @override
  Widget build(BuildContext context) {
    getinfo("", "");
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: encodedString,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Şifreli Metin',
            ),
            onChanged: (text) {
              sifreliMetin = text;
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: privKeyString,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Özel Anahtar',
            ),
            onChanged: (text) {
              //privKeyString = text;
            },
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  sifreCoz(sifreliMetin);
                });
              },
              child: Text("Şifre Çöz"))
        ],
      ),
    );
  }
}

class CryptoClass {
  final int id;
  final String metin1;
  final String key1;
  final int typecrypto;

  CryptoClass({
    this.id,
    this.metin1,
    this.key1,
    this.typecrypto,
  });

  // Convert a Dog into a Map. The keys must correspond to the metin1s of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'metin1': metin1,
      'key1': key1,
      'typecrypto': typecrypto,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Cryptolar{id: $id, metin1: $metin1, key1: $key1, typecrypto: $typecrypto}';
  }
}
