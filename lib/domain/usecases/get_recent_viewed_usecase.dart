import 'package:ecobici/domain/models/network_model.dart';
import 'package:ecobici/domain/repository/stations_repository.dart';

class GetRecentViewedStationsUseCase {
  final StationsRepository repository;

  GetRecentViewedStationsUseCase(this.repository);

  Future<List<Station>> call() async {
    return await repository.getRecentViewedStations();
  }
}