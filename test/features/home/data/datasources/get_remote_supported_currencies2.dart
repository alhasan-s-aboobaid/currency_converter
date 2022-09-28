import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:currency_converter/features/home/data/datasources/get_remote_supported_currencies.dart';
import 'package:currency_converter/features/home/data/models/supported_currencies_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../offline_data/offline_data_reader.dart';
import 'get_remote_supported_currencies2.mocks.dart';


class SupportedCurrenciesRemoteDataSourceTest extends Mock implements SupportedCurrenciesRemoteDataSource {}

@GenerateMocks([http.Client])
Future<void> main() async{

  late MockClient mockClient;
  late SupportedCurrenciesRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockClient = MockClient();
    remoteDataSourceImpl = SupportedCurrenciesRemoteDataSourceImpl(client: mockClient);
  });

  test("test get currencies", () async {
    when(remoteDataSourceImpl.getSupportedCurrencies()).thenAnswer((_) async{
      return SupportedCurrencyModel(supportedCodes: []);
    });
  });

  void mockHttpClientSuccess200() {
    when(mockClient.get(Uri.parse(""), headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(readJson('supported_currencies.json'), 200));
  }
  
  test("test http get request", () async {
    mockHttpClientSuccess200();
  });


  group('getRandomNumberTrivia', () {
    final data =
    SupportedCurrencyModel.fromJson(json.decode(readJson('supported_currencies.json')));

    test(
      '''should perform a GET request on a URL''',
          () async {
        // arrange
        mockHttpClientSuccess200();
        // act
        when(remoteDataSourceImpl.getSupportedCurrencies()).thenAnswer((_) async{
          return SupportedCurrencyModel(supportedCodes: []);
        });
        // assert
        verify(mockClient.get(
          Uri.parse("https://v6.exchangerate-api.com/v6/61e699eec9d6352bb919e1df/codes"),
          headers: {
            'Content-Type': 'application/json',
          },
        )).called(1);
      },
    );

    test(
      'should return supported when the response code is 200',
          () async {
        // arrange
        mockHttpClientSuccess200();
        // act
        final result = await remoteDataSourceImpl.getSupportedCurrencies();
        // assert
        expect(result, equals(data));
      },
    );

  });
}
