import 'dart:convert';

import 'package:currency_converter/features/historical_data/data/models/latest_data_model.dart';

import '../../../../core/error/exceptions.dart';

import 'package:http/http.dart' as http;

abstract class LastConversionsRemoteDataSource {

  Future<LatestDataModel> getLastConversions(String currency);

}

class LastConversionsRemoteDataSourceImpl implements LastConversionsRemoteDataSource {
  final http.Client client;

  LastConversionsRemoteDataSourceImpl({required this.client});

  @override
  Future<LatestDataModel> getLastConversions(String currency) async{
    final response = await client.get(
      Uri.parse("https://v6.exchangerate-api.com/v6/61e699eec9d6352bb919e1df/latest/$currency"),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return LatestDataModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

}