import 'package:ecobici/domain/models/network_model.dart';
import 'package:ecobici/domain/repository/stations_repository.dart';

class SaveRecentViewedStationUseCase {
  final StationsRepository repository;

  SaveRecentViewedStationUseCase(this.repository);

  Future<void> call(Station station) async {
    await repository.saveRecentViewedStation(station);
  }
}