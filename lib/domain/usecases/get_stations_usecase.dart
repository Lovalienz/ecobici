import 'package:ecobici/core/result.dart';
import 'package:ecobici/domain/models/network_model.dart';
import 'package:ecobici/domain/repository/stations_repository.dart';

class GetStationsiUseCase {
  final StationsRepository repository;

  GetStationsiUseCase(this.repository);

  Future<Result<Stations>> call() async {
    return await repository.getStations();
  }
}