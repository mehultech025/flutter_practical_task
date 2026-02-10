import 'dart:async' as BlocOverrides;
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_practical_task/core/app_theme.dart';
import 'package:flutter_practical_task/router/app_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return kReleaseMode ? _releaseWidget(context) : _debugWidget(context);
  }
}

MaterialApp _releaseWidget(BuildContext context,) =>
    MaterialApp(
      title: 'Flutter Demo',
      theme: appLightTheme(context),
      debugShowCheckedModeBanner: false,
      navigatorKey: AppRouter.navigatorKey,
      initialRoute: AppRouter.splash,
      onGenerateRoute: AppRouter.onGenerateRoute,
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child:
                EasyLoading.init()(context, _responsiveWrapperWidget(child!)));
      },
    );

DevicePreview _debugWidget(
  BuildContext context,
) =>
    BlocOverrides.runZoned(
      () => DevicePreview(
        enabled: true,
        builder: (context) => MaterialApp(
          theme: appLightTheme(context),
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          navigatorKey: AppRouter.navigatorKey,
          initialRoute: AppRouter.splash,
          onGenerateRoute: AppRouter.onGenerateRoute,
          useInheritedMediaQuery: true,
          builder: (context, child) {
            return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaleFactor: 1.0,
                ), // Locks text scaling
                child: EasyLoading.init()(
                    context, _responsiveWrapperWidget(child!)));
          },
        ),
      ),
    );

Widget _responsiveWrapperWidget(Widget child) {
  return ResponsiveBreakpoints.builder(
    child: child,
    breakpoints: [
      const Breakpoint(start: 0, end: 450, name: MOBILE),
      const Breakpoint(start: 451, end: 1024, name: TABLET),
      const Breakpoint(start: 1025, end: 1440, name: DESKTOP),
      const Breakpoint(start: 1441, end: double.infinity, name: '4K'),
    ],
  );
}
