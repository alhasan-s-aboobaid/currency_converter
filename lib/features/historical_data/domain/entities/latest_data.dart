
class LatestData {

  int timeLastUpdateUnix;
  String timeLastUpdateUtc;
  int timeNextUpdateUnix;
  String timeNextUpdateUtc;
  String baseCode;
  Map<String, double> conversionRates;

  LatestData({
    required this.timeLastUpdateUnix,
    required this.timeLastUpdateUtc,
    required this.timeNextUpdateUnix,
    required this.timeNextUpdateUtc,
    required this.baseCode,
    required this.conversionRates,
  });

}
