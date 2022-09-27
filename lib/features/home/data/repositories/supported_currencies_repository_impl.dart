import 'package:currency_converter/core/error/exceptions.dart';
import 'package:currency_converter/core/error/failures.dart';
import 'package:currency_converter/features/home/data/datasources/get_local_supported_currencies.dart';
import 'package:currency_converter/features/home/domain/entities/supported_currency.dart';
import 'package:currency_converter/features/home/domain/repositories/supported_currency_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/network/network_state.dart';

import 'package:currency_converter/features/home/data/datasources/get_remote_supported_currencies.dart';



class SupportedCurrenciesRepositoryImpl implements SupportedCurrenciesRepository{
  final SupportedCurrenciesRemoteDataSource supportedCurrenciesRemoteDataSource;
  final SupportedCurrenciesLocalDataSource localDataSource;
  final NetworkState networkState;

  SupportedCurrenciesRepositoryImpl({required this.localDataSource,
    required this.supportedCurrenciesRemoteDataSource,required this.networkState});

  @override
  Future<Either<Failure, SupportedCurrency>> getSupportedCurrencies() async {
    if(await networkState.isConnected) {
      try {
        print("here 2");
        final remoteData = await supportedCurrenciesRemoteDataSource.getSupportedCurrencies();
        localDataSource.storeData(remoteData);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        print("offline mode get local data");
        final localData = await localDataSource.getCachedData();
        return Right(localData);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }


}