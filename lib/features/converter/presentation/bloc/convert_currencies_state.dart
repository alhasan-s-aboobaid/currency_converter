
import 'package:currency_converter/features/converter/domain/entities/conversion_data.dart';

abstract class CurrencyConversionState {

}

class Initial extends CurrencyConversionState {}

class Loading extends CurrencyConversionState {}

class Loaded extends CurrencyConversionState {
  final ConversionData conversionData;

  Loaded({required this.conversionData});

}

class Error extends CurrencyConversionState {
  final String message;

  Error({required this.message});

}