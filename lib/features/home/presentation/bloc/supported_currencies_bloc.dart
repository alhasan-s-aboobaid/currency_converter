import 'package:bloc/bloc.dart';
import 'package:currency_converter/core/error/failures.dart';
import '../../domain/entities/supported_currency.dart';
import '../bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import '../../domain/usecases/get_supported_currencies.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Failed to load from database';

class SupportedCurrenciesBloc extends Bloc<SupportedCurrenciesEvent, SupportedCurrenciesState> {

  final GetSupportedCurrencies getSupportedCurrencies;

  SupportedCurrenciesBloc({required this.getSupportedCurrencies}) : super(Initial()) {
    on<SupportedCurrenciesEvent>((event, emit) async {
      if(event is GetSupportedCurrenciesEvent) {
        emit(Loading());
        final response = await getSupportedCurrencies();
        emit(_eitherLoadedOrErrorState(response));
      }
    });
  }

@override

  void onTransition(Transition<SupportedCurrenciesEvent, SupportedCurrenciesState> transition) {
    // TODO: implement onTransition
    super.onTransition(transition);
    print(transition);
  }

  SupportedCurrenciesState _eitherLoadedOrErrorState(
      Either<Failure, SupportedCurrency> failureOrSupportedCurrencies,
      ) {
    return failureOrSupportedCurrencies.fold(
          (failure) => Error(message: _mapFailureToMessage(failure)),
          (supportedCurrencies) => Loaded(supportedCurrencies: supportedCurrencies),
    );
  }



  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }

}