import 'core/logic/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const EtmaenApp());
}

class EtmaenApp extends StatelessWidget {
  const EtmaenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
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

          initialRoute: AppRoutes.aiAnalysis,
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
