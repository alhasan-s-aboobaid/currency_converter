import 'package:currency_converter/features/historical_data/domain/entities/latest_data.dart';


class LatestDataModel extends LatestData {
  LatestDataModel(
      {int? timeLastUpdateUnix,
      String? timeLastUpdateUtc,
      int? timeNextUpdateUnix,
      String? timeNextUpdateUtc,
      String? baseCode,
      Map<String, double>? conversionRates})
      : super(
            baseCode: baseCode!,
            timeLastUpdateUtc: timeLastUpdateUtc!,
            timeLastUpdateUnix: timeLastUpdateUnix!,
            conversionRates: conversionRates!,
            timeNextUpdateUnix: timeNextUpdateUnix!,
            timeNextUpdateUtc: timeNextUpdateUtc!);

  factory LatestDataModel.fromJson(Map<String, dynamic> json) => LatestDataModel(
        timeLastUpdateUnix: json["time_last_update_unix"],
        timeLastUpdateUtc: json["time_last_update_utc"],
        timeNextUpdateUnix: json["time_next_update_unix"],
        timeNextUpdateUtc: json["time_next_update_utc"],
        baseCode: json["base_code"],
        conversionRates: Map.from(json["conversion_rates"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "time_last_update_unix": timeLastUpdateUnix,
        "time_last_update_utc": timeLastUpdateUtc,
        "time_next_update_unix": timeNextUpdateUnix,
        "time_next_update_utc": timeNextUpdateUtc,
        "base_code": baseCode,
        "conversion_rates": Map.from(conversionRates).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
