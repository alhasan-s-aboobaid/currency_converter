import 'package:currency_converter/features/historical_data/data/models/latest_data_model.dart';
import 'package:currency_converter/features/historical_data/domain/entities/latest_data.dart';
import 'package:currency_converter/features/historical_data/domain/repository/latest_conversions_repositories.dart';
import 'package:currency_converter/core/error/failures.dart';
import 'package:dartz/dartz.dart';


class GetLatestConversions {

  final LatestConversionsRepository latestConversionsRepository;

  GetLatestConversions(this.latestConversionsRepository);

  Future<Either<Failure, LatestData>> call(String currency, LatestDataModel latestDataModel) async{
    return await latestConversionsRepository.getLatestConversions(currency, latestDataModel);
  }
}
