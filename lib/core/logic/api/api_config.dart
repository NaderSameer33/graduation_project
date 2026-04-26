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
  // ← PASTE YOUR API URL HERE
  static const String baseUrl = '';

  // ── Endpoints ────────────────────────────────
  // Add any new endpoint here. The UI reads data
  // dynamically, so adding a key is all you need.
  static const Map<String, String> endpoints = {
    'doctors':          '/api/doctors',
    'doctor_detail':    '/api/doctors/{id}',
    'challenges':       '/api/challenges',
    'challenge_detail': '/api/challenges/{id}',
    'tests':            '/api/tests',
    'test_result':      '/api/tests/{id}/result',
    'profile':          '/api/profile',
    'profile_update':   '/api/profile/update',
    'favorites':        '/api/favorites',
    'payment_cards':    '/api/payment/cards',
    'payment_charge':   '/api/payment/charge',
    'login':            '/api/auth/login',
    'register':         '/api/auth/register',
    'logout':           '/api/auth/logout',
  };

  // ── Default headers ──────────────────────────
  // These are merged with every request. Add
  // custom headers here (e.g. API keys).
  static Map<String, String> get defaultHeaders => {
    'Content-Type': 'application/json',
    'Accept':       'application/json',
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
