import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practical_task/ui/screens/details_screen.dart';
import 'package:flutter_practical_task/ui/screens/login_screen.dart';
import 'package:flutter_practical_task/ui/screens/onboarding_screen.dart';
import 'package:flutter_practical_task/ui/screens/splash_screen.dart';
import 'package:flutter_practical_task/ui/screens/todo_screen.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static const String splash = "splash";
  static const String onboarding = "onboarding";
  static const String login = "login";
  static const String todo = "todo";
  static const String details = "details";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _splashNavigationScreen(settings);
      case onboarding:
        return _onboardingNavigationScreen(settings);
      case login:
        return _loginNavigationScreen(settings);
      case todo:
        return _todoNavigationScreen(settings);
      case details:
        return _detailsNavigationScreen(settings);
      default:
        throw Exception("Route We not found");
    }
  }

  static _splashNavigationScreen(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const SplashScreen());
  }
  static _onboardingNavigationScreen(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const OnboardingScreen());
  }
  static _loginNavigationScreen(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const LoginScreen());
  }
  static _todoNavigationScreen(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const TodoScreen());
  }
  static _detailsNavigationScreen(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const DetailsScreen());
  }
}
