import 'package:ecobici/domain/repository/stations_repository.dart';
import 'package:ecobici/domain/usecases/get_recent_viewed_usecase.dart';
import 'package:ecobici/domain/usecases/paginate_usecase.dart';
import 'package:ecobici/domain/usecases/get_stations_usecase.dart';
import 'package:ecobici/domain/usecases/save_recent_viewed_usecase.dart';
import 'package:get_it/get_it.dart';

void locatorUseCases(GetIt getIt) {
  getIt.registerFactory(() => GetStationsiUseCase(getIt<StationsRepository>()));
  getIt.registerFactory(
    () => GetLocalNetworkPaginatedUseCase(getIt<StationsRepository>()),
  );
  getIt.registerFactory(
    () => GetRecentViewedStationsUseCase(getIt<StationsRepository>()),
  );
  getIt.registerFactory(
    () => SaveRecentViewedStationUseCase(getIt<StationsRepository>()),
  );
}
