import 'package:ecobici/core/result.dart';
import 'package:ecobici/domain/models/network_model.dart';

abstract class StationsRepository {
  Future<Result<Stations>> getStations();
  Future<List<Station>> getStationsFromLocal(int page, int size);
  Future<void> saveRecentViewedStation(Station station);
  Future<List<Station>> getRecentViewedStations();
}
