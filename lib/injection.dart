import 'package:currency_converter/core/network/network_state.dart';
import 'package:currency_converter/features/converter/data/datasource/convert_between_currencies.dart';
import 'package:currency_converter/features/converter/domain/repositories/currency_conversion_repositories.dart';
import 'package:currency_converter/features/converter/domain/usecases/convert_currencies.dart';
import 'package:currency_converter/features/converter/presentation/bloc/convert_currencies_bloc.dart';
import 'package:currency_converter/features/historical_data/data/datasource/get_local_latest_conversions.dart';
import 'package:currency_converter/features/historical_data/data/datasource/get_remote_latest_data.dart';
import 'package:currency_converter/features/historical_data/data/repositories/latest_conversions_repository_impl.dart';
import 'package:currency_converter/features/historical_data/domain/repository/latest_conversions_repositories.dart';
import 'package:currency_converter/features/historical_data/domain/usecases/get_supported_currencies.dart';
import 'package:currency_converter/features/historical_data/presentation/bloc/bloc.dart';
import 'package:currency_converter/features/home/data/datasources/get_local_supported_currencies.dart';

import 'package:currency_converter/features/home/data/datasources/get_remote_supported_currencies.dart';
import 'package:currency_converter/features/home/domain/usecases/get_supported_currencies.dart';
import 'package:currency_converter/features/home/data/repositories/supported_currencies_repository_impl.dart';
import 'package:currency_converter/features/home/domain/repositories/supported_currency_repositories.dart';
import 'package:currency_converter/features/home/presentation/bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'features/converter/data/repositories/conversion_currencies_repository_impl.dart';

GetIt inj = GetIt.instance;

Future<void> init() async {
  // Bloc

  inj.registerFactory(() => SupportedCurrenciesBloc(getSupportedCurrencies: inj()));
  inj.registerFactory(() => CurrencyConversionBloc(convertCurrencies: inj()));
  inj.registerFactory(() => LatestConversionsBloc(getLatestConversions: inj()));

  // Usecases
  inj.registerLazySingleton(() => GetSupportedCurrencies(inj()));
  inj.registerLazySingleton(() => ConvertCurrencies(inj()));
  inj.registerLazySingleton(() => GetLatestConversions(inj()));

  // Repository
  inj.registerLazySingleton<SupportedCurrenciesRepository>(() => SupportedCurrenciesRepositoryImpl(
      networkState: inj(), localDataSource: inj(), supportedCurrenciesRemoteDataSource: inj()));

  inj.registerLazySingleton<CurrenciesConversionRepository>(() => CurrencyConversionRepositoryImpl(
      networkState: inj(), remoteDataSource: inj()));

  inj.registerLazySingleton<LatestConversionsRepository>(() => LatestConversionsRepositoryImpl(
    localDataSource: inj(),
      networkState: inj(), remoteDataSource: inj()));

  // Data sources
  inj.registerLazySingleton<SupportedCurrenciesRemoteDataSource>(
    () => SupportedCurrenciesRemoteDataSourceImpl(client: inj()),
  );
  inj.registerLazySingleton<CurrencyConversionDataSource>(
        () => CurrencyConversionDataSourceImpl(client: inj()),
  );

  inj.registerLazySingleton<SupportedCurrenciesLocalDataSource>(
    () => SupportedCurrenciesLocalDataSourceImpl(),
  );

  inj.registerLazySingleton<LatestCurrencyConversionsLocalDataSource>(
        () => LatestCurrencyConversionsLocalDataSourceImpl(),
  );
  inj.registerLazySingleton<LastConversionsRemoteDataSource>(
        () => LastConversionsRemoteDataSourceImpl(client: inj()),
  );

  // core
  inj.registerLazySingleton<NetworkState>(() => NetworkStateImpl(inj()));

  // External
  inj.registerLazySingleton(() => http.Client());
  inj.registerLazySingleton(() => InternetConnectionChecker());
}
