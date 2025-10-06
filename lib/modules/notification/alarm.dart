// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Alarm {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initInfo() {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: androidInitialize);
    // Works on Forground
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Listen on any notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('********************on Message********************');
      print(
          "onMessage: ${message.notification?.title}/${message.notification?.body}");
      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(),
        htmlFormatBigText: true,
        contentTitle: message.notification!.title.toString(),
        htmlFormatContentTitle: true,
      );
      AndroidNotificationDetails androidPlatformChannelSpecifies =
          AndroidNotificationDetails(
        '1234567',
        '1234567',
        importance: Importance.max,
        styleInformation: bigTextStyleInformation,
        priority: Priority.high,
        sound: const RawResourceAndroidNotificationSound('alarm'),
      );
      NotificationDetails PlatformChannelSpecifies =
          NotificationDetails(android: androidPlatformChannelSpecifies);
      await flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title,
        message.notification?.body,
        PlatformChannelSpecifies,
        payload: message.data['_id'],
      );
    });
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User Granted Permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User Granted Provisional Permission');
    } else {
      print('User Declined Or Not Accepted');
    }
  }

  Future<void> scheduleMedicationReminder(
    String patientName,
    String roomNumber,
    String medicineName,
    String doseFrequency,
    String medicineQuantity,
    TimeOfDay medicineTime,
    DateTime startDate,
    DateTime endDate,
  ) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channel_id',
      'Channel Name',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: false,
      sound: RawResourceAndroidNotificationSound('alarm')
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    // Load the time zone data
    tz.initializeTimeZones();

    // Get the time zone of Egypt
    final egyptTimeZone = tz.getLocation('Africa/Cairo');

    // Calculate the difference in days between the start and end dates
    int daysDifference = endDate.difference(startDate).inDays;

    // Schedule daily notifications from the start date to the end date
    for (int i = 0; i <= daysDifference; i++) {
      DateTime notificationDate = startDate.add(Duration(days: i));

      // Set the notification time
      tz.TZDateTime notificationDateTime = tz.TZDateTime(
        egyptTimeZone,
        notificationDate.year,
        notificationDate.month,
        notificationDate.day,
        medicineTime.hour,
        medicineTime.minute,
      );

      // Schedule the notification
      await flutterLocalNotificationsPlugin.zonedSchedule(
        i,
        'Medication Reminder',
        'Patient: $patientName, Room: $roomNumber\nMedicine: $medicineName\nDose Frequency: $doseFrequency\nQuantity: $medicineQuantity',
        notificationDateTime,
        platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: '$patientName,$roomNumber,$medicineName',
      );
    }
  }
}
