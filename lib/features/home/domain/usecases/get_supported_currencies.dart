import 'package:currency_converter/features/home/domain/repositories/supported_currency_repositories.dart';
import 'package:currency_converter/core/error/failures.dart';
import 'package:currency_converter/features/home/domain/entities/supported_currency.dart';
import 'package:dartz/dartz.dart';


class GetSupportedCurrencies {

  final SupportedCurrenciesRepository supportedCurrencyRepo;

  GetSupportedCurrencies(this.supportedCurrencyRepo);

  Future<Either<Failure, SupportedCurrency>> call() async{
    print("here 1");
    return await supportedCurrencyRepo.getSupportedCurrencies();
  }
}
