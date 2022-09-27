import 'dart:convert';

import 'package:currency_converter/features/converter/domain/entities/conversion_data.dart';


ConversionData conversionDataFromJson(String str) => ConversionDataModel.fromJson(json.decode(str));

String conversionDataToJson(ConversionDataModel data) => json.encode(data.toJson());

class ConversionDataModel extends ConversionData {
  ConversionDataModel({
    String? timeLastUpdateUtc,
    String? baseCode,
    String? targetCode,
    double? conversionRate,
    double? conversionResult,
  }) : super(
            timeLastUpdateUtc: timeLastUpdateUtc!,
            baseCode: baseCode!,
            targetCode: targetCode!,
            conversionRate: conversionRate!,
            conversionResult: conversionResult!);


  factory ConversionDataModel.fromJson(Map<String, dynamic> json) => ConversionDataModel(
    timeLastUpdateUtc: json["time_last_update_utc"],
    baseCode: json["base_code"],
    targetCode: json["target_code"],
    conversionRate: json["conversion_rate"].toDouble(),
    conversionResult: json["conversion_result"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "time_last_update_utc": timeLastUpdateUtc,
    "base_code": baseCode,
    "target_code": targetCode,
    "conversion_rate": conversionRate,
    "conversion_result": conversionResult,
  };

}
