import 'package:etmaen/home/pages/chat_bot/chat_bot_page.dart';
import 'package:etmaen/home/pages/profile/profile_track_mode_view.dart';
import '../../ai/ai_analysis_view.dart';
import '../../ai/ai_quiz_view.dart';
import '../../ai/quiz_onborading/quiz_onborading.dart';
import '../../home/views/home_view.dart';
import '../../notifaction/notificaion_view.dart';
import '../../views/app_plan.dart';
import '../../auth/forget_passwrd/forget_passwrord_view.dart';
import '../../auth/new_passwrod/new_passwrd_view.dart';
import '../../auth/login/login_view.dart';
import '../../auth/otp/otp_view.dart';
import '../../auth/register/register_view.dart';
import '../../on_borading/on_borading_view.dart';
import '../../views/splash_view.dart';
import '../../views/welcome_view.dart';
import '../../views/welocme_login_view.dart';
import '../../home/pages/profile/settings/settings_screen.dart';
import '../../home/pages/profile/challenges/challenges_screen.dart';
import '../../home/pages/tests/tests_screen.dart';
import '../../home/pages/pro/pro_content_screen.dart';
import '../../home/pages/doctors/favorites/favorites_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AppRoutes {
  static const String splash = '/';
  static const String onBorading = '/onBorading';
  static const String welcome = '/welcome';
  static const String welcomeLogin = '/welcomeLogin';
  static const String login = '/login';
  static const String register = '/register';
  static const String otp = '/otp';
  static const String forgetPassword = '/forgetPasswrod';
  static const String newPassword = '/newPassword';
  static const String aiQuiz = '/aiQuiz';
  static const String aiQuizOnBorading = '/aiQuizOnBorading';
  static const String aiAnalysis = '/aiAnalysis';
  static const String appPlan = '/appPlan';
  static const String home = '/home';
  static const String notifaction = '/notificaion';
  static const String chatBot = '/chatBot';
  static const String settings = '/settings';
  static const String challenges = '/challenges';
  static const String tests = '/tests';
  static const String pro = '/pro';
  static const String favorites = '/favorites';
  static const String trackMode = '/trackMode';

  static Route? routeSetting(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return CupertinoPageRoute(
          builder: (context) => const SplashView(),
        );
      case onBorading:
        return CupertinoPageRoute(
          builder: (context) => const OnBoradingView(),
        );
      case welcome:
        return CupertinoPageRoute(
          builder: (context) => const WelcomeView(),
        );
      case welcomeLogin:
        return CupertinoPageRoute(
          builder: (context) => const WelcomeLoginView(),
        );
      case login:
        return CupertinoPageRoute(
          builder: (context) => const LoginView(),
        );
      case register:
        return CupertinoPageRoute(
          builder: (context) => const RegisterView(),
        );
      case otp:
        return CupertinoPageRoute(
          builder: (context) => const OtpView(),
          settings: settings,
        );
      case forgetPassword:
        return CupertinoPageRoute(
          builder: (context) => const ForgetPasswrordView(),
        );
      case newPassword:
        return CupertinoPageRoute(
          builder: (context) => const NewPasswordView(),
        );
      case aiQuiz:
        return CupertinoPageRoute(
          builder: (context) => const AiQuizView(),
        );
      case aiQuizOnBorading:
        return CupertinoPageRoute(
          builder: (context) => const QuizOnboradingView(),
        );
      case aiAnalysis:
        return CupertinoPageRoute(
          builder: (context) => const AiAnalysisView(),
        );
      case appPlan:
        return CupertinoPageRoute(
          builder: (context) => const AppPlanView(),
        );
      case home:
        return CupertinoPageRoute(
          builder: (context) => const HomeView(),
        );
      case notifaction:
        return CupertinoPageRoute(
          builder: (context) => const NotificaionView(),
        );
      case chatBot:
        return CupertinoPageRoute(
          builder: (context) => const ChatBotPage(),
        );
      case settings:
        return CupertinoPageRoute(
          builder: (context) => const SettingsScreen(),
        );
      case challenges:
        return CupertinoPageRoute(
          builder: (context) => const ChallengesScreen(),
        );
      case tests:
        return CupertinoPageRoute(
          builder: (context) => const TestsScreen(),
        );
      case pro:
        return CupertinoPageRoute(
          builder: (context) => const ProContentScreen(),
        );
      case favorites:
        return CupertinoPageRoute(
          builder: (context) => const FavoritesScreen(),
        );
      case trackMode:
        return CupertinoPageRoute(
          builder: (context) => const ProfileTrackModeView(),
        );

      default:
        return CupertinoPageRoute(
          builder: (context) => const Scaffold(),
        );
    }
  }
}
