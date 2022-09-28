import 'package:currency_converter/core/error/exceptions.dart';
import 'package:currency_converter/core/error/failures.dart';
import 'package:currency_converter/features/historical_data/data/datasource/get_local_latest_conversions.dart';
import 'package:currency_converter/features/historical_data/data/datasource/get_remote_latest_data.dart';
import 'package:currency_converter/features/historical_data/data/models/latest_data_model.dart';
import 'package:currency_converter/features/historical_data/domain/entities/latest_data.dart';
import 'package:currency_converter/features/historical_data/domain/repository/latest_conversions_repositories.dart';
import 'package:currency_converter/features/home/data/datasources/get_local_supported_currencies.dart';
import 'package:currency_converter/features/home/domain/entities/supported_currency.dart';
import 'package:currency_converter/features/home/domain/repositories/supported_currency_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/network/network_state.dart';

import 'package:currency_converter/features/home/data/datasources/get_remote_supported_currencies.dart';



class LatestConversionsRepositoryImpl implements LatestConversionsRepository{
  final LastConversionsRemoteDataSource remoteDataSource;
  final LatestCurrencyConversionsLocalDataSource localDataSource;
  final NetworkState networkState;

  LatestConversionsRepositoryImpl({required this.localDataSource,
    required this.remoteDataSource,required this.networkState});

  @override
  Future<Either<Failure, LatestData>> getLatestConversions(String currency, LatestDataModel latestDataModel) async{
    if(await networkState.isConnected) {
      try {
        print("here 2");
        final remoteData = await remoteDataSource.getLastConversions(currency);
        localDataSource.storeData(remoteData);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        print("offline mode get local data");
        final localData = await localDataSource.getCachedData(latestDataModel);
        return Right(localData);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }


}