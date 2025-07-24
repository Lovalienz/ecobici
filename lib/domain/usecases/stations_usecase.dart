import 'package:ecobici/domain/models/network_model.dart';
import 'package:ecobici/domain/repository/stations_repository.dart';

class GetStationsiUseCase {
  final StationsRepository repository;

  GetStationsiUseCase(this.repository);

  Future<Network> call(String networkId) async {
    return await repository.getStations(networkId);
  }
}