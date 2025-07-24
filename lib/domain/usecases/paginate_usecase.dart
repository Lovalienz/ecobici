

import 'package:ecobici/domain/models/network_model.dart';
import 'package:ecobici/domain/repository/stations_repository.dart';

class GetLocalNetworkPaginatedUseCase {
  final StationsRepository repository;

  GetLocalNetworkPaginatedUseCase(this.repository);

  List<Station> call(int page, int size) {
    return repository.getStationsFromLocal(page, size);
  }
}
