import 'package:ecobici/data/remote/dtos/network_response.dart';
import 'package:hive/hive.dart';

class StationsLocalDataSource {
  final Box box;

  StationsLocalDataSource(this.box);

  Future<void> saveNetwork(NetworkResponse network) async {
    await box.put('network', network);
  }

  Future<void> saveStations(List<StationResponse> stations) async {
    for (var station in stations) {
      await box.put(station.id, station);
    }
  }

  Future<List<StationResponse>> getStations({required int page, required int size}) async {
    final allStations = box.values.whereType<StationResponse>().toList();
    final start = page * size;
    final end = start + size;
    if (start >= allStations.length) return [];
    return  allStations.sublist(start, end.clamp(0, allStations.length));
  }
}
