// ─────────────────────────────────────────────
//  api_config.dart
//  ─────────────────────────────────
//  HOW TO USE:
//  1. Set `baseUrl` to your API's root URL.
//  2. Add/remove endpoints in the `endpoints` map.
//  3. Done — ApiService reads everything from here.
//     No other files need to change.
// ─────────────────────────────────────────────

class ApiConfig {
  ApiConfig._();

  // ── Base URL ─────────────────────────────────
  static const String baseUrl = 'http://mental-health3.runasp.net';

  // ── Endpoints ────────────────────────────────
  // Add any new endpoint here. The UI reads data
  // dynamically, so adding a key is all you need.
  static const Map<String, String> endpoints = {
    // Auth
    'login': '/api/Auth/login',
    'register': '/api/Auth/register',
    'forgot_password': '/api/Auth/forgot-password',
    'verify_otp': '/api/Auth/verify-otp',
    'reset_password': '/api/Auth/reset-password',

    // Doctors
    'doctors': '/api/Doctor',
    'doctor_detail': '/api/Doctor/{id}',

    // Patient
    'profile_update_name': '/update-name',
    'profile_update_email': '/update-email',
    'profile_change_password': '/change-password',
    'profile_update_image': '/update-image',
    'deactivate': '/deactivate',
    'favorites': '/favorites',
    'favorite_toggle': '/favorite/{id}',
    'doctor_search': '/api/Doctor/search',
    'notifications': '/my-notifications',
    'messages': '/my-messages',
    'quizzes': '/api/patient/quizzes',
    'quiz_detail': '/api/patient/quizzes/{id}',
    'patient_articles': '/api/patient/articles/{id}',

    // Admin / Content
    'challenges': '/api/admin/challenges',
    'articles': '/api/admin/articles',
    'podcasts': '/api/admin/podcasts',
    'videos': '/api/admin/videos',

    // Legacy / Generic placeholders
    'tests': '/api/tests',
    'profile': '/api/profile',
    'logout': '/api/auth/logout',

    // Chatbot
    'chat_send': '/api/Chat/send',
  };

  // ── Default headers ──────────────────────────
  // These are merged with every request. Add
  // custom headers here (e.g. API keys).
  static Map<String, String> get defaultHeaders => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  // ── Timeouts ─────────────────────────────────
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // ── Endpoint helper ──────────────────────────
  /// Returns full URL for [key], replacing {id} if provided.
  /// Example: ApiConfig.url('doctor_detail', id: '42')
  static String url(String key, {String? id}) {
    final path = endpoints[key] ?? '/$key';
    final resolved = id != null ? path.replaceAll('{id}', id) : path;
    return '$baseUrl$resolved';
  }

  /// Returns true if the base URL has been configured.
  static bool get isConfigured => baseUrl.isNotEmpty;
}
