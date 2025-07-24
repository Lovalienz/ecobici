import 'package:ecobici/domain/usecases/paginate_usecase.dart';
import 'package:ecobici/domain/usecases/stations_usecase.dart';
import 'package:ecobici/presentation/viewmodels/stations_viewmodel.dart';
import 'package:get_it/get_it.dart';

void locatorViewModels(GetIt getIt) {
  getIt.registerFactory(() => StationsViewModel(
    getLocalStations: getIt<GetLocalNetworkPaginatedUseCase>(),
    getRemoteStations: getIt<GetStationsiUseCase>(),
  ));
}
