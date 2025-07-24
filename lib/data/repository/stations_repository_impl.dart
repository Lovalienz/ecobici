import 'package:ecobici/core/result.dart';
import 'package:ecobici/data/local/stations_local_datasource.dart';
import 'package:ecobici/data/remote/dtos/mappers/network_mappers/network_mappers.dart';
import 'package:ecobici/data/remote/ecobici_service.dart';
import 'package:ecobici/domain/models/network_model.dart';
import 'package:ecobici/domain/repository/stations_repository.dart';

class StationsRepositoryImpl extends StationsRepository {
  final EcoBiciService remoteDataSource;
  final StationsLocalDataSource localDataSource;

  StationsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Result<Stations>> getStations() async {
    final result = await remoteDataSource.getEcoBiciData();
    switch (result) {
      case Success(:final data):
        localDataSource.saveStations(data.network.stations);
        return Success(data.network.toDomain());
      case Failure(:final message):
        return Failure(message);
      case Loading():
        return const Loading();
    }
  }

  @override
  Future<List<Station>> getStationsFromLocal(int page, int size) async {
    final responseList = await localDataSource.getStations(page: page, size: size);
    return responseList.map((stationResponse) => stationResponse.toDomain()).toList();
  }
}
