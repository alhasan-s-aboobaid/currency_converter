import 'package:currency_converter/core/error/exceptions.dart';
import 'package:currency_converter/core/error/failures.dart';
import 'package:currency_converter/features/converter/data/datasource/convert_between_currencies.dart';
import 'package:currency_converter/features/converter/domain/entities/conversion_data.dart';
import 'package:currency_converter/features/converter/domain/repositories/currency_conversion_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/network/network_state.dart';



class CurrencyConversionRepositoryImpl implements CurrenciesConversionRepository{
  final CurrencyConversionDataSource remoteDataSource;
  final NetworkState networkState;

  CurrencyConversionRepositoryImpl({
    required this.remoteDataSource,required this.networkState});

  @override
  Future<Either<Failure, ConversionData>> convertBetweenCurrencies(String from, String to, int amount) async {
    if(await networkState.isConnected) {
      try {

        final remoteData = await remoteDataSource.convertBetweenCurrency(from, to, amount);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }


}