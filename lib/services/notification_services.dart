import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
  FlutterLocalNotificationsPlugin();
  static const String channelId = 'test_channel';

  static Future<void> init() async {
    const androidInit =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings =
    InitializationSettings(android: androidInit);

    await _notifications.initialize(settings: initSettings);


    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      channelId,
      'Todo Test',
      description: 'Used for background notifications',
      importance: Importance.high,
    );

    await _notifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }


  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      channelId,
      'Todo Test',
      importance: Importance.high,
      priority: Priority.high,
      ongoing: true,
    );

    await _notifications.show(
      id: id,
      title: title,
      body: body,
      notificationDetails:
      const NotificationDetails(android: androidDetails),
    );
  }
}
