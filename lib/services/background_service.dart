import 'dart:async';
import 'dart:ui';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_practical_task/services/notification_services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_practical_task/data/models/todo_model.dart';
import 'package:flutter_practical_task/utils/constants/fonts/label_keys.dart';

class BackgroundService {
  static const int notificationId = 888;

  static Future<void> init() async {
    await NotificationService.init();
    await FlutterBackgroundService().configure(
      androidConfiguration: AndroidConfiguration(
        onStart: backgroundOnStart,
        isForegroundMode: true,
        autoStart: false,
        notificationChannelId: 'todo_channel',
        initialNotificationTitle: 'Todo Service',
        initialNotificationContent: 'Checking tasks...',
        foregroundServiceNotificationId: notificationId,
      ),
      iosConfiguration: IosConfiguration(),
    );
  }


  static void start() {
    FlutterBackgroundService().startService();
  }

  static void stop() {
    FlutterBackgroundService().invoke("stopService");
  }
}

/// ================= BACKGROUND ENTRY POINT =================

@pragma('vm:entry-point')
void backgroundOnStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  /// 🔥 Initialize Hive in background isolate
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(TodoModelAdapter());
  }

  final box = await Hive.openBox<TodoModel>('todos');

  if (service is AndroidServiceInstance) {
    service.on("stopService").listen((event) {
      service.stopSelf();
    });
  }

  Timer.periodic(const Duration(minutes: 5), (timer) async {
    if (service is! AndroidServiceInstance) return;
    if (!await service.isForegroundService()) return;

    final todos = box.values.toList();

    print("📦 Total Todos: ${todos.length}");

    bool hasInProgress = false;
    bool hasPaused = false;

    for (var todo in todos) {
      final status = todo.status.trim().toLowerCase();

      if (status == inProgressStatusKey.toLowerCase()) {
        hasInProgress = true;
      }

      if (status == pauseStatusKey.toLowerCase()) {
        hasPaused = true;
      }

      print("👉 ${todo.title} | Status: '${todo.status}'");
    }

    if (hasInProgress) {
      print("🟢 Found In-Progress task");

      service.setForegroundNotificationInfo(
        title: "Task Running",
        content: "A task is in progress",
      );
    }
    else if (hasPaused) {
      print("🟡 Found Paused task");

      service.setForegroundNotificationInfo(
        title: "Task Paused",
        content: "A task is paused",
      );
    }
    else {
      print("⚪ No active task. Stopping service.");
      timer.cancel();
      service.stopSelf();
    }
  });
}
