import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'fkdb5.db'),
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
