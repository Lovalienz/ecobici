import 'package:ecobici/data/local/stations_local_datasource.dart';
import 'package:ecobici/data/remote/ecobici_service.dart';
import 'package:ecobici/data/repository/stations_repository_impl.dart';
import 'package:ecobici/domain/repository/stations_repository.dart';
import 'package:get_it/get_it.dart';

void locatorRepositories(GetIt getIt) {
  getIt.registerLazySingleton<StationsRepository>(
    () => StationsRepositoryImpl(
      remoteDataSource: getIt<EcoBiciService>(),
      localDataSource: getIt<StationsLocalDataSource>(),
    ),
  );
}
