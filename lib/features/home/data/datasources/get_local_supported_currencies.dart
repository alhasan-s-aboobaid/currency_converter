import 'package:currency_converter/core/database/currency_dao.dart';
import 'package:currency_converter/core/error/exceptions.dart';
import 'package:currency_converter/core/util/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:sembast/sembast.dart';
import '../models/supported_currencies_model.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';

abstract class SupportedCurrenciesLocalDataSource {
  Future<SupportedCurrencyModel> getCachedData();
  Future<Unit> storeData(SupportedCurrencyModel data);

}

class SupportedCurrenciesLocalDataSourceImpl implements SupportedCurrenciesLocalDataSource {
  @override
  Future<SupportedCurrencyModel> getCachedData() async{
    CurrencyDao dao = CurrencyDao();
    print("try to get data from local");
    var supportedCurrencies = await dao.getData();
    if(supportedCurrencies!=null) {
      print("get data from local");
      print(supportedCurrencies == null);
      return Future.value(SupportedCurrencyModel.fromJson(supportedCurrencies as Map<String, dynamic>));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<Unit> storeData(SupportedCurrencyModel data) async{
    print("store data");
    CurrencyDao dao = CurrencyDao();
    await dao.delete();
    await dao.insert(data.toJson());

    return Future.value(unit);
  }

}