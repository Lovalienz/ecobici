
import 'package:ecobici/data/remote/dtos/network_response.dart';
import 'package:hive/hive.dart';


class NetworkLocalDataSource {
  final Box box;

  NetworkLocalDataSource(this.box);

  Future<void> cacheNetwork(StationsResponse network) async {
    await box.put('network', network);
  }

  Future<void> cacheStations(List<StationResponse> stations) async {
    for (var station in stations) {
      await box.put(station.id, station);
    }
  }

  List<StationResponse> getStations({required int page, required int size}) {
    final allStations = box.values.whereType<StationResponse>().toList();
    final start = page * size;
    final end = start + size;
    if (start >= allStations.length) return [];
    return allStations.sublist(start, end.clamp(0, allStations.length));
  }
}
