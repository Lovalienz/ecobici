import 'package:ecobici/data/local/models/station_response.dart';
import 'package:ecobici/di/setup_locator.dart';
import 'package:ecobici/presentation/ui/splash_screen/splash_screen.dart';
import 'package:ecobici/presentation/ui/stations/stations_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(LocationResponseAdapter());
  Hive.registerAdapter(StationExtraResponseAdapter());
  Hive.registerAdapter(StationResponseAdapter());
  Hive.registerAdapter(StationsResponseAdapter());
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Route _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/stations':
        return PageTransition(
          type: PageTransitionType.bottomToTop,
          child: StationsWrapper(),
          duration: Duration(milliseconds: 1000),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(body: Center(child: Text('Ruta desconocida'))),
        );
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      onGenerateRoute: _onGenerateRoute,
    );
  }
}
