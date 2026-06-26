import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import 'challenge_notification_service.dart';

const String _kTaskName = 'challengeReminderTask';
const String _kTaskUniqueName = 'etmaen_challenge_daily_check';

// ── Top-level callback (required by WorkManager) ──────────────────
@pragma('vm:entry-point')
void _workmanagerCallbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    if (taskName == _kTaskName) {
      try {
        // We cannot use Flutter context here, so read prefs directly.
        final prefs = await SharedPreferences.getInstance();
        final String? lastDone = prefs.getString('challenge_last_done');
        final String today = _todayKey();
        final bool doneToday = lastDone == today;

        if (!doneToday) {
          // Init notification plugin in isolate
          await ChallengeNotificationService.init();
          await ChallengeNotificationService.showImmediateNotification();
        }
      } catch (e) {
        if (kDebugMode) debugPrint('[WorkManager] Error: $e');
        return Future.value(false);
      }
    }
    return Future.value(true);
  });
}

// ── Date helper ────────────────────────────────────────────────────
String _todayKey() {
  final now = DateTime.now();
  return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
}

// ─────────────────────────────────────────────
class ChallengeWorkmanagerService {
  ChallengeWorkmanagerService._();

  /// Call once from main() after WidgetsFlutterBinding.ensureInitialized()
  static Future<void> init() async {
    await Workmanager().initialize(
      _workmanagerCallbackDispatcher,
      isInDebugMode: kDebugMode,
    );
    await _registerPeriodicTask();
  }

  /// Register (or re-register) the periodic reminder task.
  /// Frequency: every 24 hours (minimum 15 min for debug).
  static Future<void> _registerPeriodicTask() async {
    await Workmanager().registerPeriodicTask(
      _kTaskUniqueName,
      _kTaskName,
      // 15 min is Android's minimum allowed periodic interval.
      // Use Duration(hours: 24) for production behaviour.
      frequency:
          kDebugMode ? const Duration(minutes: 15) : const Duration(hours: 24),
      initialDelay: const Duration(minutes: 1),
      constraints: Constraints(
        networkType: NetworkType.notRequired,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresDeviceIdle: false,
      ),
      existingWorkPolicy: ExistingPeriodicWorkPolicy.replace,
    );

    if (kDebugMode) {
      debugPrint('[WorkManager] Periodic challenge task registered.');
    }
  }

  /// Cancel the background task (e.g., after user completes challenge).
  static Future<void> cancelTask() async {
    await Workmanager().cancelByUniqueName(_kTaskUniqueName);
  }

  /// Re-register task (e.g., on next day start).
  static Future<void> reschedule() async {
    await _registerPeriodicTask();
  }
}
