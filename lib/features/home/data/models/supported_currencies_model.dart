
import 'dart:convert';

import 'package:currency_converter/features/home/domain/entities/supported_currency.dart';

SupportedCurrencyModel currenciesFromJson(String str) => SupportedCurrencyModel.fromJson(json.decode(str));
String currenciesToJson(SupportedCurrencyModel data) => json.encode(data.toJson());


class SupportedCurrencyModel extends SupportedCurrency{
  SupportedCurrencyModel({
    List<List<String>>? supportedCodes,
  }) : super(supportedCodes: supportedCodes!);


  factory SupportedCurrencyModel.fromJson(Map<String, dynamic> json) {
    print("here 6");
    print(json);

    return SupportedCurrencyModel(
    supportedCodes: List<List<String>>.from(json["supported_codes"].map((x) => List<String>.from(x.map((x) => x)))),
  );
  }

  Map<String, dynamic> toJson() => {
    "supported_codes": List<dynamic>.from(supportedCodes.map((x) => List<dynamic>.from(x.map((x) => x)))),
  };

}
