import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practical_task/ui/screens/splash_screen.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static const String splash = "splash";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _splashNavigationScreen(settings);
      default:
        throw Exception("Route We not found");
    }
  }

  static _splashNavigationScreen(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const SplashScreen());
  }

}
