import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_practical_task/core/bloc_and_repositories_app.dart';
import 'package:flutter_practical_task/dart_task.dart';
import 'package:flutter_practical_task/data/models/todo_model.dart';
import 'package:flutter_practical_task/services/background_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'core/app.dart';
import 'firebase_options.dart';

Future<void> main() async {
  ref();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await BackgroundService.init();
  await Hive.initFlutter();
  await Hive.openBox('auth');
  Hive.registerAdapter(TodoModelAdapter());

  await Hive.openBox<TodoModel>('todos');
  configEasyLoading();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory(
            (await getApplicationDocumentsDirectory()).path,
          ),
  );
  runApp(const BlocAndRepositoryApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (getDeviceType() == "phone") {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ]).then((_) async {
            return App();
          });
        }
        return App();
      },
    );
  }
}

String getDeviceType() {
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  return data.size.shortestSide < 600 ? 'phone' : 'tablet';
}

void configEasyLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = Colors.black
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.black.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}
