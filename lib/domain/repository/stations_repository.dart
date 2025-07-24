import 'package:ecobici/core/result.dart';
import 'package:ecobici/domain/models/network_model.dart';

abstract class StationsRepository {
  Future<Result<Stations>> getStations();
  List<Station> getStationsFromLocal(int page, int size);
}
