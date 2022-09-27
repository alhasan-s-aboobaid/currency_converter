
import 'package:currency_converter/features/home/domain/entities/supported_currency.dart';
import 'package:equatable/equatable.dart';

abstract class SupportedCurrenciesState {

}

class Initial extends SupportedCurrenciesState {}

class Loading extends SupportedCurrenciesState {}

class Loaded extends SupportedCurrenciesState {
  final SupportedCurrency supportedCurrencies;

  Loaded({required this.supportedCurrencies});

}

class Error extends SupportedCurrenciesState {
  final String message;

  Error({required this.message});

}