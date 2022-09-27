import 'package:currency_converter/features/converter/domain/entities/conversion_data.dart';
import 'package:currency_converter/features/converter/domain/repositories/currency_conversion_repositories.dart';
import 'package:currency_converter/core/error/failures.dart';
import 'package:dartz/dartz.dart';


class ConvertCurrencies {

  final CurrenciesConversionRepository conversionRepository;

  ConvertCurrencies(this.conversionRepository);

  Future<Either<Failure, ConversionData>> call({from, to, amount}) async{

    return await conversionRepository.convertBetweenCurrencies(from, to, amount);
  }
}
