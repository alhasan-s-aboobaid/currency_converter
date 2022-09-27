import 'package:currency_converter/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../entities/supported_currency.dart';

abstract class SupportedCurrenciesRepository {
  Future<Either<Failure, SupportedCurrency>> getSupportedCurrencies();
}