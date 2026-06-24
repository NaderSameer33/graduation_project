import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/logic/app_routes.dart';
import 'notifaction/challenge_notification_service.dart';
import 'notifaction/challenge_workmanager_service.dart';

// ─────────────────────────────────────────────
//  App entry point
//  Initialises notifications + background tasks
//  before the widget tree is mounted.
// ─────────────────────────────────────────────

void main() async {
  // Required before any async work in main()
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Init local notification plugin (foreground + background + dead)
  await ChallengeNotificationService.init();

  // 2. Schedule / verify the daily 8 PM reminder
  await ChallengeNotificationService.checkAndReschedule();

  // 3. Register WorkManager periodic task (Android dead-state)
  await ChallengeWorkmanagerService.init();

  runApp(const EtmaenApp());
}

class EtmaenApp extends StatelessWidget {
  const EtmaenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: ScreenUtilInit(
        designSize: const Size(375, 811),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          builder: (context, child) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: child!,
            );
          },
          initialRoute: AppRoutes.home,
          onGenerateRoute: AppRoutes.routeSetting,
          darkTheme: ThemeData(
            fontFamily: 'Cairo',
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.black,
          ),
          themeMode: ThemeMode.dark,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
