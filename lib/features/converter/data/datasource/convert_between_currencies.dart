import 'dart:convert';
import 'package:currency_converter/features/converter/data/models/conversion_data_model.dart';
import '../../../../core/error/exceptions.dart';
import 'package:http/http.dart' as http;

abstract class CurrencyConversionDataSource {
  Future<ConversionDataModel> convertBetweenCurrency(String from, String to, int amount);
}

class CurrencyConversionDataSourceImpl implements CurrencyConversionDataSource {
  final http.Client client;

  CurrencyConversionDataSourceImpl({required this.client});

  @override
  Future<ConversionDataModel> convertBetweenCurrency(String from, String to, int amount) async {
    final response = await client.get(
      Uri.parse("https://v6.exchangerate-api.com/v6/61e699eec9d6352bb919e1df/pair/$from/$to/$amount"),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return ConversionDataModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
