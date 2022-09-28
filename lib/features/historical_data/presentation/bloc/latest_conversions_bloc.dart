import 'package:bloc/bloc.dart';
import 'package:currency_converter/core/error/failures.dart';
import '../../domain/entities/latest_data.dart';
import '../bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import '../../domain/usecases/get_supported_currencies.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Failed to load from database';

class LatestConversionsBloc extends Bloc<LatestConversionsEvent, LatestConversionsState> {

  final GetLatestConversions getLatestConversions;

  LatestConversionsBloc({required this.getLatestConversions}) : super(Initial()) {
    on<LatestConversionsEvent>((event, emit) async {
      if(event is GetLatestConversionsEvent) {
        emit(Loading());
        final response = await getLatestConversions(event.currency);
        emit(_eitherLoadedOrErrorState(response));
      }
    });
  }

@override

  void onTransition(Transition<LatestConversionsEvent, LatestConversionsState> transition) {
    // TODO: implement onTransition
    super.onTransition(transition);
    print(transition);
  }

  LatestConversionsState _eitherLoadedOrErrorState(
      Either<Failure, LatestData> failureOrlatest,
      ) {
    return failureOrlatest.fold(
          (failure) => Error(message: _mapFailureToMessage(failure)),
          (latest) => Loaded(latestData: latest),
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