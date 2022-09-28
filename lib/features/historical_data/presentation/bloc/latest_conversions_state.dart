
import 'package:currency_converter/features/historical_data/domain/entities/latest_data.dart';
import 'package:currency_converter/features/home/domain/entities/supported_currency.dart';
import 'package:equatable/equatable.dart';

abstract class LatestConversionsState {

}

class Initial extends LatestConversionsState {}

class Loading extends LatestConversionsState {}

class Loaded extends LatestConversionsState {
  final LatestData latestData;

  Loaded({required this.latestData});

}

class Error extends LatestConversionsState {
  final String message;

  Error({required this.message});

}