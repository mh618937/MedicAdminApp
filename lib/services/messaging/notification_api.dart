import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart' as rx;

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = rx.BehaviorSubject<String?>();
  //static var sound = "notification.mp3";
  static Future _notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
      "channel_Id", "channel_Name",
      importance: Importance.max,
      // playSound: true,
      // sound:
      //     RawResourceAndroidNotificationSound(sound.split(".").first))
    ));
  }

  static Future init({bool initSchedule = false}) async {
    const android = AndroidInitializationSettings("@mipmap/ic_launcher");
    const settings = InitializationSettings(android: android);

    await _notifications.initialize(
      settings,
      onSelectNotification: (payload) async {
        onNotifications.add(payload);
      },
    );
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notifications.show(
          id, title, body, payload: payload, await _notificationDetails());
}
