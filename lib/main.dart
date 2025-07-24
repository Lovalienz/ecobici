import 'package:ecobici/presentation/ui/splash_screen/splash_screen.dart';
import 'package:ecobici/presentation/ui/stations/stations_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void main() {
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
          child: Stations(),
          duration: Duration(milliseconds: 1000),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text('Ruta desconocida'))),
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


