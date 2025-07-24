import 'package:ecobici/data/local/stations_local_datasource.dart';
import 'package:ecobici/data/remote/ecobici_service.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

Future<void> locatorDataSources(GetIt getIt) async {
  final box = await Hive.openBox('stationsBox');
  final recentBox = await Hive.openBox('recentStationsBox');

  getIt.registerSingleton<Box>(box, instanceName: 'stationsBox');
  getIt.registerSingleton<Box>(recentBox, instanceName: 'recentStationsBox');

  getIt.registerLazySingleton<EcoBiciService>(() => EcoBiciService());

  getIt.registerLazySingleton<StationsLocalDataSource>(
    () => StationsLocalDataSource(
      getIt<Box>(instanceName: 'stationsBox'),
      getIt<Box>(instanceName: 'recentStationsBox'),
    ),
  );
}
