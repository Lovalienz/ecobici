import 'package:ecobici/domain/usecases/get_recent_viewed_usecase.dart';
import 'package:ecobici/domain/usecases/paginate_usecase.dart';
import 'package:ecobici/domain/usecases/get_stations_usecase.dart';
import 'package:ecobici/domain/usecases/save_recent_viewed_usecase.dart';
import 'package:ecobici/presentation/viewmodels/stations_viewmodel.dart';
import 'package:get_it/get_it.dart';

void locatorViewModels(GetIt getIt) {
  getIt.registerFactory(() => StationsViewModel(
    getLocalStations: getIt<GetLocalNetworkPaginatedUseCase>(),
    getRemoteStations: getIt<GetStationsiUseCase>(),
    getRecentViewed: getIt<GetRecentViewedStationsUseCase>(),
    saveRecentViewed: getIt<SaveRecentViewedStationUseCase>()
  ));
}
