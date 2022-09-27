import 'package:currency_converter/core/database/app_database.dart';
import 'package:sembast/sembast.dart';


class CurrencyDao {

  static const String SUPPORTED_STORE_NAME = 'supported';
  static const String SUPPORTED_KEY = 'supported_key';


  final _currencyStore = intMapStoreFactory.store(SUPPORTED_STORE_NAME);
  var appDatabase = AppDatabase();

  Future<Database> get _db async => await appDatabase.database;

  Future insert(Map<String, dynamic> data) async {
    await _currencyStore.add(await _db, data);
  }



  Future delete() async {
    await _currencyStore.delete(await _db,);
  }

  Future getData() async {
    final recordSnapshot = await _currencyStore.find(await _db);
    return recordSnapshot.map((snapshot) {
      print(snapshot.value);
      return snapshot.value;
    }).toList()[0];
  }
}