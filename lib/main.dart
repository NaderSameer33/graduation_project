import 'package:etmaen/core/logic/app_routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const EtmaenApp());
}

class EtmaenApp extends StatelessWidget {
  const EtmaenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 811),
      minTextAdapt: true,
      splitScreenMode: true,

      child: MaterialApp(
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRoutes.routeSetting,
        darkTheme: ThemeData(
          fontFamily: 'Cairo',
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
        ),

        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
