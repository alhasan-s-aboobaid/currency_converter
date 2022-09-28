import 'package:currency_converter/core/error/failures.dart';
import 'package:currency_converter/features/historical_data/data/models/latest_data_model.dart';
import 'package:dartz/dartz.dart';
import '../entities/latest_data.dart';

abstract class LatestConversionsRepository {
  Future<Either<Failure, LatestData>> getLatestConversions(String currency, LatestDataModel latestDataModel);
}