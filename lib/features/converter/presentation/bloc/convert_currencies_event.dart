
abstract class CurrencyConversionEvent{
}

class ConvertBetweenCurrencies extends CurrencyConversionEvent {

  final String from;
  final String to;
  final int amount;

  ConvertBetweenCurrencies({required this.from, required this.to, required this.amount});
}
