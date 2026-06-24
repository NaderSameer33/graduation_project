import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../core/logic/user_prefs.dart';

// ─────────────────────────────────────────────
//  ChallengeNotificationService
//  Handles all local notification logic for
//  daily challenge reminders.
// ─────────────────────────────────────────────

class ChallengeNotificationService {
  ChallengeNotificationService._();

  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  // ── Notification IDs ─────────────────────
  static const int _dailyReminderId = 1001;
  static const int _immediateId = 1002;

  // ── Android channel ──────────────────────
  static const String _channelId = 'challenge_reminder';
  static const String _channelName = 'تذكير التحديات';
  static const String _channelDesc = 'تذكير يومي لإكمال التحدي النفسي';

  // ─────────────────────────────────────────
  //  init – call once from main()
  // ─────────────────────────────────────────
  static Future<void> init() async {
    // Initialise timezone database
    tz.initializeTimeZones();
    try {
      final String localTimezone = (await FlutterTimezone.getLocalTimezone()).identifier;
      tz.setLocalLocation(tz.getLocation(localTimezone));
    } catch (_) {
      tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
    }

    // Android init settings
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS / macOS init settings
    const DarwinInitializationSettings darwinSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
      macOS: darwinSettings,
    );

    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: _onBackgroundNotificationTap,
    );

    // Request Android 13+ notification permission
    await _requestPermission();

    // Create the Android notification channel
    await _createChannel();
  }

  // ─────────────────────────────────────────
  //  Permission request
  // ─────────────────────────────────────────
  static Future<void> _requestPermission() async {
    final androidImpl =
        _plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    if (androidImpl != null) {
      await androidImpl.requestNotificationsPermission();
    }
    final iosImpl = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    if (iosImpl != null) {
      await iosImpl.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  // ─────────────────────────────────────────
  //  Android notification channel
  // ─────────────────────────────────────────
  static Future<void> _createChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      _channelId,
      _channelName,
      description: _channelDesc,
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );
    final androidImpl =
        _plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await androidImpl?.createNotificationChannel(channel);
  }

  // ─────────────────────────────────────────
  //  Notification details
  // ─────────────────────────────────────────
  static NotificationDetails get _details => const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDesc,
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
          playSound: true,
          enableVibration: true,
          styleInformation: BigTextStyleInformation(''),
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      );

  // ─────────────────────────────────────────
  //  Schedule daily reminder at 20:00 (8 PM)
  //  Skips if challenge already done today.
  // ─────────────────────────────────────────
  static Future<void> scheduleDailyChallengeReminder() async {
    // Cancel existing to avoid duplicates
    await _plugin.cancel(_dailyReminderId);

    final bool doneToday = await UserPrefs.isChallengeDoneToday();
    if (doneToday) return;

    final tz.TZDateTime scheduledTime = _nextInstanceOf(20, 0);

    await _plugin.zonedSchedule(
      _dailyReminderId,
      '🌙 تذكير يومي',
      'لم تُكمل تحديك اليوم! خذ دقيقة وأنجز تحديك النفسي. 💪',
      scheduledTime,
      _details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'challenges',
    );

    if (kDebugMode) {
      debugPrint('[Notification] Daily reminder scheduled for $scheduledTime');
    }
  }

  // ─────────────────────────────────────────
  //  Show immediate notification right now
  //  (used by WorkManager callback)
  // ─────────────────────────────────────────
  static Future<void> showImmediateNotification() async {
    await _plugin.show(
      _immediateId,
      '🌙 تذكير يومي',
      'لم تُكمل تحديك اليوم! خذ دقيقة وأنجز تحديك النفسي. 💪',
      _details,
      payload: 'challenges',
    );
  }

  // ─────────────────────────────────────────
  //  Check and notify – call on app open
  //  Cancels reminder if challenge is done.
  // ─────────────────────────────────────────
  static Future<void> checkAndReschedule() async {
    final bool doneToday = await UserPrefs.isChallengeDoneToday();
    if (doneToday) {
      await cancelAll();
    } else {
      await scheduleDailyChallengeReminder();
    }
  }

  // ─────────────────────────────────────────
  //  Cancel all challenge notifications
  // ─────────────────────────────────────────
  static Future<void> cancelAll() async {
    await _plugin.cancel(_dailyReminderId);
    await _plugin.cancel(_immediateId);
  }

  // ─────────────────────────────────────────
  //  Helper – next occurrence of HH:mm today
  //  (or tomorrow if time already passed)
  // ─────────────────────────────────────────
  static tz.TZDateTime _nextInstanceOf(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  // ─────────────────────────────────────────
  //  Tap handlers
  // ─────────────────────────────────────────
  static void _onNotificationTap(NotificationResponse response) {
    // Navigation is handled via navigatorKey in main.dart
    if (response.payload == 'challenges') {
      // The navigatorKey push is done in main.dart listener
      _pendingPayload = response.payload;
    }
  }

  @pragma('vm:entry-point')
  static void _onBackgroundNotificationTap(NotificationResponse response) {
    _pendingPayload = response.payload;
  }

  /// Payload to consume on app resume (used by main.dart)
  static String? _pendingPayload;
  static String? consumePendingPayload() {
    final p = _pendingPayload;
    _pendingPayload = null;
    return p;
  }
}
