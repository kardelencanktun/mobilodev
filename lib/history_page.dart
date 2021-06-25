import 'package:flutter/material.dart';

import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';
import 'variables.dart' as v;

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
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
      ////final List<Map<String, dynamic>> maps = await db.query('cryptos');
      final List<Map<String, dynamic>> maps =
          await db.rawQuery('SELECT id FROM cryptos ORDER BY id DESC');

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
      await insertdb(data);
      print("Inserted db");

      // Now, use the method above to retrieve all the cryptos.
      // Prints a list that include Fido.
      print(await cryptosdb());
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
      await cryptosdb();

      final db = await database;

      final data2 = await db.rawQuery('SELECT * FROM cryptos ORDER BY id DESC');
      int lastId = data2.last['id'] ?? 0;
      v.vLastID = lastId;
      return data2;
    }
  }

  /*  getValues() async {
    // First start
    // Avoid errors caused by flutter upgrade.
    // Importing 'package:flutter/widgets.dart' is required.
    WidgetsFlutterBinding.ensureInitialized();
    // Open the database and store the reference.
    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      path.join(await getDatabasesPath(), 'fkdb5.db'),
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
    var fido = CryptoClass(
      id: 0,
      metin1: 'Fido',
      key1: 'asdw',
      typecrypto: 35,
    );
    if (1 != 1) {
      await insertdb(fido);

      // Now, use the method above to retrieve all the cryptos.
      print(await cryptosdb()); // Prints a list that include Fido.

      // Update Fido's typecrypto and save it to the database.
      fido = CryptoClass(
        id: fido.id,
        metin1: fido.metin1,
        key1: fido.key1,
        typecrypto: fido.typecrypto + 7,
      );
      await updatedb(fido);

      // Print the updated results.
      print(await cryptosdb()); // Prints Fido with typecrypto 42.

      // Delete Fido from the database.
      await deletedb(fido.id);

      // Print the list of cryptos (empty).
      print(await cryptosdb());
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getValues();
    setState(() {});
  } */

  @override
  Widget build(BuildContext context) {
    getinfo("list", "").then((list) => v.gecmisListesi = list);
    print(v.gecmisListesi);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Geçmiş İşlemler"),
      ),
      body: _histlist(),
    );
  }

  Widget _histlist() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: (v.gecmisListesi.length * 2),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;

          return _satiryap(v.gecmisListesi[index].toString());
        });
  }

  Widget _satiryap(String _tutar) {
    return ListTile(
      title: Text(
        _tutar,
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: () {
        setState(() {
          v.gecmisListesi.remove(_tutar);
        });
      },
      onLongPress: () {
        setState(() {
          Clipboard.setData(new ClipboardData(text: _tutar));
        });
      },
    );
  }
}

class CryptoClass {
  final int id;
  String metin1;
  String key1;
  int typecrypto;

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
    return '{id: $id, metin1: $metin1, key1: $key1, typecrypto: $typecrypto}';
  }
}
