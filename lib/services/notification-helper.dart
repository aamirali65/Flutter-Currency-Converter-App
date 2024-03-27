import 'dart:async';
import 'package:currensee/services/notifictaion_data.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class NotifictaionHelper {
  static final _notification = FlutterLocalNotificationsPlugin();

  static init() {
    _notification.initialize(const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    ));
  }

  static Future<void> pushNotification({required String title, required String body}) async {
    try {
      final exchangeRates = await ExchangeRateApiClient.getLatestExchangeRates(baseCurrency: 'USD');
      final double usdToPkrRate = exchangeRates['rates']['PKR'];

      var androidDetail = const AndroidNotificationDetails(
        'important_channel', 'My Channel',
        importance: Importance.max, priority: Priority.high,
      );
      var notificationDetails = NotificationDetails(android: androidDetail);
      await _notification.show(
        100, title, '$body: $usdToPkrRate PKR', notificationDetails,
      );
    } catch (e) {
      print('Failed to show notification: $e');
    }
  }
}