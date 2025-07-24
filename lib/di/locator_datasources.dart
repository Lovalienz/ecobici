import 'package:ecobici/data/local/stations_local_datasource.dart';
import 'package:ecobici/data/remote/ecobici_service.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

Future<void> locatorDataSources(GetIt getIt) async {

  final box = await Hive.openBox('stationsBox'); 

  getIt.registerSingleton<Box>(box); // registra el box

  getIt.registerLazySingleton<EcoBiciService>(() => EcoBiciService());

  getIt.registerLazySingleton<StationsLocalDataSource>(
    () => StationsLocalDataSource(getIt<Box>()),
  );
}