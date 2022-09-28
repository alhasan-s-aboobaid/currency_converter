import 'package:currency_converter/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../entities/latest_data.dart';

abstract class LatestConversionsRepository {
  Future<Either<Failure, LatestData>> getLatestConversions(String currency);
}