import 'dart:convert';

import '../../../../core/error/exceptions.dart';
import '../models/supported_currencies_model.dart';
import 'package:http/http.dart' as http;

abstract class SupportedCurrenciesRemoteDataSource {

  Future<SupportedCurrencyModel> getSupportedCurrencies();

}

class SupportedCurrenciesRemoteDataSourceImpl implements SupportedCurrenciesRemoteDataSource {
  final http.Client client;

  SupportedCurrenciesRemoteDataSourceImpl({required this.client});

  @override
  Future<SupportedCurrencyModel> getSupportedCurrencies() async{
    print("here 3");
    final response = await client.get(
      Uri.parse("https://v6.exchangerate-api.com/v6/61e699eec9d6352bb919e1df/codes"),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print("here 4");
      return SupportedCurrencyModel.fromJson(json.decode(response.body));
    } else {
      print("here 5");
      throw ServerException();
    }
  }

}