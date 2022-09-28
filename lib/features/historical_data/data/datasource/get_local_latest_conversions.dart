import 'package:currency_converter/core/database/currency_dao.dart';
import 'package:currency_converter/core/error/exceptions.dart';
import 'package:currency_converter/features/historical_data/data/models/latest_data_model.dart';
import 'package:dartz/dartz.dart';

abstract class LatestCurrencyConversionsLocalDataSource {

  Future<LatestDataModel> getCachedData(LatestDataModel latestDataModel);
  Future<Unit> storeData(LatestDataModel data);

}

class LatestCurrencyConversionsLocalDataSourceImpl implements LatestCurrencyConversionsLocalDataSource {
  @override
  Future<LatestDataModel> getCachedData(LatestDataModel latestDataModel) async{
    CurrencyDao dao = CurrencyDao();
    print("try to get data from local");
    var latest = await dao.getLatestData(latestDataModel);
    if(latest!=null) {
      print("get latest data from local");

      return Future.value(LatestDataModel.fromJson(latest as Map<String, dynamic>));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<Unit> storeData(LatestDataModel data) async{
    print("store latest data");
    CurrencyDao dao = CurrencyDao();
    await dao.insertWithKey(data);
    return Future.value(unit);
  }

}