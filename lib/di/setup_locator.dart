import 'package:ecobici/di/locator_datasources.dart';
import 'package:ecobici/di/locator_repositories.dart';
import 'package:ecobici/di/locator_usecases.dart';
import 'package:ecobici/di/locator_viewmodels.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  final getIt = GetIt.instance;

  await locatorDataSources(getIt);
  locatorRepositories(getIt);
  locatorUseCases(getIt);
  locatorViewModels(getIt);
}