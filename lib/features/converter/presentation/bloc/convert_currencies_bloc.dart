import 'package:bloc/bloc.dart';
import 'package:currency_converter/core/error/failures.dart';
import '../../domain/entities/conversion_data.dart';
import '../bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import '../../domain/usecases/convert_currencies.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Failed to load from database';

class CurrencyConversionBloc extends Bloc<CurrencyConversionEvent, CurrencyConversionState> {

  final ConvertCurrencies convertCurrencies;

  CurrencyConversionBloc({required this.convertCurrencies}) : super(Initial()) {
    on<CurrencyConversionEvent>((event, emit) async {
      if(event is ConvertBetweenCurrencies) {
        emit(Loading());
        final response = await convertCurrencies(
          from: event.from,
          to: event.to,
          amount: event.amount
        );
        emit(_eitherLoadedOrErrorState(response));
      }
    });
  }

@override

  void onTransition(Transition<CurrencyConversionEvent, CurrencyConversionState> transition) {
    // TODO: implement onTransition
    super.onTransition(transition);
    print(transition);
  }

  CurrencyConversionState _eitherLoadedOrErrorState(
      Either<Failure, ConversionData> failureOrConversionCurrencies,
      ) {
    return failureOrConversionCurrencies.fold(
          (failure) => Error(message: _mapFailureToMessage(failure)),
          (conversionResult) => Loaded(conversionData:  conversionResult),
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