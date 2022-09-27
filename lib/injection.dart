import 'package:currency_converter/core/network/network_state.dart';
import 'package:currency_converter/features/home/data/datasources/get_local_supported_currencies.dart';

import 'package:currency_converter/features/home/data/datasources/get_remote_supported_currencies.dart';
import 'package:currency_converter/features/home/domain/usecases/get_supported_currencies.dart';
import 'package:currency_converter/features/home/data/repositories/supported_currencies_repository_impl.dart';
import 'package:currency_converter/features/home/domain/repositories/supported_currency_repositories.dart';
import 'package:currency_converter/features/home/presentation/bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

GetIt inj = GetIt.instance;

Future<void> init() async {

  // Bloc

  inj.registerFactory(() =>
    SupportedCurrenciesBloc(
      getSupportedCurrencies: inj(),
    )
  );

  // Usecases
  inj.registerLazySingleton(() => GetSupportedCurrencies(inj()));


  // Repository
  inj.registerLazySingleton<SupportedCurrenciesRepository>(
        () => SupportedCurrenciesRepositoryImpl(
      networkState: inj(),
      localDataSource: inj(),
      supportedCurrenciesRemoteDataSource: inj(),
    ),
  );


  // Data sources
  inj.registerLazySingleton<SupportedCurrenciesRemoteDataSource>(
        () => SupportedCurrenciesRemoteDataSourceImpl(client: inj()),
  );

  inj.registerLazySingleton<SupportedCurrenciesLocalDataSource>(
        () => SupportedCurrenciesLocalDataSourceImpl(),
  );


  // core
  inj.registerLazySingleton<NetworkState>(() => NetworkStateImpl(inj()));

  //! External
  inj.registerLazySingleton(() => http.Client());
  inj.registerLazySingleton(() => InternetConnectionChecker());
}