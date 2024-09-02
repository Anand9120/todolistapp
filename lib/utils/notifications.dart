
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:todolistapp/models/task_model.dart';

class Notifications {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    await _notifications.initialize(initializationSettings);
  }

  static Future<void> scheduleNotification(TaskModel task) async {
    final tz.TZDateTime scheduledDate = tz.TZDateTime.from(
      task.dueDate,
      tz.local,
    ).subtract(const Duration(minutes: 30));

    await _notifications.zonedSchedule(
      task.id.hashCode,
      'Task Reminder',
      'Your task "${task.title}" is due soon',
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your_channel_id',
          'your_channel_name',
          channelDescription: 'your_channel_description',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static Future<void> cancelNotification(String taskId) async {
    await _notifications.cancel(taskId.hashCode);
  }
}
