import 'package:etmaen/cinema/cinema_etmaen.dart';
import 'package:etmaen/cinema/cinema_video_view.dart';

import '../../home/pages/chat_bot/chat_bot_page.dart';
import '../../home/pages/profile/profile_track_mode_view.dart';
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
import 'package:flutter/material.dart';
import '../../cinema/audio_player_view.dart';
import '../../home/pages/home/learning_view.dart';
import '../../home/pages/home/category_detail_view.dart';
import '../../home/pages/home/exercise_view.dart';
import '../../home/pages/home/video_list_view.dart';
import '../../home/pages/home/article_detail_view.dart';

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
  static const String cinema = '/cinema';
  static const String cinemaVideo = '/cinemaVideo';
  static const String audioPlayer = '/audioPlayer';
  static const String learning = '/learning';
  static const String categoryDetail = '/categoryDetail';
  static const String exercise = '/exercise';
  static const String videoList = '/videoList';
  static const String articleDetail = '/articleDetail';

  static PageRouteBuilder _customRoute(Widget page, {RouteSettings? settings}) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 0.05);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var slideTween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var fadeTween = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));

        return FadeTransition(
          opacity: animation.drive(fadeTween),
          child: SlideTransition(
            position: animation.drive(slideTween),
            child: child,
          ),
        );
      },
    );
  }

  static Route? routeSetting(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return _customRoute(const SplashView(), settings: routeSettings);
      case onBorading:
        return _customRoute(const OnBoradingView(), settings: routeSettings);
      case welcome:
        return _customRoute(const WelcomeView(), settings: routeSettings);
      case welcomeLogin:
        return _customRoute(const WelcomeLoginView(), settings: routeSettings);
      case login:
        return _customRoute(const LoginView(), settings: routeSettings);
      case register:
        return _customRoute(const RegisterView(), settings: routeSettings);
      case otp:
        return _customRoute(const OtpView(), settings: routeSettings);
      case forgetPassword:
        return _customRoute(const ForgetPasswrordView(), settings: routeSettings);
      case newPassword:
        return _customRoute(const NewPasswordView(), settings: routeSettings);
      case aiQuiz:
        return _customRoute(const AiQuizView(), settings: routeSettings);
      case aiQuizOnBorading:
        return _customRoute(const QuizOnboradingView(), settings: routeSettings);
      case aiAnalysis:
        return _customRoute(const AiAnalysisView(), settings: routeSettings);
      case appPlan:
        return _customRoute(const AppPlanView(), settings: routeSettings);
      case home:
        return _customRoute(const HomeView(), settings: routeSettings);
      case notifaction:
        return _customRoute(const NotificaionView(), settings: routeSettings);
      case chatBot:
        return _customRoute(const ChatBotPage(), settings: routeSettings);
      case settings:
        return _customRoute(const SettingsScreen(), settings: routeSettings);
      case challenges:
        return _customRoute(const ChallengesScreen(), settings: routeSettings);
      case tests:
        return _customRoute(const TestsScreen(), settings: routeSettings);
      case pro:
        return _customRoute(const ProContentScreen(), settings: routeSettings);
      case favorites:
        return _customRoute(const FavoritesScreen(), settings: routeSettings);
      case trackMode:
        return _customRoute(const ProfileTrackModeView(), settings: routeSettings);
      case cinema:
        return _customRoute(const CinemaEtmaen(), settings: routeSettings);
      case cinemaVideo:
        return _customRoute(const CinemaVideoView(), settings: routeSettings);
      case audioPlayer:
        final args = routeSettings.arguments as Map<String, dynamic>?;
        return _customRoute(
          AudioPlayerView(
            title: args?['title'] ?? 'اساسيات العلاج',
            subtitle: args?['subtitle'] ?? 'مستوى 1',
          ),
          settings: routeSettings,
        );
      case learning:
        return _customRoute(const LearningView(), settings: routeSettings);
      case categoryDetail:
        final title = routeSettings.arguments as String? ?? 'الاكتئاب';
        return _customRoute(CategoryDetailView(categoryTitle: title), settings: routeSettings);
      case exercise:
        return _customRoute(const ExerciseView(), settings: routeSettings);
      case videoList:
        final title = routeSettings.arguments as String? ?? '';
        return _customRoute(VideoListView(categoryTitle: title), settings: routeSettings);
      case articleDetail:
        final title = routeSettings.arguments as String? ?? '';
        return _customRoute(ArticleDetailView(categoryTitle: title), settings: routeSettings);
      default:
        return _customRoute(const Scaffold(), settings: routeSettings);
    }
  }
}
