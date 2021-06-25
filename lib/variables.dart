bool registered = false;
String unamedb = "admin";
String passdb = "admin";
var gecmisListesi = [];
var vLastID;
String dbname = "fkdb5.db";

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
