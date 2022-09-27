import 'package:currency_converter/core/error/failures.dart';
import 'package:currency_converter/features/converter/domain/entities/conversion_data.dart';
import 'package:dartz/dartz.dart';


abstract class CurrenciesConversionRepository {
  Future<Either<Failure, ConversionData>> convertBetweenCurrencies(String from, String to, int amount);
}