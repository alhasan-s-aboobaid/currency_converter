import 'dart:convert';

import 'package:currency_converter/features/home/data/datasources/get_remote_supported_currencies.dart';
import 'package:currency_converter/features/home/data/models/supported_currencies_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import '../../../../offline_data/offline_data_reader.dart';


class MockHttpClient extends Mock implements http.Client {}

void main() {
  late SupportedCurrenciesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = SupportedCurrenciesRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(Uri.parse(""), headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(readJson('supported_currencies.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(Uri.parse(""), headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getSupportedCurrencies', () {
    final supportedCurrenciesModel =
    SupportedCurrencyModel.fromJson(json.decode(readJson('supported_currencies.json')));

    test(
      'GET request',
          () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource.getSupportedCurrencies();
        // assert
        verify(mockHttpClient.get(
          Uri.parse("https://v6.exchangerate-api.com/v6/61e699eec9d6352bb919e1df/codes"),
          headers: {
            'Content-Type': 'application/json',
          },
        ));
      },
    );

    test(
      ' return SupportedCurrency when the response code is 200',
          () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getSupportedCurrencies();
        // assert
        expect(result, equals(supportedCurrenciesModel));
      },
    );


  });


}
